import 'package:flutter/cupertino.dart';

class PassVisibleState with ChangeNotifier {
  bool _isEnabled = false;
  bool _isVisible = true;
  bool get isEnabled => _isEnabled;
  set isEnabled(bool value) {
    this._isEnabled = value;
    notifyListeners();
  }

  //this is for password field
  bool get isVisible => _isVisible;
  void changeVisibility() {
    _isVisible = !_isVisible;
    notifyListeners();
  }
}
