import 'package:posts_app/features/upload-image/domain/entities/upload_entity.dart';
import 'package:posts_app/features/upload-image/domain/repository/upload_repo.dart';

class UploadUsecase {
  final UploadRepo uploadRepo;

  UploadUsecase( this.uploadRepo);

  Stream<double> call(UploadEntity image) {
    return uploadRepo.uploadImage(image);
  }
}