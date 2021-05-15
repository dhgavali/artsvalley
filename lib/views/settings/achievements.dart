import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Achievements extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _user = Provider.of<User>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text("Achivements"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("posts")
            .where("userId", isEqualTo: _user.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              snapshot.connectionState == ConnectionState.none) {
            return LinearProgressIndicator();
          } else {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  QueryDocumentSnapshot data = snapshot.data.docs[index];
                  if (data.data()['likes'].length > 1) {
                    return ListTile(
                      title: Text(data.data()['likes'].length.toString()),
                    );
                  }
                  return Container();
                },
              );
            }
            return LinearProgressIndicator();
          }
        },
      ),
    );
  }
}
