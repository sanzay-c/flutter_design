import 'package:firebase_database/firebase_database.dart';
import 'package:social_media_app/features/profile/domain/entities/profile_user.dart';
import 'package:social_media_app/features/profile/domain/repos/profile_repo.dart';

class FirebaseProfileRepos implements ProfileRepo {
  final DatabaseReference firebaseDatabase = FirebaseDatabase.instance.ref();

  @override
  Future<ProfileUser?> fetchUserProfile(String uid) async {
    try {
      // Get the user document from Firebase database
      final userDoc = await firebaseDatabase.child('users').child(uid).once();

      if (userDoc.snapshot.exists) {
        final userData = userDoc.snapshot.value as Map<dynamic, dynamic>?;

        if (userData != null) {
          print('User data: $userData'); // Log the fetched data

          // fetch the followers and following
          final followers = List<String>.from(userData['followers'] ?? []);
          final following = List<String>.from(userData['following'] ?? []);

          return ProfileUser(
            uid: uid,
            email: userData['email'] as String? ?? '', // Provide default value
            name: userData['name'] as String? ?? '', // Provide default value
            bio: userData['bio'] as String? ?? '', // Provide default value
            profileImageUrl: userData['profileImageUrl']?.toString() ??
                '', // Default to empty string if null
            followers: followers,
            following: following,
          );
        }
      }
      return null; // Return null if user does not exist or data is null
    } catch (e) {
      // Handle exceptions (e.g., log the error)
      print('Error fetching user profile: $e');
      return null;
    }

    // try { // this is for firestore database
    //   // get the user document from firebase database
    //   final userDoc = await fireabaseFirestore.collection('users').doc(uid).get();

    //   if(userDoc.exists){
    //     final userData = userDoc.data();
    //     if(userData != null){
    //       return ProfileUser(uid: uid, email: userData['email'], name: userData['name'], bio: userData['bio'], profileImageUrl: userData['profileImageUrl'].toString(),);
    //     }
    //   }
    //   return null;
    // } catch (e) {
    //   return null;
    // }
  }

  @override
  Future<void> updateProfile(ProfileUser updatedProfile) async {
    try {
      // Convert updated profile to JSON and update in Firebase Realtime Database
      await firebaseDatabase
          .child('users') // Access the 'users' node
          .child(updatedProfile.uid) // Specify the user by UID
          .update({
        'bio': updatedProfile.bio, // Update the bio field
        'profileImageUrl':
            updatedProfile.profileImageUrl, // Update the profile image URL
      });
    } catch (e) {
      // Handle exceptions (e.g., log the error)
      print('Error updating profile: $e');
      throw Exception(
          'Failed to update profile: $e'); // Rethrow the exception with a custom message
    }
    // try { // this code is for firebase firestore
    //   // convert updated profile to json to store in firebase database
    //   await firebaseDatabase.collection('users').doc(updatedProfile.uid).update({
    //     'bio': updatedProfile.bio,
    //     'profileImageUrl' : updatedProfile.profileImageUrl,

    //   });
    // } catch (e) {
    //   throw Exception(e);
    // }
  }

  @override
  Future<void> toggleFollow(String currentUid, String targetUid) async {
    try {
      final currentUserRef = firebaseDatabase.child('users').child(currentUid);
      final targetUserRef = firebaseDatabase.child('users').child(targetUid);

      // Fetch current user's data
      final currentUserSnapshot = await currentUserRef.once();
      final targetUserSnapshot = await targetUserRef.once();

      if (currentUserSnapshot.snapshot.exists &&
          targetUserSnapshot.snapshot.exists) {
        final currentUserData =
            currentUserSnapshot.snapshot.value as Map<dynamic, dynamic>;
        final targetUserData =
            targetUserSnapshot.snapshot.value as Map<dynamic, dynamic>;

        final List<String> currentFollowing =
            List<String>.from(currentUserData['following'] ?? []);
        final List<String> targetFollowers =
            List<String>.from(targetUserData['followers'] ?? []);

        if (currentFollowing.contains(targetUid)) {
          // Unfollow: remove targetUid from current user's following list and currentUid from target user's followers list
          currentFollowing.remove(targetUid);
          targetFollowers.remove(currentUid);

          await currentUserRef.update({'following': currentFollowing});
          await targetUserRef.update({'followers': targetFollowers});
        } else {
          // Follow: add targetUid to current user's following list and currentUid to target user's followers list
          currentFollowing.add(targetUid);
          targetFollowers.add(currentUid);

          await currentUserRef.update({'following': currentFollowing});
          await targetUserRef.update({'followers': targetFollowers});
        }
      }
    } catch (e) {
      throw Exception("Failed to toggle follow: $e");
    }
  }
}
