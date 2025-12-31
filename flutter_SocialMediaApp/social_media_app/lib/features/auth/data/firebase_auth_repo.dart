import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
import 'package:social_media_app/features/auth/domain/entities/app_user.dart';
import 'package:social_media_app/features/auth/domain/repository/auth_repo.dart';

// Implementation of the AuthRepo interface for Firebase authentication.
class FirebaseAuthRepo implements AuthRepo {
  // Instance of FirebaseAuth to handle authentication operations.
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();
  // final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<AppUser?> loginWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential =
          await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Fetch user document from Firebase Realtime Database
      DatabaseReference userRef =
          FirebaseDatabase.instance.ref('users/${userCredential.user!.uid}');
      DatabaseEvent userEvent = await userRef.once();
      DataSnapshot userSnapshot = userEvent.snapshot;

      //create user
      AppUser user = AppUser(
        uid: userCredential.user!.uid,
        email: email,
        // name: userDoc['name'],
        name: userSnapshot.child('name').value as String,
      );

      //return user
      return user;
    } catch (e) {
      throw Exception('Login Failed: ${e.toString()}');
    }
  }

  @override
  Future<AppUser?> registerWithEmailPassword(
      String name, String email, String password) async {
    try {
      //attempt to sign up
      UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      //create user
      AppUser user = AppUser(
        uid: userCredential.user!.uid,
        email: email,
        name: name,
      );

      // save user data in firebase_database
      // await firebaseFirestore.collection("users").doc(user.uid).set(user.toJson()); // this one is for firestore
      await _databaseReference
          .child("users")
          .child(user.uid)
          .set(user.toJson());

      //return user
      return user;
    } catch (e) {
      throw Exception('Login Failed: ${e.toString()}');
    }
  }

  @override
  Future<void> logout() async {
    await firebaseAuth.signOut();
  }

  @override
  Future<AppUser?> getCurrentUser() async {
    // get current user logged in user from firebase
    final firebaseUser = firebaseAuth.currentUser;

    // no user logged in.
    if (firebaseUser == null) {
      return null;
    }

    // Fetch user data from Firebase Realtime Database
    DatabaseReference userRef =
        FirebaseDatabase.instance.ref('users/${firebaseUser.uid}');
    DatabaseEvent userEvent = await userRef.once();
    DataSnapshot userSnapshot = userEvent.snapshot;

    // Check if userSnapshot exists
    if (!userSnapshot.exists) {
      return null;
    }

    // user exists
    return AppUser(
      uid: firebaseUser.uid,
      email: firebaseUser.email!,
      // name: userDoc['name'],
      name: userSnapshot.child('name').value as String,
    );
  }
}
