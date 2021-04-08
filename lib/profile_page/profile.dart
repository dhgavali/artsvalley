import 'dart:async';

import 'package:artsvalley/helper/sharedpref.dart';
import 'package:artsvalley/profile_page/edit_Profile.dart';
import 'package:artsvalley/shared/constants.dart';
import 'package:artsvalley/shared/shared_widgets.dart';
import 'package:artsvalley/profile_page/posts/uploadPostProvider.dart';
import 'package:artsvalley/views/settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:artsvalley/views/home.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final _prefs = SharedPrefsHelper();
   String uid;
  @override
  void initState() {
  uid = FirebaseAuth.instance.currentUser.uid;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(color: ProConstants.appBarTitleColor),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => HomePage()));
          },
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (_) => SettingsPage(),
                  ),
                );
              })
        ],
      ),

      //fetching data here by calling methods from Profile data helpers
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Provider.of<EditProfile>(context, listen: false)
                      .selectProfileImageType(context);
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: _profilePhoto(),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  Text(
                    "display name",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "this is username: ",
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              SizedBox(height: 50),
              CountData(),
              customDivider(context),
              addPostButton(),
              customDivider(context),
            ],
          ),
        ),
      ),

      //
    );
  }

  Widget addPostButton() {
    return Container(
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        color: Colors.teal,
        borderRadius: BorderRadius.circular(50),
        boxShadow: customShadowButton(),
      ),
      child: IconButton(
        icon: Icon(
          Icons.add_a_photo,
          color: Colors.white,
        ),
        onPressed: () {
          Provider.of<UploadPost>(context, listen: false)
              .selectPostImageType(context);
        },
      ),
    );
  }

  Widget _profilePhoto() {
    print("future builder started");
    Future<String> _email = _prefs.getUserEmail();
    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection("users")
            .where("useremail", isEqualTo: _email)
            .get(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            print("data : " + snapshot.data.toString());
            print("docs : " + snapshot.data.docs.toString());
            print("size: " + snapshot.data.size.toString());
            print("Result: " + snapshot.data.docs.first.toString());
          }
          print(snapshot);
          return CircleAvatar(
            radius: 60,
            backgroundImage: AssetImage('assets/images/profile.png'),
            backgroundColor: Colors.white38,
          );
        });
    //  String _photoUrl =  _prefs.getUserProfileUrl();
    // return FutureBuilder<QuerySnapshot>(
    //   future: FirebaseFirestore.instance
    //       .collection("users")
    //       .where("username", isEqualTo: _prefs.getUsername())
    //       .get(),
    //   builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
    //     print("builder started");
    //     if (snapshot.hasData) {
    //       if (snapshot.hasError) {
    //         print(snapshot.error);
    //       }
    //       print(snapshot.data.docs);
    //       print(snapshot.hasData);
    //       return CircleAvatar(
    //         radius: 60,
    //         backgroundImage: AssetImage('assets/images/profile.png'),
    //         backgroundColor: Colors.white38,
    //       );
    //     } else {
    //       return CircleAvatar(
    //         radius: 0,
    //         backgroundImage: AssetImage('assets/images/profile.png'),
    //         backgroundColor: Colors.white38,
    //       );
    //     }
    //   },
    // );
  }
}

class CountData extends StatelessWidget {
  const CountData({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        BoxContent(
          textInside: "Total Posts",
          numvalue: 25,
        ),
        BoxContent(
          textInside: "Total Likes",
          numvalue: 250,
        ),
        BoxContent(
          textInside: "Arts Sold",
          numvalue: 2,
        ),
      ],
    );
  }
}
// Icon(
//           Icons.add_a_photo,
//         ),
//         onPressed: () {
//           IconButton(
//             icon: Icon(Icons.file_upload),
//             onPressed: () {
//               Provider.of<UploadPost>(context, listen: false)
//                   .selectPostImageType(context);
//             },
//           );
//         },

// Widget _profilePhoto() {
//   //  String _photoUrl =  _prefs.getUserProfileUrl();
//   return FutureBuilder(
//     future: _prefs.getUserProfileUrl(),
//     builder: (context, AsyncSnapshot<dynamic> snapshot) {
//       if (snapshot.hasData) {
//         if (snapshot.hasError) {
//           print(snapshot.error);
//         }
//         return CircleAvatar(
//           radius: 40,
//           backgroundImage: NetworkImage(snapshot.data),
//           backgroundColor: Colors.white38,
//         );
//       } else {
//         return CircleAvatar(
//           radius: 40,
//           backgroundImage: AssetImage('assets/images/profile.png'),
//           backgroundColor: Colors.white38,
//         );
//       }
//     },
//   );

// }

//  SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Container(
//             height: MediaQuery.of(context).size.height,
//             width: MediaQuery.of(context).size.width,
//             child: StreamBuilder<DocumentSnapshot>(
//                 stream: FirebaseFirestore.instance
//                     .collection('users')
//                     .doc(Provider.of<DatabaseService>(context, listen: false)
//                         .userid)
//                     .snapshots(),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return Center(
//                       child: CircularProgressIndicator(),
//                     );
//                   } else {
//                     return new Column(
//                       children: <Widget>[
//                         Provider.of<ProfileDataHelper>(context, listen: false)
//                             .headerProfile(context, snapshot),

//                       ],
//                     );
//                   }
//                 }),
//           ),
//         ),
//       );
