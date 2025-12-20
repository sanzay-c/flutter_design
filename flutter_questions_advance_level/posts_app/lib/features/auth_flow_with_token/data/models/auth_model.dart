// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:posts_app/features/auth_flow_with_token/domain/entity/auth_entity.dart';

class AuthModel {
  final String accessToken;
  final String refrehToken;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'accessToken': accessToken,
      'refrehToken': refrehToken,
    };
  }

  factory AuthModel.fromMap(Map<String, dynamic> map) {
    return AuthModel(
      accessToken: map['access_token'],
      refrehToken: map['refresh_token'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      accessToken: json['access_token'],
      refrehToken: json['refresh_token'],
    );
  }

  AuthModel({required this.accessToken, required this.refrehToken});

  AuthEntity toEntity() {
    return AuthEntity(accessToken: accessToken, refreshToken: refrehToken);
  }
}
