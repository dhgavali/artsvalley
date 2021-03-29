import 'package:flutter/cupertino.dart';

class UpdateDataProvider with ChangeNotifier {
  bool _isEnabled = false;

 bool get isEnabled => _isEnabled;
  set isEnabled(bool value) {
    this._isEnabled = value;
    notifyListeners();
  }
}
