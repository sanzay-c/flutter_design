import 'package:get_app/domain/entities/venue_entity.dart';

abstract class VenueRepository {
  Future<List<VenueEntity>> fetchVenues();
}