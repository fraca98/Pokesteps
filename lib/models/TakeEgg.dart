import 'package:flutter/cupertino.dart';

class TakeEgg extends ChangeNotifier { //to manage if i have already an egg or not

  bool _WalkEgg = false; //false --> i have to take the egg (I have not an egg yet)
  //true --> i want to hatch the egg: show the bar, perform the fecth of data of the pokemon, the button to fetch steps

  bool get WalkEgg => _WalkEgg; //get the actual value of _WalkEgg

  void updateWalkEgg(){
    _WalkEgg = !_WalkEgg; //set the opposite true/false value to _WalkEgg
    //print('_WalkEgg: ${_WalkEgg}');
    notifyListeners();
  }

}