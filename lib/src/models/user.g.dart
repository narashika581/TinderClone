// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User()
    ..name = json['name'] as String
    ..password = json['password'] as String
    ..phone = json['phone'] as String
    ..id = json['id'] as String
    ..school = json['school'] as String
    ..registered = json['registered'] as bool ?? false
    ..age = json['age'] as int
    ..gender = _$enumDecodeNullable(_$GenderTypeEnumMap, json['gender'])
    ..interested = _$enumDecodeNullable(_$GenderTypeEnumMap, json['interested'])
    ..passions = (json['passions'] as List)
        ?.map((e) => _$enumDecodeNullable(_$PassionTypeEnumMap, e))
        ?.toList()
    ..images = (json['images'] as List)?.map((e) => e as String)?.toList()
    ..lat = (json['lat'] as num)?.toDouble()
    ..long = (json['long'] as num)?.toDouble()
    ..etime = json['etime'] as int;
}

Map<String, dynamic> _$UserToJson(User instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('name', instance.name);
  writeNotNull('password', instance.password);
  writeNotNull('phone', instance.phone);
  writeNotNull('id', instance.id);
  writeNotNull('school', instance.school);
  writeNotNull('registered', instance.registered);
  writeNotNull('age', instance.age);
  writeNotNull('gender', _$GenderTypeEnumMap[instance.gender]);
  writeNotNull('interested', _$GenderTypeEnumMap[instance.interested]);
  writeNotNull('passions',
      instance.passions?.map((e) => _$PassionTypeEnumMap[e])?.toList());
  writeNotNull('images', instance.images);
  writeNotNull('lat', instance.lat);
  writeNotNull('long', instance.long);
  writeNotNull('etime', instance.etime);
  return val;
}

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$GenderTypeEnumMap = {
  GenderType.MAN: 0,
  GenderType.WOMAN: 1,
  GenderType.PRIVATE: 2,
};

const _$PassionTypeEnumMap = {
  PassionType.Running: 0,
  PassionType.Karoke: 1,
  PassionType.Golf: 2,
  PassionType.Potterhead: 3,
  PassionType.Vlogging: 4,
  PassionType.Cycling: 5,
  PassionType.StandUpComedy: 6,
  PassionType.Astrology: 7,
  PassionType.Sushi: 8,
  PassionType.Cricket: 9,
  PassionType.Brunch: 10,
  PassionType.Surfing: 11,
  PassionType.Poetry: 12,
  PassionType.Athlete: 13,
  PassionType.Party: 14,
  PassionType.Fashion: 15,
  PassionType.DogLover: 16,
  PassionType.Baking: 17,
  PassionType.Anime: 18,
  PassionType.Yoga: 19,
  PassionType.Coffee: 20,
  PassionType.Physics: 21,
  PassionType.Chemistry: 22,
  PassionType.Musician: 23,
  PassionType.Foodie: 24,
  PassionType.Dancing: 25,
  PassionType.Astronomy: 26,
  PassionType.Space: 27,
  PassionType.Vegan: 28,
  PassionType.Photography: 29,
  PassionType.Outdoors: 30,
  PassionType.Cars: 31,
  PassionType.Hiking: 32,
  PassionType.Bollywood: 33,
  PassionType.Climbing: 34,
  PassionType.Gamer: 35,
  PassionType.Trivia: 36,
  PassionType.Art: 37,
  PassionType.WorkingOut: 38,
  PassionType.DIY: 39,
  PassionType.Blogging: 40,
  PassionType.Movies: 41,
  PassionType.Tea: 42,
  PassionType.Writer: 43,
  PassionType.Gardening: 44,
  PassionType.CatLover: 45,
  PassionType.Activism: 46,
  PassionType.Cooking: 47,
  PassionType.Reading: 48,
  PassionType.Sneakers: 49,
  PassionType.Horror: 50,
  PassionType.Dark: 51,
  PassionType.Netflix: 52,
  PassionType.Comedy: 53,
  PassionType.Travel: 54,
  PassionType.Gym: 55,
  PassionType.Voulenteering: 56,
  PassionType.Universe: 57,
  PassionType.Stars: 58,
  PassionType.God: 59,
  PassionType.Coding: 60,
  PassionType.Programming: 61,
  PassionType.Hacking: 62,
  PassionType.Hunting: 63,
  PassionType.Army: 64,
  PassionType.Skiing: 65,
  PassionType.Youtube: 66,
  PassionType.Hollywood: 67,
  PassionType.OneDirection: 51,
  PassionType.Books: 52,
  PassionType.Avengers: 53,
  PassionType.Singing: 54,
};
