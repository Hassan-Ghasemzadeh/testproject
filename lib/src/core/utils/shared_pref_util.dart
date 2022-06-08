import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefUtil {
  SharedPreferences? prefs;

  Future<SharedPreferences> getPrefs() async {
    if (prefs != null) {
      return prefs!;
    }
    prefs = await SharedPreferences.getInstance();
    return prefs!;
  }

  Future<void> addString(String name) async {
    SharedPreferences pref = await getPrefs();
    await pref.setString('item', name);
  }

  Future<String> getStringValuesSF() async {
    //Return String
    final pref = await getPrefs();
    String? stringValue = pref.getString('item');
    //if our key's value is null then add this value to
    if (stringValue == null) {
      return 'Local database';
    }
    return stringValue;
  }
}
