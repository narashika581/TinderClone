// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserResponse _$UserResponseFromJson(Map<String, dynamic> json) {
  return UserResponse(
    code: json['code'] as int,
    error: json['error'] as String,
    result: json['result'] == null
        ? null
        : User.fromJson(json['result'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UserResponseToJson(UserResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('code', instance.code);
  writeNotNull('error', instance.error);
  writeNotNull('result', instance.result);
  return val;
}
