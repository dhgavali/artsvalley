import 'package:artsvalley/profile_page/newDesignProfile/newUserProfile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

//TODO: change the model here to userDataModel
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
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("users")
            .where('username', isEqualTo: query)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return Text("Loading ...");

          return ListView(
            children: [
              ...snapshot.data.docs
                  .map<ListTile>((a) => ListTile(
                        title: Text(
                          a.data()['displayname'].toString(),
                          style: TextStyle(color: Colors.black),
                        ),
                        leading: CircleAvatar(
                          backgroundImage: (a.data()['photoUrl'] != null)
                              ? NetworkImage(a.data()['photoUrl'])
                              : AssetImage('assets/images/person.png'),
                        ),
                        subtitle: Text(a.data()['username'].toString()),
                        onTap: () {
                          query = a.data()['username'];
                          openUserProfile(context, a.data()['userid']);
                        },
                      ))
                  .toList(),
            ],
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: query.isEmpty
            ? FirebaseFirestore.instance
                .collection("users")
                .limit(3)
                .snapshots()
            : FirebaseFirestore.instance.collection("users").snapshots(),
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
                        subtitle: Text(
                          a.data()['username'].toString(),
                        ),
                        onTap: () {
                          openUserProfile(context, a.data()['userid']);
                        },
                      ))
                  .toList(),
            ],
          );
        });
  }

  openUserProfile(BuildContext context, String userId) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => NewUserProfilePage(
                  userid: userId,
                )));
  }
}
