import 'dart:convert';

class ApiModel {
  final String code;
  final String message;
  final Data data;

  ApiModel({
    required this.code,
    required this.message,
    required this.data,
  });

  factory ApiModel.fromRawJson(String str) =>
      ApiModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ApiModel.fromJson(Map<String, dynamic> json) => ApiModel(
        code: json["code"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  final List<Venue> venues;
  final int currentPage;
  final int totalElements;
  final int totalPages;

  Data({
    required this.venues,
    required this.currentPage,
    required this.totalElements,
    required this.totalPages,
  });

  factory Data.fromRawJson(String str) => Data.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        venues: List<Venue>.from(json["venues"].map((x) => Venue.fromJson(x))),
        currentPage: json["currentPage"],
        totalElements: json["totalElements"],
        totalPages: json["totalPages"],
      );

  Map<String, dynamic> toJson() => {
        "venues": List<dynamic>.from(venues.map((x) => x.toJson())),
        "currentPage": currentPage,
        "totalElements": totalElements,
        "totalPages": totalPages,
      };
}

class Venue {
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

  Venue({
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

  factory Venue.fromRawJson(String str) => Venue.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Venue.fromJson(Map<String, dynamic> json) => Venue(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        description: json["description"],
        status: json["status"],
        startingPrice: json["startingPrice"],
        venueImagePaths:
            List<String>.from(json["venueImagePaths"].map((x) => x)),
        maxCapacity: json["maxCapacity"],
        menuPrice: json["menuPrice"],
        amenities: List<dynamic>.from(json["amenities"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "description": description,
        "status": status,
        "startingPrice": startingPrice,
        "venueImagePaths": List<dynamic>.from(venueImagePaths.map((x) => x)),
        "maxCapacity": maxCapacity,
        "menuPrice": menuPrice,
        "amenities": List<dynamic>.from(amenities.map((x) => x)),
      };
}
