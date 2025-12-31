import 'package:get/get.dart';
import 'package:get_app/data/datasources/data_sources.dart';
import 'package:get_app/data/repositories/repository_impl.dart';
import 'package:get_app/domain/repositories/venue_repository.dart';
import 'package:get_app/domain/usecases/get_venue.dart';
import 'package:get_app/presentation/controller/venue_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    // DataSources
    Get.lazyPut(() => DataSources());

    // Repository
    Get.lazyPut<VenueRepository>(() => RepositoryImpl(dataSources: Get.find()));

    // UseCase
    Get.lazyPut(() => GetVenue(repository: Get.find()));

    // Controller
    Get.lazyPut(() => VenueController(getVenue: Get.find()));
  }
}