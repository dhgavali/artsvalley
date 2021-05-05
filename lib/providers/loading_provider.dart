import 'package:flutter/cupertino.dart';

///
///A loading class which will set the state for loading widget.
///
///
class LoadingProvider with ChangeNotifier {
  bool _isLoaded = false;
  bool _islinearloading = false;

  get isLoaded => this._isLoaded;
  get isIndicatorLoaded => this._islinearloading;

  set isLoaded(value) => this._isLoaded;
  set isLinearLoaded(value) => this._islinearloading;

  
  void loadPage(bool state) {
    _isLoaded = state;
    notifyListeners();
  }

  void loadLinearProgress(bool state) {
    _islinearloading = state;
    notifyListeners();
  }
}
