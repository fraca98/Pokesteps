import 'package:pokesteps/model/Identity.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class IdentityNotifier extends ChangeNotifier {
  List<Identity> identityList = [];

  void addIdentity(Identity identity) {
    identityList.add(identity);
    print('${identityList}');
    notifyListeners();
  }
}
