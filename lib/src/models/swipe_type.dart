import 'package:json_annotation/json_annotation.dart';

enum SwipeType {
  @JsonValue(0)
  LIKE,

  @JsonValue(1)
  UNLIKE,
}

int getSwipeInt(SwipeType s) {
  switch (s) {
    case SwipeType.LIKE:
      return 0;
    case SwipeType.UNLIKE:
      return 1;
  }
}
