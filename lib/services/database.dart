import 'package:cloud_firestore/cloud_firestore.dart';

class DataMethods {
  final CollectionReference dbconn =
      FirebaseFirestore.instance.collection("users");
  final CollectionReference postdb =
      FirebaseFirestore.instance.collection("postdb");

  //method to add user data on sign up
  addUserRecord(Map data) async {
    try {
      await dbconn.add(data);
    } catch (e) {
      print(e.message());
    }
  }

//method to update data in database
// updateUserRecord(){}

//add User Post method

  addPost(String photoUrl, String displayName, String postUrl, String caption) {
    //in this method we have to add this data to the user post databse
    // also we have to increment the post count of the user;
    // so if user have uploaded 20 images. we have to make this 21 in the uploading
  }
}
