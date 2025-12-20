// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Data {
  final int id;
  final String name;
  final int age;
  final String address;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'age': age,
      'address': address,
    };
  }

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
      id: map['id'] as int,
      name: map['name'] as String,
      age: map['age'] as int,
      address: map['address'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Data.fromJson(String source) =>
      Data.fromMap(json.decode(source) as Map<String, dynamic>);

  Data({
    required this.id,
    required this.name,
    required this.age,
    required this.address,
  });

  Data copyWith({
    int? id,
    String? name,
    int? age,
    String? address,
  }) {
    return Data(
      id: id ?? this.id,
      name: name ?? this.name,
      age: age ?? this.age,
      address: address ?? this.address,
    );
  }
}
