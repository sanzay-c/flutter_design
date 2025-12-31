part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

// loading ... 
class ProfileLoading extends ProfileState {}

// State representing a successfully loaded profile
class ProfileLoaded extends ProfileState {
  // The user profile data
  final ProfileUser profileUser;

  // Constructor to initialize the profileUser
  ProfileLoaded(this.profileUser);
}

// State representing an error while loading the profile
class ProfileError extends ProfileState {
  // Error message describing what went wrong
  final String message;

  // Constructor to initialize the error message
  ProfileError(this.message);
}
