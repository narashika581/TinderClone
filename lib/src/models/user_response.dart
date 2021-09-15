import 'package:json_annotation/json_annotation.dart';
import 'package:tinder_clone/src/models/user.dart';

part 'user_response.g.dart';

@JsonSerializable(includeIfNull: false)
class UserResponse {
  @JsonKey(name: "code")
  int code;
  @JsonKey(name: "error", nullable: true)
  String error;
  @JsonKey(name: "result", nullable: true)
  User result;
  UserResponse({this.code, this.error, this.result});

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}
