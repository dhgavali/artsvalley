import 'package:flutter/cupertino.dart';

class VisibilityProvider with ChangeNotifier {
  //password fields
  bool _isEnabled = false;
  bool _isVisible = true;

  bool get isEnabled => _isEnabled;
  set isEnabled(bool value) {
    this._isEnabled = value;
    notifyListeners();
  }

  bool get isVisible => _isVisible;
  void changeVisibility() {
    _isVisible = !_isVisible;
    notifyListeners();
  }

//for - myaccounts.dart - settings page
  //boolean variables to show and hide edit options
  bool _isEmailVisible = false;
  bool _isMobileVisible = false;
  bool _isAddressVisible = false;
  bool _isGenderVisible = false;
  bool _isEmailPrivate = false;

  get isEmailVisible => this._isEmailVisible;
  get isMobileVisible => this._isMobileVisible;
  get isAddressVisible => this._isAddressVisible;
  get isGenderVisible => this._isGenderVisible;
  get isEmailPrivate => this._isEmailPrivate;

  void setEmailVisibility(bool value) {
    this._isEmailVisible = value;
    notifyListeners();
  }

  void setMobileVisiblity(bool value) {
    this._isMobileVisible = value;
    notifyListeners();
  }

  void setAddressVisiblity(bool value) {
    this._isAddressVisible = value;
    notifyListeners();
  }

  void setGenderVisibility(bool value) {
    this._isGenderVisible = value;
    notifyListeners();
  }

  void setEmailPrivacy(bool value) {
    this._isEmailPrivate = value;
    notifyListeners();
  }
}
