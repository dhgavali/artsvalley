import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class LikedCheck with ChangeNotifier {
  bool _isLiked = false;
  int count = 0;
  get isLiked => this._isLiked;
  void updateLike(String postid) {
    _isLiked = !_isLiked;
    _isLiked ? count++ : count--;
    FirebaseFirestore.instance
        .collection("posts")
        .where("postid", isEqualTo: postid)
        .get()
        .then((value){
          
        });
    notifyListeners();
  }
}
