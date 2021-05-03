import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:artsvalley/views/searchprofile.dart';

class SearchUser extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection("users").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return Text("Loading ...");

          final result = snapshot.data.docs.where(
            (DocumentSnapshot a) =>
                a.data()['username'].toString().contains(query),
          );

          return ListView(
            children: [
              ...result
                  .map<ListTile>((a) => ListTile(
                        title: Text(
                          a.data()['displayname'].toString(),
                          style: TextStyle(color: Colors.black),
                        ),
                        leading: Icon(Icons.person),
                        subtitle: Text(a.data()['username'].toString()),
                        onTap: () {
                          print('ontap');
                          print(a.data()['useremail']);
                          print(a.data()['photoUrl']);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SearchProfile(
                                  id: a.data()['userId'],
                                  profileurl: a.data()['photoUrl'],
                                  useremail: a.data()['useremail'],
                                  displayName: a.data()['displayname'],
                                ),
                              ));
                          //close(context, a.toString());
                        },
                      ))
                  .toList(),
            ],
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection("users").limit(5).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return Text("Loading ...");

          final result = snapshot.data.docs.where(
            (DocumentSnapshot a) =>
                a.data()['username'].toString().startsWith(query),
          );

          return ListView(
            children: [
              ...result
                  .map<ListTile>((a) => ListTile(
                        title: Text(
                          a.data()['displayname'].toString(),
                          style: TextStyle(
                            color: Colors.lightBlue,
                          ),
                        ),
                        leading: CircleAvatar(
                          backgroundImage: (a.data()['photoUrl'] != null)
                              ? NetworkImage(a.data()['photoUrl'])
                              : AssetImage('assets/images/profile.png'),
                        ),
                        subtitle: Text(a.data()['username'].toString()),
                        onTap: () {
                          query = a.data()['username'];
                        },
                      ))
                  .toList(),
            ],
          );
        });
  }
}
