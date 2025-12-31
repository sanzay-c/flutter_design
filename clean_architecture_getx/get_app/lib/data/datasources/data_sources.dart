import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_app/data/models/api_model.dart';
import 'package:get_app/domain/entities/venue_entity.dart';

class DataSources extends GetConnect {
  Future<List<VenueEntity>> fetchVenues() async {
    final response = await get(
      'https://bandobasta.onrender.com/bandobasta/api/v1/venue/findAll',
    );

    if (response.statusCode == 200) {
      log("Response body: ${response.body}");
      log("Response body type: ${response.body.runtimeType}");

      final body = response.body;

      if (body is Map<String, dynamic>) {
        final apiModel = ApiModel.fromJson(body);
        return apiModel.data.venues.map((venue) {
          return VenueEntity(
            id: venue.id,
            name: venue.name,
            address: venue.address,
            description: venue.description,
            status: venue.status,
            startingPrice: venue.startingPrice,
            venueImagePaths: venue.venueImagePaths,
            maxCapacity: venue.maxCapacity,
            menuPrice: venue.menuPrice,
            amenities: venue.amenities,
          );
        }).toList();
      } else {
        throw Exception('Unexpected response body format');
      }
    } else {
      throw Exception("There is an error in fetching the api");
    }
  }
}
