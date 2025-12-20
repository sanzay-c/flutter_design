import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'news.dart';

class NewsCache {
  static const _key = "cached_news";

  Future<void> save(List<News> news) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList =
        news.map((e) => jsonEncode(e.toMap())).toList();
    await prefs.setStringList(_key, jsonList);
  }

  Future<List<News>> load() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getStringList(_key);

    if (jsonList == null) return [];

    return jsonList
        .map((e) => News.fromMap(jsonDecode(e)))
        .toList();
  }
}
