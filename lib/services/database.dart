import 'package:cloud_firestore/cloud_firestore.dart';

class DataMethods {
  final CollectionReference dbconn =
      FirebaseFirestore.instance.collection("users");

  addUserRecord(Map data) async {
    try {
      await dbconn.add(data);
    } catch (e) {
      print(e.message());
    }
  }
}
