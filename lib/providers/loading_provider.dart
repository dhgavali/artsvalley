import 'package:flutter/cupertino.dart';

class LoadingProvider with ChangeNotifier {
  bool _isLoaded = false;

  get isLoaded => this._isLoaded;

  set isLoaded(value) => this._isLoaded;

  void loadPage() {
    _isLoaded = !_isLoaded;
    notifyListeners();
  }
}
