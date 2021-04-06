import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:artsvalley/profile_page/edit_Profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileDataHelper with ChangeNotifier {
  Widget headerProfile(
      BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            height: 240,
            width: 160,
            child: Column(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Provider.of<EditProfile>(context, listen: false)
                        .selectProfileImageType(context);
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.lightGreen,
                    radius: 60,
                    backgroundImage: AssetImage("assets/images/profile.png"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    // snapshot.data.data()['username'],
                    'username',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.email),
                      SizedBox(
                        width: 1,
                      ),
                      Text(
                        // snapshot.data.data()['email'],
                        'email',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 8.2,
                        ),
                      ),
                    ],
                  ),
                ),
                //email
              ],
            ),
          ),
          Container(
            child: Column(
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blueGrey[50],
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      height: 80,
                      width: 65,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '0',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                            ),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                            'Followers',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blueGrey[50],
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      height: 80,
                      width: 65,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '0',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                            ),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                            'Following',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blueGrey[50],
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      height: 80,
                      width: 65,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            '0',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                            ),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Text(
                            'posts',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget divider(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 5,
        width: MediaQuery.of(context).size.width,
        child: Divider(
          color: Colors.lightGreen,
        ),
      ),
    );
  }
}
