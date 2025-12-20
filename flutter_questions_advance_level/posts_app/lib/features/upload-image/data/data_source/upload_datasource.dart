class UploadDatasource {
  Stream<double> upload(String path) async* {
    for(int i = 1; i <=10; i++){
      await Future.delayed(Duration(milliseconds: 300));
      yield i / 10;
    }
  }
}