import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:posts_app/features/upload-image/domain/entities/upload_entity.dart';
import 'package:posts_app/features/upload-image/domain/usecases/upload_usecase.dart';

part 'upload_event.dart';
part 'upload_state.dart';

class UploadBloc extends Bloc<UploadEvent, UploadState> {
  final UploadUsecase usecase;

  UploadBloc(this.usecase) : super(UploadInitial()) {
   on<PickImageEvent>(_onPickImage);
    on<UploadImageEvent>(_onUpload);
    on<RetryUploadEvent>(_onRetry);
  }

  FutureOr<void> _onPickImage(PickImageEvent event, Emitter<UploadState> emit) {
        // Fake image picked
    emit(ImagePicked(UploadEntity(path: "fake/path/image.png")));

  }

  FutureOr<void> _onUpload(UploadImageEvent event, Emitter<UploadState> emit) async {
    await emit.forEach<double>(
        usecase(event.image),
        onData: (progress) {
          if (progress >= 1.0) {
            return UploadSuccess();
          }
          return UploadInProgress(progress);
        },
      );
  }

  FutureOr<void> _onRetry(RetryUploadEvent event, Emitter<UploadState> emit) {
    emit(UploadInitial());
  }
}
