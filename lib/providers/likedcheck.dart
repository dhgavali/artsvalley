import 'package:artsvalley/services/databaseService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class LikedCheck with ChangeNotifier {
  bool _isLiked = false;
  int count = 0;
  get isLiked => this._isLiked;
  void updateLike(String postid) {
    _isLiked = !_isLiked;
    _isLiked ? count++ : count--;
    DatabaseService().updateLikesDB(postid, _isLiked);
    // FirebaseFirestore.instance
    //     .collection("posts")
    //     .where("postid", isEqualTo: postid)
    //     .get()
    //     .then((value){
    //       //Here wee need to create a collection which will be subcollection of the
    //       //post class.
    //     });
    notifyListeners();
  }

//TODO: we need to use Transactions for updating the dat

}
