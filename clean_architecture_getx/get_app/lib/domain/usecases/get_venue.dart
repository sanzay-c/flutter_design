import 'package:get_app/domain/entities/venue_entity.dart';
import 'package:get_app/domain/repositories/venue_repository.dart';

class GetVenue {
  final VenueRepository repository;

  GetVenue({required this.repository});

  Future<List<VenueEntity>> call() async {
    return await repository.fetchVenues();
  }
}