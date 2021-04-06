import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:artsvalley/profile_page/posts/uploadPostProvider.dart';
import 'package:artsvalley/services/databaseService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:artsvalley/views/home.dart';
import 'profileDataHelper.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    Provider.of<DatabaseService>(context, listen: false).initUserData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[900],
        title: RichText(
          text: TextSpan(
            text: 'Profile ',
            style: TextStyle(
                fontSize: 18,
                color: Colors.lightGreen,
                fontWeight: FontWeight.bold),
            children: <TextSpan>[
              TextSpan(
                text: 'Page',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
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
            icon: Icon(Icons.file_upload),
            onPressed: () {
              Provider.of<UploadPost>(context, listen: false)
                  .selectPostImageType(context);
            },
          ),
        ],
      ),

      //fetching data here by calling methods from Profile data helpers
      
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: StreamBuilder<DocumentSnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(Provider.of<DatabaseService>(context, listen: false)
                        .userid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return new Column(
                      children: <Widget>[
                        Provider.of<ProfileDataHelper>(context, listen: false)
                            .headerProfile(context, snapshot),
                            Provider.of<ProfileDataHelper>(context, listen: false)
                            .divider(context),
                      ],
                    );
                  }
                }),
          ),
        ),
      ),
    );
  }
}
