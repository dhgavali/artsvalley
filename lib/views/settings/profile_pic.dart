import 'package:artsvalley/services/fetchuserdata.dart';
import 'package:artsvalley/shared/constants.dart';
import 'package:artsvalley/shared/shared_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePic extends StatelessWidget {
  final Function onEditClick;
  const ProfilePic({Key key, this.onEditClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      width: 135,
      child: Stack(
        fit: StackFit.expand,
        children: [
          FutureBuilder(
            future: FetchUserData(
                    userid: Provider.of<User>(context, listen: false).uid)
                .userProfileUrl,
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting ||
                  snapshot.connectionState == ConnectionState.none) {
                return CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                return Icon(Icons.error_outline_outlined);
              }
              return Container(
                decoration: kboxDecoration(),
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  padding: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.white),
                      shape: BoxShape.circle),
                  child: CircleAvatar(
                    backgroundImage: (snapshot.data['photoUrl'] != null)
                        ? NetworkImage("${snapshot.data['photoUrl']}")
                        : AssetImage("assets/images/profile.png"),
                  ),
                ),
              );
            },
          ),
          Positioned(
            right: 0,
            bottom: 0,
            child: SizedBox(
              height: 40,
              width: 40,
              child: TextButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.00),
                      side: BorderSide(color: keggshell),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(
                    keggshell,
                  ),
                ),
                onPressed: onEditClick,
                child: Icon(
                  Icons.edit,
                  color: Colors.black,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
