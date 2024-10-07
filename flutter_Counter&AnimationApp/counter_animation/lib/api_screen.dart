import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class APIScreen extends StatefulWidget {
  const APIScreen({super.key});

  @override
  State<APIScreen> createState() => _APIScreenState();
}

class _APIScreenState extends State<APIScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<void> fetchApi() async{
    var request = http.Request(
      "GET", Uri.parse("https://jsonplaceholder.typicode.com/tods/1")
    );
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200){
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text('hello')
          ],
        ),
      ),
    );
  }
}