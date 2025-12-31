import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:social_media_app/features/auth/domain/entities/app_user.dart';
import 'package:social_media_app/features/auth/domain/repository/auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo; // Repository for authentication-related operations
  AppUser? _currentUser; // Holds the currently authenticated user

  // Constructor that initializes the AuthCubit with the AuthRepo
  AuthCubit({required this.authRepo}) : super(AuthInitial());

  // Checks if there is an authenticated user
  void checkAuth() async {
    final AppUser? user = await authRepo.getCurrentUser();

    // If a user is found, emit the Authenticated state
    if (user != null) {
      _currentUser = user;
      emit(Authenticated(user));
    } else {
      // If no user is found, emit the UnAuthenticated state
      emit(UnAuthenticated());
    }
  }

  // Getter for the current user
  AppUser? get currentUser => _currentUser;

  // Login method that authenticates the user using email and password
  Future<void> login(String email, String password) async {
    try {
      emit(AuthLoading()); // Emit loading state while the login request is processed
      final user = await authRepo.loginWithEmailPassword(email, password);

      // If user login is successful, emit the Authenticated state
      if (user != null) {
        _currentUser = user;
        emit(Authenticated(user));
      } else {
        // If login fails, emit the UnAuthenticated state
        emit(UnAuthenticated());
      }
    } catch (e) {
      // If an error occurs, emit the error state and UnAuthenticated state
      emit(AuthError(e.toString()));
      emit(UnAuthenticated());
    }
  }

  // Register method that creates a new user account
  Future<void> register(String name, String email, String password) async {
    try {
      emit(AuthLoading()); // Emit loading state while the registration request is processed
      final user = await authRepo.registerWithEmailPassword(name, email, password);

      // If registration is successful, emit the Authenticated state
      if (user != null) {
        _currentUser = user;
        emit(Authenticated(user));
      } else {
        // If registration fails, emit the UnAuthenticated state
        emit(UnAuthenticated());
      }
    } catch (e) {
      // If an error occurs, emit the error state and UnAuthenticated state
      emit(AuthError(e.toString()));
      emit(UnAuthenticated());
    }
  }

  // Logout method that logs out the current user
  Future<void> logout() async {
    authRepo.logout(); // Call the repository's logout method
    emit(UnAuthenticated()); // Emit the UnAuthenticated state
  }
}
