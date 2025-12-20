import 'package:posts_app/features/upload-image/data/data_source/upload_datasource.dart';
import 'package:posts_app/features/upload-image/domain/entities/upload_entity.dart';
import 'package:posts_app/features/upload-image/domain/repository/upload_repo.dart';

class RepoImpl implements UploadRepo {
  final UploadDatasource datasource;

  RepoImpl(this.datasource);

  @override
  Stream<double> uploadImage(UploadEntity image) {
    return datasource.upload(image.path);
  }
}