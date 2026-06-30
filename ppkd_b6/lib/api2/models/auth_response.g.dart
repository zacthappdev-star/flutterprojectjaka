// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthResponse _$AuthResponseFromJson(Map<String, dynamic> json) => AuthResponse(
  message: json['message'] as String,
  errors: Errors.fromJson(json['errors'] as Map<String, dynamic>),
);

Map<String, dynamic> _$AuthResponseToJson(AuthResponse instance) =>
    <String, dynamic>{'message': instance.message, 'errors': instance.errors};

Errors _$ErrorsFromJson(Map<String, dynamic> json) => Errors(
  name: (json['name'] as List<dynamic>).map((e) => e as String).toList(),
  email: (json['email'] as List<dynamic>).map((e) => e as String).toList(),
  password: (json['password'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$ErrorsToJson(Errors instance) => <String, dynamic>{
  'name': instance.name,
  'email': instance.email,
  'password': instance.password,
};
