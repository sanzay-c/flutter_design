import 'package:social_media_app/features/auth/domain/entities/app_user.dart';

class ProfileUser extends AppUser {
  final String bio;
  final String profileImageUrl;
  final List<String> followers;
  final List<String> following;

  ProfileUser({
    required super.uid,
    required super.email,
    required super.name,
    required this.bio,
    required this.profileImageUrl,
    required this.followers,
    required this.following,
  });

  // method to update profile user
  /// Creates a copy of the ProfileUser instance with optional updated fields.
  ProfileUser copyWith({
    String?
        newBio, // Optional new bio for the user. If not provided, the existing bio will be used.
    String?
        newProfileImageUrl, // Optional new profile image URL for the user. If not provided, the existing URL will be used.
    List<String>? newFollowers, // Optional new followers list for the user.
    List<String>? newFollowing, // Optional new following list for the user.
  }) {
    /**
     * "??" null-coalescing operator 
     * If name has a value, displayName will use that value.
     * If name is null, then displayName will be 'Guest'.
     */
    return ProfileUser(
      uid: uid, // Keeps the same user ID.
      email: email, // Keeps the same email address.
      name: name, // Keeps the same name.
      bio: newBio ??
          bio, // Uses newBio if provided; otherwise, retains the existing bio.
      profileImageUrl: newProfileImageUrl ??
          profileImageUrl, // Uses newProfileImageUrl if provided; otherwise, retains the existing URL.
      followers: newFollowers ??
          followers, // Uses newFollowers if provided; otherwise, retains the existing followers list.
      following: newFollowing ??
          following, // Uses newFollowing if provided; otherwise, retains the existing following list.
    );
  }

  // convert profileUser -> json
  Map<String, dynamic> tojson() {
    return {
      'uid': uid,
      'email': email,
      'bio': bio,
      'profileImageUrl': profileImageUrl,
      'followers': followers, // Include followers list in JSON
      'following': following, // Include following list in JSON
    };
  }

  // convert json-> profile user
  factory ProfileUser.fromJson(Map<String, dynamic> json) {
    return ProfileUser(
      uid: json['uid'], // Get the 'uid' from JSON
      email: json['email'], // Get the 'email' from JSON
      bio: json['bio'] ?? '', // Get the 'bio', default to empty string if null
      profileImageUrl: json['profileImageUrl'] ?? '',
      name: json['name'], // Get the 'profileImageUrl', default to empty string if null
      followers: List<String>.from(json['followers'] ?? []), // Parse followers list, default to empty list if null
      following: List<String>.from(json['following'] ?? []), // Parse following list, default to empty list if null
    );
  }
}
