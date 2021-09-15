import 'package:shared_preferences/shared_preferences.dart';

class FlutterStorage {
  SharedPreferences _pref;

  Future<bool> ready() async {
    if (_pref != null) return true;
    await setupPreferences();
    return true;
  }

  setupPreferences() async {
    _pref = await SharedPreferences.getInstance();
  }

  String _getItem(String key) {
    if (_pref == null) return null;
    return _pref.getString(key);
  }

  void _setItem(String key, String value) {
    if (_pref == null) return;
    _pref.setString(key, value);
  }

  Iterable<String> get keys {
    if (_pref == null) return [];
    return _pref.getKeys();
  }

  String operator [](Object key) {
    return _getItem(key);
  }

  operator []=(String key, String value) {
    _setItem(key, value);
  }

  String remove(Object key) {
    var ret = _getItem(key);
    if (ret == null) return null;
    _pref.remove(key);
    return ret;
  }

  // The `clear` operation should not be based on `remove`.
  // It should clear the map even if some keys are not equal to themselves.
  void clear() {
    if (_pref == null) return;
    _pref.clear();
  }

  @override
  bool containsKey(String key) {
    return _pref.containsKey(key);
  }
}
