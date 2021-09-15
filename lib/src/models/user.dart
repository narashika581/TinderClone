import 'dart:io';
import 'dart:typed_data';
import 'package:geolocator/geolocator.dart';

import 'package:json_annotation/json_annotation.dart';
import 'package:tinder_clone/src/models/passion_type.dart';
import 'gender_type.dart';

part 'user.g.dart';

@JsonSerializable(includeIfNull: false)
class User {
  @JsonKey(name: "name")
  String name;
  @JsonKey(name: "password")
  String password;
  @JsonKey(name: "phone", nullable: true)
  String phone;
  @JsonKey(name: "id")
  String id;
  @JsonKey(name: "school")
  String school;
  @JsonKey(name: "registered", defaultValue: false)
  bool registered;
  @JsonKey(name: "age", nullable: true)
  int age;
  @JsonKey(name: "gender", nullable: true)
  GenderType gender;
  @JsonKey(name: "interested", nullable: true)
  GenderType interested;
  @JsonKey(name: "passions", nullable: true)
  List<PassionType> passions;
  @JsonKey(name: "images", nullable: true)
  List<String> images;
  @JsonKey(name: "lat", nullable: true)
  double lat;
  @JsonKey(name: "long", nullable: true)
  double long;
  @JsonKey(name: "etime", nullable: true)
  int etime;
//extra for ui
  @JsonKey(name: "dp", ignore: true, nullable: true)
  File dp;
  @JsonKey(ignore: true)
  String active;
  User();

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
