import 'package:social_media_app/features/profile/domain/entities/profile_user.dart';
import 'package:social_media_app/features/search/domain/search_repo.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseSearchRepo implements SearchRepo {
  final DatabaseReference databaseRef = FirebaseDatabase.instance.ref();

  @override
  Future<List<ProfileUser>> searchUser(String query) async {
    try {
      // Retrieve all users from the 'users' node
      final snapshot = await databaseRef.child("users").once();

      if (snapshot.snapshot.value != null) {
        final users = <ProfileUser>[];

        // Check if snapshot value is a Map
        if (snapshot.snapshot.value is Map<dynamic, dynamic>) {
          final usersData = snapshot.snapshot.value as Map<dynamic, dynamic>;
          users.addAll(
            usersData.entries
                .map((entry) => ProfileUser.fromJson(Map<String, dynamic>.from(entry.value)))
                .where((profileUser) => profileUser.name.startsWith(query)),
          );
        } 
        // Check if snapshot value is a List
        else if (snapshot.snapshot.value is List<dynamic>) {
          final usersData = snapshot.snapshot.value as List<dynamic>;
          users.addAll(
            usersData
                .where((user) => user != null) // Filter out any null entries
                .map((user) => ProfileUser.fromJson(Map<String, dynamic>.from(user)))
                .where((profileUser) => profileUser.name.startsWith(query)),
          );
        }
        return users;
      } else {
        return []; // Return an empty list if no users are found
      }
    } catch (e) {
      throw Exception("Error searching users: $e");
    }
  }
}
