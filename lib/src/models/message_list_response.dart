import 'package:json_annotation/json_annotation.dart';
import 'package:tinder_clone/src/models/message.dart';

part 'message_list_response.g.dart';

@JsonSerializable(includeIfNull: false)
class MessageListResponse {
  @JsonKey(name: "code")
  int code;
  @JsonKey(name: "error", nullable: true)
  String error;
  @JsonKey(name: "result", nullable: true)
  List<Message> result;
  MessageListResponse({this.code, this.error, this.result});

  factory MessageListResponse.fromJson(Map<String, dynamic> json) =>
      _$MessageListResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MessageListResponseToJson(this);
}
