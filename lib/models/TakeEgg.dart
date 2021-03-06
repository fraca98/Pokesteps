import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TakeEgg extends ChangeNotifier {
  //to manage if i have already an egg or not

  SharedPreferences? prefs;
  late bool _WalkEgg;

  TakeEgg(this.prefs) {
    //constructor for TakeEgg
    _WalkEgg = prefs?.getBool('_WalkEgg') ??
        false; //retrieve the value of _WalkEgg, if null set it to false
  }
  //bool _WalkEgg = false; //false: not showing the bar--> i have to take the egg
  //true: i want to hatch the egg: show the bar, perform the fecth of data, the button to fetch steps

  bool get getWalkEgg => _WalkEgg; //get the actual value of _WalkEgg

  Future<void> updateWalkEgg() async {
    _WalkEgg = !_WalkEgg; //set the other true/false value
    //print('_WalkEgg: ${_WalkEgg}');
    await prefs?.setBool('_WalkEgg', _WalkEgg);

    notifyListeners();
  }

  Future<void> tofalse() async { //set _WalkEgg to false --> used when i want to delete the account (i need to reset it cause a new user needs a new egg)
    _WalkEgg = false;
    await prefs?.setBool('_WalkEgg', false);
    notifyListeners();
  }
}
