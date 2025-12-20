import 'package:posts_app/features/api_state_handler/model.dart';

class ApiService {
  Future<List<Data>> fetchData() async {
    await Future.delayed(const Duration(seconds: 2));

    return List.generate(
      5,
      (index) => Data(
        id: index,
        name: "User $index",
        age: 20 + index,
        address: "Kathmandu",
      ),
    );

    // Uncomment to test error
    // throw Exception("Network Error");
  }
}
