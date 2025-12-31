import 'package:get_app/data/datasources/data_sources.dart';
import 'package:get_app/domain/entities/venue_entity.dart';
import 'package:get_app/domain/repositories/venue_repository.dart';

class RepositoryImpl implements VenueRepository {
  final DataSources dataSources;

  RepositoryImpl({required this.dataSources});

  @override
  Future<List<VenueEntity>> fetchVenues() async {
    return await dataSources.fetchVenues();
  }
}