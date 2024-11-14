import 'package:drf/models/drf_model.dart';
import 'package:drf/services/services.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<DrfModel> drfModel = [];

  @override
  void initState() {
    fetchData().then((fetchList) {
      setState(() {
        drfModel = fetchList;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DRF list"),
        centerTitle: true,
      ),
      body: drfModel.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 10),
                  Text('Loading...'),
                ],
              ),
            )
          : ListView.builder(
              itemCount: drfModel.length,
              itemBuilder: (context, index) {
                final drfItems = drfModel[index];
                return Card(
                  child: ListTile(
                    leading: Text(
                      drfItems.id.toString(),
                      style: TextStyle(fontSize: 20),
                    ),
                    title: Text(
                      drfItems.name,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      drfItems.description,
                      style: TextStyle(fontSize: 15),
                    ),
                    trailing: Text(
                      drfItems.status,
                      style: TextStyle(
                        fontSize: 13,
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
