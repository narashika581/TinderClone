import 'package:json_annotation/json_annotation.dart';

enum GenderType {
  @JsonValue(0)
  MAN,

  @JsonValue(1)
  WOMAN,

  @JsonValue(2)
  PRIVATE,
}
