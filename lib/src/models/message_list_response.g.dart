// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageListResponse _$MessageListResponseFromJson(Map<String, dynamic> json) {
  return MessageListResponse(
    code: json['code'] as int,
    error: json['error'] as String,
    result: (json['result'] as List)
        ?.map((e) =>
            e == null ? null : Message.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$MessageListResponseToJson(MessageListResponse instance) {
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
