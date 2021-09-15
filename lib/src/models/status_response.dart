import 'package:json_annotation/json_annotation.dart';

part 'status_response.g.dart';

@JsonSerializable(includeIfNull: false)
class StatusResponse {
  @JsonKey(name: "code")
  int code;
  @JsonKey(name: "error", nullable: true)
  String error;

  StatusResponse({this.code, this.error});

  dynamic fromJson(Map<String, dynamic> json) {
    this.code = json['code'];
    this.error = json['error'];
  }

  factory StatusResponse.fromJson(Map<String, dynamic> json) {
    return StatusResponse(
      code: json["code"],
      error: json["error"],
    );
  }
}
