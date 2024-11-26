import 'package:drf/models/drf_model.dart';
import 'package:drf/services/services.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // List<DrfModel> drfModel = [];

  // --If you use FutureBuilder,
  //     you don't need to manually write the initState method to fetch the data.
  //     The FutureBuilder takes care of initiating the async operation
  //     (like calling fetchData()) and rebuilding the UI based on the future's state
  //     (loading, completed, or error). --

  // @override
  // void initState() {
  //   fetchData().then((fetchList) {
  //     setState(() {
  //       drfModel = fetchList;
  //     });
  //   });
  //   super.initState();
  // }

  // Function to refresh the data
  Future<void> _onRefresh(BuildContext context) async {
    // Triggering a refresh by reloading the data
    await fetchData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("DRF list"),
        centerTitle: true,
      ),
      body: FutureBuilder<List<DrfModel>>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 10),
                  Text('Loading...'),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            // return error if there is error
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            // Handle empty data
            return const Center(
              child: Text("No Data Available"),
            );
          } else {
            // Data is available and ready to display
            final List<DrfModel> drfModel = snapshot.data!;
            // this is RefreshIndicator
            return RefreshIndicator(
              onRefresh: () => _onRefresh(context),
              child: ListView.builder(
                itemCount: drfModel.length,
                itemBuilder: (context, index) {
                  final drfItems = drfModel[index];
                  return Card(
                    child: ListTile(
                      leading: SizedBox(
                        height: 40,
                        width: 40,
                        child: Image.network(
                          drfItems.profilePic,
                          fit: BoxFit.cover,
                        ),
                      ),
                      title: Text(
                        drfItems.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        drfItems.description,
                        style: const TextStyle(fontSize: 15),
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}



/** 
 * this is old version of code without FutureBuilder
 */

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   List<DrfModel> drfModel = [];

//   @override
//   void initState() {
//     fetchData().then((fetchList) {
//       setState(() {
//         drfModel = fetchList;
//       });
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("DRF list"),
//         centerTitle: true,
//       ),
//       body: drfModel.isEmpty
//           ? const Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   CircularProgressIndicator(),
//                   SizedBox(height: 10),
//                   Text('Loading...'),
//                 ],
//               ),
//             )
//           : ListView.builder(
//               itemCount: drfModel.length,
//               itemBuilder: (context, index) {
//                 final drfItems = drfModel[index];
//                 return Card(
//                   child: ListTile(
//                     leading: Text(
//                       drfItems.id.toString(),
//                       style: TextStyle(fontSize: 20),
//                     ),
//                     title: Text(
//                       drfItems.name,
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     subtitle: Text(
//                       drfItems.description,
//                       style: TextStyle(fontSize: 15),
//                     ),
//                     trailing: Text(
//                       drfItems.status,
//                       style: TextStyle(
//                         fontSize: 13,
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }
