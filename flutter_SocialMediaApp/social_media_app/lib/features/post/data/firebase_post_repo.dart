import 'package:firebase_database/firebase_database.dart';
import 'package:social_media_app/features/post/domain/entities/comment.dart';
import 'package:social_media_app/features/post/domain/entities/post.dart';
import 'package:social_media_app/features/post/domain/repos/post_repo.dart';

class FirebasePostRepo implements PostRepo {
  final FirebaseDatabase database = FirebaseDatabase.instance;
  final DatabaseReference postsRef =
      FirebaseDatabase.instance.ref().child('posts');

  @override
  Future<void> createpost(Post post) async {
    try {
      await postsRef.child(post.id).set(post.toJson());
    } catch (e) {
      throw Exception("Error creating post: $e");
    }
  }

  @override
  Future<void> deletePost(String postId) async {
    try {
      await postsRef.child(postId).remove();
    } catch (e) {
      throw Exception("Error deleting post: $e");
    }
  }

  @override
  Future<List<Post>> fetchAllPost() async {
    try {
      final snapshot = await postsRef.orderByChild('timestamp').once();
      final postsData = snapshot.snapshot.value as Map<dynamic, dynamic>?;

      if (postsData == null) return []; // Return empty list if no data is found

      final allPosts = postsData.values
          .map((post) => Post.fromJson(Map<String, dynamic>.from(post)))
          .toList();

      allPosts.sort((a, b) =>
          b.timestamp.compareTo(a.timestamp)); // Sort in descending order

      return allPosts;
    } catch (e) {
      throw Exception("Error fetching posts: $e");
    }
  }

  @override
  Future<List<Post>> fetchPostsByUserId(String userId) async {
    try {
      final snapshot =
          await postsRef.orderByChild('userId').equalTo(userId).once();
      final postsData = snapshot.snapshot.value as Map<dynamic, dynamic>?;

      if (postsData == null) return []; // Return empty list if no data is found

      final userPosts = postsData.values
          .map((post) => Post.fromJson(Map<String, dynamic>.from(post)))
          .toList();

      return userPosts;
    } catch (e) {
      throw Exception("Error fetching posts by user: $e");
    }
  }

  @override
  Future<void> toggleLikePost(String postId, String userId) async {
    try {
      // Get the post from Firebase Realtime Database
      final postSnapshot = await postsRef.child(postId).once();

      // Check if the snapshot contains data
      if (postSnapshot.snapshot.value != null) {
        // Deserialize the post data from Firebase snapshot
        final post = Post.fromJson(
            Map<String, dynamic>.from(postSnapshot.snapshot.value as Map));

        // Check if the user has already liked the post
        final hasLiked = post.likes.contains(userId);

        // Update the like list
        if (hasLiked) {
          post.likes.remove(userId); // Unlike the post
        } else {
          post.likes.add(userId); // Like the post
        }

        // Update the post in the Firebase Realtime Database with the new likes list
        await postsRef.child(postId).update({
          'likes': post.likes,
        });
      } else {
        throw Exception("Post not found");
      }
    } catch (e) {
      throw Exception("Error toggling likes: $e");
    }
  }

  @override
  Future<void> addComment(String postId, Comment comment) async {
    try {
      // Get the post snapshot from Firebase Realtime Database
      final postSnapshot = await postsRef.child(postId).once();

      // Check if the post exists
      if (postSnapshot.snapshot.value != null) {
        // Deserialize the post data from Firebase snapshot
        final post = Post.fromJson(
            Map<String, dynamic>.from(postSnapshot.snapshot.value as Map));

        // Create a map for the new comment to be added
        final newCommentMap = comment.toJson();

        // Check if the 'comments' field exists, if not, create it
        final commentsRef = postsRef.child(postId).child('comments');
        if (post.comments.isEmpty) {
          // If there are no comments, we can initialize it as an empty list
          await commentsRef.set([newCommentMap]); // Add first comment directly
        } else {
          // Otherwise, use push() to add a new comment
          final newCommentRef = commentsRef.push();
          await newCommentRef.set(newCommentMap);
        }
      } else {
        throw Exception("Post not found");
      }
    } catch (e) {
      throw Exception("Error adding comment: $e");
    }
  }

  @override
  Future<void> deleteComment(String postId, String commentId) async {
    try {
      // Get the post snapshot from Firebase Realtime Database
      final postSnapshot = await postsRef.child(postId).once();

      // Check if the post exists
      if (postSnapshot.snapshot.value != null) {
        // Ensure comments exist
        final commentsRef = postsRef.child(postId).child('comments');

        // Fetch the comments data
        final commentsSnapshot = await commentsRef.once();

        if (commentsSnapshot.snapshot.value != null) {
          final commentsData = commentsSnapshot.snapshot.value as List<dynamic>;

          // Find the comment with the given commentId and delete it
          for (int i = 0; i < commentsData.length; i++) {
            final comment = commentsData[i];
            if (comment['id'] == commentId) {
              // Delete the comment at the found index
              await commentsRef
                  .child(i.toString())
                  .remove(); // Use index as key
              break; // Exit loop once comment is found and removed
            }
          }
        } else {
          throw Exception("No comments found to delete");
        }
      } else {
        throw Exception("Post not found");
      }
    } catch (e) {
      throw Exception("Error deleting comment: $e");
    }
  }
}
