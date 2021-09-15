import 'package:json_annotation/json_annotation.dart';

enum PassionType {
  @JsonValue(0)
  Running,

  @JsonValue(1)
  Karoke,

  @JsonValue(2)
  Golf,

  @JsonValue(3)
  Potterhead,

  @JsonValue(4)
  Vlogging,

  @JsonValue(5)
  Cycling,

  @JsonValue(6)
  StandUpComedy,

  @JsonValue(7)
  Astrology,

  @JsonValue(8)
  Sushi,

  @JsonValue(9)
  Cricket,

  @JsonValue(10)
  Brunch,

  @JsonValue(11)
  Surfing,

  @JsonValue(12)
  Poetry,

  @JsonValue(13)
  Athlete,

  @JsonValue(14)
  Party,

  @JsonValue(15)
  Fashion,

  @JsonValue(16)
  DogLover,

  @JsonValue(17)
  Baking,

  @JsonValue(18)
  Anime,

  @JsonValue(19)
  Yoga,

  @JsonValue(20)
  Coffee,

  @JsonValue(21)
  Physics,

  @JsonValue(22)
  Chemistry,

  @JsonValue(23)
  Musician,

  @JsonValue(24)
  Foodie,

  @JsonValue(25)
  Dancing,

  @JsonValue(26)
  Astronomy,

  @JsonValue(27)
  Space,
  @JsonValue(28)
  Vegan,
  @JsonValue(29)
  Photography,
  @JsonValue(30)
  Outdoors,
  @JsonValue(31)
  Cars,
  @JsonValue(32)
  Hiking,
  @JsonValue(33)
  Bollywood,
  @JsonValue(34)
  Climbing,
  @JsonValue(35)
  Gamer,
  @JsonValue(36)
  Trivia,
  @JsonValue(37)
  Art,
  @JsonValue(38)
  WorkingOut,
  @JsonValue(39)
  DIY,
  @JsonValue(40)
  Blogging,
  @JsonValue(41)
  Movies,
  @JsonValue(42)
  Tea,
  @JsonValue(43)
  Writer,
  @JsonValue(44)
  Gardening,
  @JsonValue(45)
  CatLover,
  @JsonValue(46)
  Activism,
  @JsonValue(47)
  Cooking,
  @JsonValue(48)
  Reading,
  @JsonValue(49)
  Sneakers,
  @JsonValue(50)
  Horror,
  @JsonValue(51)
  Dark,
  @JsonValue(52)
  Netflix,
  @JsonValue(53)
  Comedy,
  @JsonValue(54)
  Travel,
  @JsonValue(55)
  Gym,
  @JsonValue(56)
  Voulenteering,
  @JsonValue(57)
  Universe,
  @JsonValue(58)
  Stars,
  @JsonValue(59)
  God,
  @JsonValue(60)
  Coding,
  @JsonValue(61)
  Programming,
  @JsonValue(62)
  Hacking,
  @JsonValue(63)
  Hunting,
  @JsonValue(64)
  Army,
  @JsonValue(65)
  Skiing,
  @JsonValue(66)
  Youtube,
  @JsonValue(67)
  Hollywood,
  @JsonValue(51)
  OneDirection,
  @JsonValue(52)
  Books,
  @JsonValue(53)
  Avengers,
  @JsonValue(54)
  Singing,
}

