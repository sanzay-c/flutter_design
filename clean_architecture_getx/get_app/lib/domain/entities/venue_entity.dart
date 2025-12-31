class VenueEntity {
  final String id;
  final String name;
  final String address;
  final String description;
  final String status;
  final String startingPrice;
  final List<String> venueImagePaths;
  final String maxCapacity;
  final String menuPrice;
  final List<dynamic> amenities;

  VenueEntity({
    required this.id,
    required this.name,
    required this.address,
    required this.description,
    required this.status,
    required this.startingPrice,
    required this.venueImagePaths,
    required this.maxCapacity,
    required this.menuPrice,
    required this.amenities,
  });
}
