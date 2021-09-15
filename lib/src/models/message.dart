import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

@JsonSerializable(includeIfNull: false)
class Message {
  @JsonKey(name: "message")
  String message;
  @JsonKey(name: "to")
  String to;
  @JsonKey(name: "from")
  String from;
  @JsonKey(name: "deleted")
  bool deleted;
  @JsonKey(name: "epoch_time")
  int epochTime;

  Message();

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);
  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
