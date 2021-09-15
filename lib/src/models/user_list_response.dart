import 'package:json_annotation/json_annotation.dart';
import 'package:tinder_clone/src/models/user.dart';

part 'user_list_response.g.dart';

@JsonSerializable(includeIfNull: false)
class UserListResponse {
  @JsonKey(name: "code")
  int code;
  @JsonKey(name: "error", nullable: true)
  String error;
  @JsonKey(name: "result", nullable: true)
  List<User> result;
  UserListResponse({this.code, this.error, this.result});

  factory UserListResponse.fromJson(Map<String, dynamic> json) =>
      _$UserListResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UserListResponseToJson(this);
}
