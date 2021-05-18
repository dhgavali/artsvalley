import 'dart:async';
import 'package:artsvalley/models/postmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FetchPostData {
  //postId property
  //
  final String postId;
  FetchPostData({this.postId});

  //COllection reference

  final CollectionReference _posts =
      FirebaseFirestore.instance.collection("posts");

  //userdata from snapshot

  PostDataModel _postDataFromSnapshots(DocumentSnapshot snapshot) {
    return PostDataModel(
      userId: snapshot.data()['userid'],
      username: snapshot.data()['username'],
      userProfile: snapshot.data()['photoUrl'],
      postId: snapshot.data()['postId'],
      postUrl: snapshot.data()['postUrl'],
      tags: snapshot.data()['tags'],
      caption: snapshot.data()['caption'],
      likes: snapshot.data()['likes'],
      timestamp: snapshot.data()['timestamp'],
    );
  }

  PostDataModel convertDocument(DocumentSnapshot snapshot) {
    return PostDataModel(
      userId: snapshot.data()['userid'],
      username: snapshot.data()['username'],
      userProfile: snapshot.data()['userProfile'],
      postId: snapshot.data()['postId'],
      postUrl: snapshot.data()['postUrl'],
      tags: snapshot.data()['tags'],
      caption: snapshot.data()['caption'],
      likes: snapshot.data()['likes'],
      timestamp: snapshot.data()['timestamp'].toString(),
    );
  }
  // PostDataModel _postDataFromDocuments(DocumentSnapshot snapshot) {}
//method for fetchiing the data user data
//

  Stream<PostDataModel> get postData {
    return _posts.doc(postId).snapshots().map(_postDataFromSnapshots);
  }

  Future<DocumentSnapshot> get postDataUrl {
    return _posts.doc(postId).get();
  }
}