String PassionTypeToLabel(PassionType p) {
  switch (p) {
    case PassionType.Potterhead:
      return "Potterhead";
    case PassionType.Vlogging:
      return "Vlogging";
    case PassionType.Running:
      return "Running";
    case PassionType.Anime:
      return "Anime";
    case PassionType.Astrology:
      return "Astrology";
    case PassionType.Baking:
      return "Baking";
    case PassionType.Athlete:
      return "Athlete";
    case PassionType.Brunch:
      return "Brunch";
    case PassionType.Chemistry:
      return "Chemistry";
    case PassionType.Karoke:
      return "Karoke";
    case PassionType.Coffee:
      return "Coffee";
    case PassionType.Foodie:
      return "Foodie";
    case PassionType.Musician:
      return "Musician";
    case PassionType.Physics:
      return "Physics";
    case PassionType.Yoga:
      return "Yoga";
    case PassionType.StandUpComedy:
      return "StandUpComedy";
    case PassionType.Sushi:
      return "Sushi";
    case PassionType.Cricket:
      return "Cricket";
    case PassionType.Poetry:
      return "Poetry";
    case PassionType.Party:
      return "Party";
    case PassionType.Surfing:
      return "Surfing";
    case PassionType.DogLover:
      return "DogLover";
    case PassionType.Golf:
      return "Golf";
      break;
    case PassionType.Cycling:
      return "Cycling";
      break;
    case PassionType.Fashion:
      return "Fashion";
      break;
    case PassionType.Dancing:
      return "Dancing";
      break;
    case PassionType.Astronomy:
      return "Astronomy";
      break;
    case PassionType.Space:
      return "Space";
      break;
    case PassionType.Vegan:
      return "Vegan";
      break;
    case PassionType.Photography:
      return "Photography";
      break;
    case PassionType.Outdoors:
      return "Outdoors";
      break;
    case PassionType.Cars:
      return "Cars";
      break;
    case PassionType.Hiking:
      return "Hiking";
      break;
    case PassionType.Bollywood:
      return "Bollywood";
      break;
    case PassionType.Climbing:
      return "Climbing";
      break;
    case PassionType.Gamer:
      return "Gamer";
      break;
    case PassionType.Trivia:
      return "Trivia";
      // TODO: Handle this case.
      break;
    case PassionType.Art:
      return "Art";
      // TODO: Handle this case.
      break;
    case PassionType.WorkingOut:
      return "WorkingOut";
      // TODO: Handle this case.
      break;
    case PassionType.DIY:
      return "DIY";
      // TODO: Handle this case.
      break;
    case PassionType.Blogging:
      return "Blogging";

      break;
    case PassionType.Movies:
      return "Movies";

      break;
    case PassionType.Tea:
      return "Tea";

      break;
    case PassionType.Writer:
      return "Writer";

      break;
    case PassionType.Gardening:
      return "Gardening";

      break;
    case PassionType.CatLover:
      return "CatLover";

      break;
    case PassionType.Activism:
      return "Activism";

      break;
    case PassionType.Cooking:
      return "Cooking";

      break;
    case PassionType.Reading:
      return "Reading";

      break;
    case PassionType.Sneakers:
      return "Sneakers";

      break;
    case PassionType.Horror:
      return "Horror";

      break;
    case PassionType.Dark:
      return "Dark";

      break;
    case PassionType.Netflix:
      return "Netflix";

      break;
    case PassionType.Comedy:
      return "Comedy";

      break;
    case PassionType.Travel:
      return "Travel";

      break;
    case PassionType.Gym:
      return "Gym";
      // TODO: Handle this case.
      break;
    case PassionType.Voulenteering:
      return "Voulenteering";
      // TODO: Handle this case.
      break;
    case PassionType.Universe:
      return "Universe";

      break;
    case PassionType.Stars:
      return "Stars";

      break;
    case PassionType.God:
      return "God";

      break;
    case PassionType.Coding:
      return "Coding";

      break;
    case PassionType.Programming:
      return "Programming";

      break;
    case PassionType.Hacking:
      return "Hacking";

      break;
    case PassionType.Hunting:
      return "Hunting";

      break;
    case PassionType.Army:
      return "Army";

      break;
    case PassionType.Skiing:
      return "Skiing";

      break;
    case PassionType.Youtube:
      return "Youtube";

      break;
    case PassionType.Hollywood:
      return "Hollywood";

      break;
    case PassionType.OneDirection:
      return "OneDirection";

      break;
    case PassionType.Books:
      return "Books";

      break;
    case PassionType.Avengers:
      return "Avengers";

      break;
    case PassionType.Singing:
      return "Singing";

      break;
  }

  List<String> PassionArraytoJson(List<PassionType> passionsTypes) {
    List<int> passionInt;
    passionsTypes.forEach((element) {
      // passionInt.add(element)
    });
  }

  ;
}
