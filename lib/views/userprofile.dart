import 'dart:developer';

import 'package:artsvalley/shared/shared_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserProfilePage extends StatelessWidget {
  final String userid;
  UserProfilePage({this.userid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: //UserProfile(id: this.userid,),
          FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance
                  .collection("users")
                  .where('userid', isEqualTo: this.userid)
                  .get(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                String _useremail;

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return LinearProgressIndicator();
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                            'Opps !! Something Went Wrong Please Try Again'),
                      );
                    }
                    snapshot.data.docs.map((values) {
                      _useremail = values.data()['useremail'];
                      log(_useremail);
                    }).toList();

                    return UserProfile(
                      id: this.userid,
                      useremail: _useremail,
                    );
                  }
                }
                return CircularProgressIndicator();
              }),
    );
  }
}

class UserProfile extends StatelessWidget {
  final String profileurl;
  final String useremail;
<<<<<<< HEAD
  final String id;
=======

  final String id;

>>>>>>> a5c58ce5d21b6f03b0a28ad2935adfb527e0339d
  String _name;
  UserProfile({
    this.profileurl,
    this.useremail,
    this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                // child: _profilePhoto(context, id),
                child: CircleAvatar(
                  radius: 60,
                  // backgroundImage: NetworkImage("_profileurl") ??
                  backgroundImage: (profileurl.length > 0)
                      ? NetworkImage(profileurl)
                      : AssetImage('assets/images/profile.png'),
                  backgroundColor: Colors.white38,
                ),
              ),
              SizedBox(
                height: 10,
              ),
<<<<<<< HEAD
              SizedBox(
                height: 10,
              ),
=======
>>>>>>> a5c58ce5d21b6f03b0a28ad2935adfb527e0339d
              Column(
                children: [
                  Text(
                    (_name != null) ? _name.toString() : "Welcome To Profile",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    useremail,
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: 50,
                  ),
<<<<<<< HEAD
                  customDivider(context, Colors.grey),
=======
                  customDivider(context),
>>>>>>> a5c58ce5d21b6f03b0a28ad2935adfb527e0339d
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

/*   Widget _profilePhoto(BuildContext context, String userid) {
    return FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection("users")
            .where("userid", isEqualTo: userid)
            .get(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          String _profileurl;

          if (snapshot.connectionState == ConnectionState.waiting) {
            return LinearProgressIndicator();
          }
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              if (snapshot.hasError) {
                return Center(
                  child: Text("OOPS eerror occuered"),
                );
              }
              snapshot.data.docs.map((value) {
                _profileurl = value.data()['photoUrl'] ?? "";
                _name = value.data()['displayname'];
                print(_name);
              }).toList();
            }

            return CircleAvatar(
              radius: 60,
              // backgroundImage: NetworkImage("_profileurl") ??
              backgroundImage: (_profileurl.length > 0)
                  ? NetworkImage(_profileurl)
                  : AssetImage('assets/images/profile.png'),
              backgroundColor: Colors.white38,
            );
          }
          return LinearProgressIndicator();
        });
  } */
}
