import 'package:pokesteps/model/IdentitySignUp.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class IdentityNotifierSignUp extends ChangeNotifier {
  List<IdentitySignUp> identityListSignUp = [];

  void addIdentity(IdentitySignUp identity) {
    identityListSignUp.add(identity);
    print('${identityListSignUp}');
    notifyListeners();
  }
}
