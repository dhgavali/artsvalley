import 'package:flutter/cupertino.dart';

class ArtsCountProvider with ChangeNotifier {
  int _artcount;

  get artscount => this._artcount;

  void setArtCount(int count) {
    this._artcount = count;
    notifyListeners();
  }
}

class ArtCountModel {
  int _artcount;
  get artscount => this._artcount;

  void setArtCount(int count) {
    this._artcount = count;
    // notifyListeners();
  }
}
