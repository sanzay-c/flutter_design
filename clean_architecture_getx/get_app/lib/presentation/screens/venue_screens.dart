import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_app/presentation/controller/venue_controller.dart';
import 'package:get_app/presentation/widgets/venue_details.dart';

class VenueScreens extends StatefulWidget {
  const VenueScreens({super.key});

  @override
  State<VenueScreens> createState() => _VenueScreensState();
}

class _VenueScreensState extends State<VenueScreens> {
  final VenueController venueController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Venues'),
        centerTitle: true,
      ),
      body: GetBuilder<VenueController>(
        builder: (controller) {
          if (controller.isLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (controller.errorMessage.isNotEmpty) {
            return Center(child: Text(controller.errorMessage));
          }
          if (controller.venues.isEmpty) {
            return Center(child: Text('No Venues Found'));
          }
          return ListView.builder(
            itemCount: controller.venues.length,
            itemBuilder: (context, index) {
              final venue = controller.venues[index];

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Column(
                    children: [
                      Text(venue.name),
                      Text(venue.address),
                      Text(venue.status),
                      ElevatedButton(
                        onPressed: () {
                          Get.to(VenueDetails(venue: venue));
                        },
                        child: Text('View Details'),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
