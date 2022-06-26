import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPrefs extends ChangeNotifier {
  SharedPreferences? prefs; //used to call sharedpreferences in the LoginPage
  LoginPrefs(this.prefs) {
    //print(prefs);
  }
}
