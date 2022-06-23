import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPrefs extends ChangeNotifier {
  SharedPreferences? prefs;
  LoginPrefs(this.prefs) {
    //print(prefs);
  }
}
