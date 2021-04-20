import 'package:flutter/cupertino.dart';

///
///A loading class which will set the state for loading widget.
///
///
class LoadingProvider with ChangeNotifier {
  bool _isLoaded = false;

  get isLoaded => this._isLoaded;

  set isLoaded(value) => this._isLoaded;

  void loadPage() {
    _isLoaded = !_isLoaded;
    notifyListeners();
  }
}
