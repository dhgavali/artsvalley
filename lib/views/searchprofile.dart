import 'package:artsvalley/shared/shared_widgets.dart';
import 'package:flutter/material.dart';

class SearchProfile extends StatelessWidget {
  final String profileurl;
  final String useremail;
  final String displayName;
  final String id;

  

  SearchProfile({
    this.profileurl,
    this.useremail,
    this.id,
    this.displayName

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
                  backgroundImage: (profileurl != null)
                      ? NetworkImage(profileurl)
                      : AssetImage('assets/images/profile.png'),
                  backgroundColor: Colors.white38,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  Text(
                    (this.displayName != null) ? displayName.toString() : "Welcome To Profile",
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
                  customDivider(context, Colors.grey),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}