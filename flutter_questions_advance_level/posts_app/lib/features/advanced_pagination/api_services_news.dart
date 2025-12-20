import 'package:posts_app/features/advanced_pagination/news.dart';

class ApiServicesNews {
  Future<List<News>> fetchNews({required int page, required int limit, required String query}) async {
    await Future.delayed(Duration(milliseconds: 500));

    if(page > 5) return [];

    final allData =  List.generate(limit, (index) {
      final id = (page - 1) * limit + index;
      return News(id: id, title: "title $id", content: "Content of Post $id");
    },);

    return allData.where((element) => element.title.toLowerCase().contains(query.toLowerCase())).toList();
  }
}