import 'package:flutter/cupertino.dart';

class LoadingProvider with ChangeNotifier {
  bool isLoaded = false;

  void loadPage() {
    isLoaded = !isLoaded;
    notifyListeners();
  }
}
