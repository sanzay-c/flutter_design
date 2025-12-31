import 'dart:developer';

import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get_app/domain/entities/venue_entity.dart';
import 'package:get_app/domain/usecases/get_venue.dart';

class VenueController extends GetxController {
  final GetVenue getVenue;

  List<VenueEntity> venues = [];
  bool isLoading = false;
  String errorMessage = '';

  VenueController({required this.getVenue});


  @override
  void onInit() {
    super.onInit();
    fetchVenue();
  }

  Future<void> fetchVenue() async {
    try {
      isLoading = true;
      update();

      venues = await getVenue.call();
      update();
    } catch (e) {
      errorMessage = 'There is an error in the state management: $e';
      log('There is an error in the state management: $e');
      update();
    } finally {
      isLoading = false;
      update();
    }
  }
}
