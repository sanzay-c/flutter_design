
import 'package:posts_app/features/api_state_handler/model.dart';

class ApiServiceDebounce {
  Future<List<Data>> fetchData(String query) async {
    await Future.delayed(const Duration(seconds: 1));

    // Fake data filtered by query
    final allData = List.generate(
      10,
      (index) => Data(
        id: index,
        name: "User $index",
        age: 20 + index,
        address: "Kathmandu",
      ),
    );

    return allData
        .where((element) => element.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    // Uncomment to simulate error
    // throw Exception("Network error!");
  }
}

