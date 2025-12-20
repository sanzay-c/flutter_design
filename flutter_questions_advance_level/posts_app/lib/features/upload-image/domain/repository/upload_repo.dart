import 'package:posts_app/features/upload-image/domain/entities/upload_entity.dart';

abstract class UploadRepo {
  Stream<double> uploadImage(UploadEntity image);
}