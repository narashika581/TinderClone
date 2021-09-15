import 'package:intl/intl.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:tinder_clone/src/models/gender_type.dart';
import 'package:tinder_clone/src/models/message.dart';
import 'package:tinder_clone/src/models/message_list_response.dart';
import 'package:tinder_clone/src/models/status_response.dart';
import 'package:tinder_clone/src/models/swipe_type.dart';
import 'package:tinder_clone/src/models/user.dart';
import 'package:tinder_clone/src/models/user_list_response.dart';
import 'package:tinder_clone/src/models/user_response.dart';
import 'package:tinder_clone/src/storage.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart' as syspaths;

class TinderService {
  final String _baseUrl;
  final String _wsBaseUrl;
  final FlutterStorage _storage;
  static final String VERSION = "1.0.0";
  User user = User();
  String pushToken;
  TinderService(this._baseUrl, this._wsBaseUrl, this._storage);

  String readTimestamp(int timestamp) {
    var now = DateTime.now();
    var format = DateFormat('HH:mm a');
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var diff = now.difference(date);
    var time = '';

    if (diff.inSeconds <= 0 ||
        diff.inSeconds > 0 && diff.inMinutes == 0 ||
        diff.inMinutes > 0 && diff.inHours == 0 ||
        diff.inHours > 0 && diff.inDays == 0) {
      time = format.format(date);
    } else if (diff.inDays > 0 && diff.inDays < 7) {
      if (diff.inDays == 1) {
        time = diff.inDays.toString() + ' DAY AGO';
      } else {
        time = diff.inDays.toString() + ' DAYS AGO';
      }
    } else {
      if (diff.inDays == 7) {
        time = (diff.inDays / 7).floor().toString() + ' WEEK AGO';
      } else {
        time = (diff.inDays / 7).floor().toString() + ' WEEKS AGO';
      }
    }

    return time;
  }

  Future<UserListResponse> listMatches() async {
    await this._storage.ready();
    String token = this._storage["jwt"];
    var uri = Uri.parse(_baseUrl + "/get-matches");
    Response response;

    try {
      response = await http.get(
        uri,
        headers: <String, String>{
          "jwt": token,
        },
      );
    } catch (_) {
      return UserListResponse()..code = 500;
    }
    UserListResponse ret = null;
    if (response.statusCode == 200) {
      var k = response.body;
      try {
        ret = UserListResponse.fromJson(json.decode(response.body));
      } catch (_) {
        ret = UserListResponse()..code = 200;
      }
    } else {
      ret = UserListResponse()..code = response.statusCode;
    }
    if (ret.result == null) {
      ret.result = [];
    }
    for (var i = 0; i < ret.result?.length ?? 0; i++) {
      Uint8List bytes = base64.decode(ret.result[i].images[0]);
      final appDir = await syspaths.getTemporaryDirectory();
      File file = File('${appDir.path}list${i}sth.jpg');
      file.writeAsBytes(bytes);
      ret.result[i].dp = file;
      ret.result[i].active = readTimestamp(ret.result[i].etime);
    }
    return ret;
  }

  Future<StatusResponse> sendMessage(Message m) async {
    var uri = Uri.parse(_baseUrl + "/send-message");
    // User form = User()..gender = GenderType.MAN;

    http.Response response;
    m.from = user.id;
    var js = m.toJson();
    print(js);
    try {
      response = await http.post(uri, body: json.encode(m.toJson()));
    } catch (err, s) {
      print(err);
      print(s);
      return StatusResponse()..code = 500;
    }
    StatusResponse ret = StatusResponse();
    ret = StatusResponse.fromJson(json.decode(response.body));

    if (ret.code == 200) {
      await this._storage.ready();
      this._storage["jwt"] = response.headers["jwt"];
      print("jwt written");
    }
    return ret;
  }

  Future<UserResponse> login(String password, String username) async {
    var z = readTimestamp(1622838110);
    var uri = Uri.parse(_baseUrl + "/login");
    Position location = await Geolocator.getLastKnownPosition();
    var form = <String, String>{
      'password': password,
      'username': username,
      'lat': location.latitude.toString(),
      'long': location.longitude.toString(),
    };
    form.removeWhere((_, v) => v == null);

    http.Response response;
    try {
      response = await http.post(uri, body: form);
    } catch (_) {
      return UserResponse()..code = 500;
    }
    UserResponse ret;
    ret = UserResponse.fromJson(json.decode(response.body));
    if (ret.code == 200) {
      this.user = ret.result;
      await this._storage.ready();
      this._storage["jwt"] = response.headers["jwt"];

      print("jwt written");
    }
    return ret;
  }

  Future<MessageListResponse> getMessages(String user1) async {
    var uri = Uri.parse(_baseUrl + "/get-messages");
    var form = <String, String>{
      'user1': user1,
      'user2': user.id,
    };
    // User form = User()..gender = GenderType.MAN;
    form.removeWhere((_, v) => v == null);

    http.Response response;
    try {
      response = await http.post(uri, body: form);
    } catch (err) {
      return MessageListResponse()..code = 500;
    }
    MessageListResponse ret;
    try {
      var dec = json.decode(response.body);
      ret = MessageListResponse.fromJson(dec);
      print("holo");
    } catch (e, st) {
      print(e);
      print(st);
      ret = MessageListResponse()..code = response.statusCode;
    }

    return ret;
  }

