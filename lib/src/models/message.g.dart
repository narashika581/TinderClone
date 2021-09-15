// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) {
  return Message()
    ..message = json['message'] as String
    ..to = json['to'] as String
    ..from = json['from'] as String
    ..deleted = json['deleted'] as bool
    ..epochTime = json['epoch_time'] as int;
}

Map<String, dynamic> _$MessageToJson(Message instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('message', instance.message);
  writeNotNull('to', instance.to);
  writeNotNull('from', instance.from);
  writeNotNull('deleted', instance.deleted);
  writeNotNull('epoch_time', instance.epochTime);
  return val;
}
