part of 'upload_bloc.dart';

@immutable
sealed class UploadEvent {}

class PickImageEvent extends UploadEvent {}

class UploadImageEvent extends UploadEvent {
  final UploadEntity image;
  UploadImageEvent(this.image);
}

class RetryUploadEvent extends UploadEvent {}