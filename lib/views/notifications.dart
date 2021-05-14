//TODO: here we will show some notifications to the users.
//Those will be the custom notification.

import 'dart:developer';

import 'package:artsvalley/shared/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
        leading: Icon(Icons.notifications),
      ),
      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection("notifications").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          // return _noNotifications();

          if (snapshot.connectionState == ConnectionState.waiting ||
              snapshot.connectionState == ConnectionState.none) {
            return LinearProgressIndicator();
          } else {
            if (snapshot.hasData) {
              print("snapsho has data");
              // snapshot.data.data()['notification'];
              var _data = "hello";
              // var _data = snapshot.data.data()['notification'];
              // print(snapshot.data.get("alert"));
              // // print(_data);

              // print(snapshot.data.docs.)
              if (_data != null) {
                return ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        leading: Icon(Icons.notifications_active),
                        title: Text("Welcome To ArtsValley"),
                      ),
                    );
                  },
                );
              } else {
                return _noNotifications();
              }
            }
          }
          return LinearProgressIndicator();
        },
      ),
    );
  }

  Widget _noNotifications() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        children: [
          Container(
            alignment: Alignment.topCenter,
            child: Icon(
              Icons.notifications_active,
              size: 150,
              color: kpurpledark,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 25),
            child: Text(
              "You have no Notifications so Far",
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
