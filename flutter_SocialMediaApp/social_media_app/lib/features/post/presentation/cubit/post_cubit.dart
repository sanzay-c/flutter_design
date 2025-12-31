import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app/features/post/domain/entities/comment.dart';
import 'package:social_media_app/features/post/domain/entities/post.dart';
import 'package:social_media_app/features/post/domain/repos/post_repo.dart';
import 'package:social_media_app/features/storage/domain/storage_repo.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit({required this.postRepo, required this.storageRepo})
      : super(PostInitial());
  final PostRepo postRepo;
  final StorageRepo storageRepo;

  // create a new post
  Future<void> createPost(Post post,
      {String? imagePath, Uint8List? imageBytes}) async {
    String? imageUrl;

    try {
      // handle image upload for mobile platform (using file path)
      if (imagePath != null) {
        emit(PostsUploading());
        imageUrl =
            await storageRepo.uploadPostImageMobile(imagePath, post.id);
      }

      // handle image upload for web platform (using file bytes)
      else if (imageBytes != null) {
        emit(PostsUploading());
        imageUrl = await storageRepo.uploadPostImageWeb(imageBytes, post.id);
      }

      // give imageurl to post
      final newPost = post.copyWith(imageUrl: imageUrl);

      // create post in the backend
      postRepo.createpost(newPost);

      // re-fetch all posts
      fetchAllPost();
    } catch (e) {
      emit(PostsError("Failed to create post: $e"));
    }
  }

  // fetch all post
  Future<void> fetchAllPost() async {
    try {
      emit(PostsLoading());
      final posts = await postRepo.fetchAllPost();
      emit(PostsLoaded(posts));
    } catch (e) {
      emit(PostsError("Failed to fetch posts: $e"));
    }
  }

  // delete a post
  Future<void> deletePost(String postId) async {
    try {
      await postRepo.deletePost(postId);
    } catch (e) {}
  }

  // toggle like on a post
  Future<void> toggleLikePost(String postId, String userId) async {
    try {
      await postRepo.toggleLikePost(postId, userId);
      // fetchAllPost();
    } catch (e) {
      emit(PostsError("Failed to toggle like: $e"));
    }
  }

  // add a new comment to a post
  Future<void> addComment(String postId, Comment comment) async {
    try {
      await postRepo.addComment(postId, comment);

      await fetchAllPost();
    } catch (e) {
      emit(PostsError("Failed to add commnet: $e"));
    }
  }

  // delete a comment froam a post
  Future<void> deleteComment(String postId, String commentId) async {
    try {
      await postRepo.deleteComment(postId, commentId);

      await fetchAllPost();
    } catch (e) {
      emit(PostsError("Failed to delete a post: $e"));
    }
  }
}
