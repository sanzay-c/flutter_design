part of 'upload_bloc.dart';

@immutable
sealed class UploadState {}

final class UploadInitial extends UploadState {}

class ImagePicked extends UploadState {
  final UploadEntity image;
  ImagePicked(this.image);
}

class UploadInProgress extends UploadState {
  final double progress;
  UploadInProgress(this.progress);
}

class UploadSuccess extends UploadState {}

class UploadFailure extends UploadState {
  final String error;
  UploadFailure(this.error);
}