  Future<StatusResponse> updateProfile(
      String name, int age, String college) async {
    var uri = Uri.parse(_baseUrl + "/update");
    var form = <String, String>{
      'userId': user.id,
      'name': name,
      'age': age.toString(),
    };
    // User form = User()..gender = GenderType.MAN;
    form.removeWhere((_, v) => v == null);

    http.Response response;
    try {
      response = await http.post(uri, body: form);
    } catch (err) {
      return StatusResponse()..code = 500;
    }
    StatusResponse ret;
    try {
      var dec = json.decode(response.body);
      ret = StatusResponse.fromJson(dec);
      if (ret.code == 200) {
        if (name.trim() != "") {
          user.name = name;
        }
        if (age == 0) {
          user.age = age;
        }
      }
    } catch (e) {
      ret = StatusResponse()..code = (response.statusCode < 300) ? 200 : 401;
    }

    return ret;
  }

  Future<StatusResponse> register(String password, String username) async {
    var uri = Uri.parse(_baseUrl + "/register");
    var form = <String, String>{
      'password': password,
      'username': username,
    };
    // User form = User()..gender = GenderType.MAN;
    form.removeWhere((_, v) => v == null);

    http.Response response;
    try {
      response = await http.post(uri, body: form);
    } catch (err) {
      return StatusResponse()..code = 500;
    }
    StatusResponse ret;
    try {
      try {
        var dec = json.decode(response.body);
        ret = StatusResponse.fromJson(dec);
        print("holo");
      } catch (e) {
        ret = StatusResponse()..code = (response.statusCode < 300) ? 200 : 401;
      }
    } catch (_) {
      ret = StatusResponse()..code = response.statusCode;
    }
    return ret;
  }

  Future<StatusResponse> registerComplete(User u) async {
    var uri = Uri.parse(_baseUrl + "/register-complete");
    // User form = User()..gender = GenderType.MAN;

    http.Response response;
    Position location = await Geolocator.getLastKnownPosition();
    user.lat = location.latitude;
    user.long = location.longitude;
    var js = user.toJson();
    print(js);
    try {
      response = await http.post(uri, body: json.encode(user.toJson()));
    } catch (err, s) {
      print(err);
      print(s);
      return StatusResponse()..code = 500;
    }
    StatusResponse ret = StatusResponse();
    if (response.statusCode == 200) {
      await this._storage.ready();
      this._storage["jwt"] = response.headers["jwt"];
      print("jwt written");
    }
    ret.code = response.statusCode;
    return ret;
  }

  Future<UserListResponse> getUsers() async {
    var uri = Uri.parse(_baseUrl + "/get-users");
    // User form = User()..gender = GenderType.MAN;

    http.Response response;
    Map<String, String> form = {
      "user_id": user.id,
    };
    try {
      response = await http.post(uri, body: form);
    } catch (err, s) {
      print(err);
      print(s);
      return UserListResponse(code: 500);
    }
    UserListResponse ret = UserListResponse();
    if (response.statusCode == 200) {
      await this._storage.ready();
      ret = UserListResponse.fromJson(json.decode(response.body));
    }
    ret.code = response.statusCode;
    for (var i = 0; i < ret.result.length; i++) {
      Uint8List bytes = base64.decode(ret.result[i].images[0]);
      final appDir = await syspaths.getTemporaryDirectory();
      File file = File('${appDir.path}${i}sth.jpg');
      file.writeAsBytes(bytes);
      ret.result[i].dp = file;
      ret.result[i].active = readTimestamp(ret.result[i].etime);
    }
    return ret;
  }

  void swipe(SwipeType s, String userId) async {
    var uri = Uri.parse(_baseUrl + "/swipe");
    var form = <String, String>{
      'for_user_id': userId,
      'user_id': this.user.id,
      'type': getSwipeInt(s).toString(),
    };
    // User form = User()..gender = GenderType.MAN;
    form.removeWhere((_, v) => v == null);
    Response r = await http.post(uri, body: form);
    print("st code " + r.statusCode.toString());
  }

  void logout() async {
    await this._storage.ready();
    this._storage.remove("jwt");
    this.user = null;
  }

  Future<UserResponse> me() async {
    await this._storage.ready();
    String token = this._storage["jwt"];
    Position location = await Geolocator.getLastKnownPosition();
    var uri = Uri.parse(_baseUrl + "/me");
    Response response;
    var form = <String, String>{
      'lat': location.latitude.toString(),
      'long': location.longitude.toString(),
    };
    try {
      response = await http.post(
        uri,
        body: form,
        headers: <String, String>{
          "jwt": token,
        },
      );
    } catch (_) {
      return UserResponse()..code = 500;
    }
    var ret = null;
    if (response.statusCode == 200) {
      var k = response.body;
      try {
        ret = UserResponse.fromJson(json.decode(response.body));
        this.user = ret.result;
      } catch (_) {
        ret = UserResponse()..code = 200;
      }
    } else {
      ret = UserResponse()..code = response.statusCode;
    }

    return ret;
  }
}
