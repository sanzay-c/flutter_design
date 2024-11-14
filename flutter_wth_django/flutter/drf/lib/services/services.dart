import 'dart:convert';

import 'package:drf/models/drf_model.dart';
import 'package:http/http.dart' as http;

Future<List<DrfModel>> fetchData() async {
  try {
    const baseUrl = 'http://10.0.2.2:8000/api/items/';
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      List<DrfModel> fetchList =
          jsonData.map((item) => DrfModel.fromJson(item)).toList();

      print(response.body);
      return fetchList;
    } else {
      throw Exception("Failed to Load Data");
    }
  } catch (e) {
    throw Exception("Error: $e");
  }
}
