// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'status_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatusResponse _$StatusResponseFromJson(Map<String, dynamic> json) {
  return StatusResponse(
    code: json['code'] as int,
    error: json['error'] as String,
  );
}

Map<String, dynamic> _$StatusResponseToJson(StatusResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('code', instance.code);
  writeNotNull('error', instance.error);
  return val;
}
