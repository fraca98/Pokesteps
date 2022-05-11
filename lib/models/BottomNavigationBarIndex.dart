import 'package:flutter/material.dart';

class BottomNavigationBarIndex extends ChangeNotifier {
  int _pageSelectionIndex = 0; // index value to select body of scaffold
  // initally it's set to PokemonPage

  int get pageNow {
    // get the actual value of index to track the body of scaffold, based on BottomNavigationBar icon selected
    return _pageSelectionIndex;
  }

  void updatePageSelection(int index) {
    // update the index value
    _pageSelectionIndex = index;
    notifyListeners();
  }
}
