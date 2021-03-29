import 'package:artsvalley/helper/sharedpref.dart';
import 'package:artsvalley/views/home.dart';
import 'package:artsvalley/shared/shared_widgets.dart';
import 'package:artsvalley/views/settings.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  final String userName;
  final String profileUrl;
  final String displayName;

  ProfilePage({
    this.userName,
    this.profileUrl,
    this.displayName,
  });
  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {
  //These fields are required to be initialized by the firebase data. which will represents the user profile.
  // also this is hardcoded. we need to use a shared preferences here. in order to store the data on the users local storage.
  // see the documentation of the shared preferences or on youtube.
  // final String userName;
  // final String profileUrl;
  // final String displayName;

  // ProfilePageState({
  //   this.userName,
  //   this.profileUrl,
  //   this.displayName,
  // });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text("Profile"),
        centerTitle: true,
        leading: InkWell(
          child: Icon(Icons.home),
          onTap: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=> SettingPage()));
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              child: CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(widget.profileUrl),
                backgroundColor: Colors.white38,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: [
                Text(
                  widget.displayName,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  "this is username: @ ${widget.userName}",
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            SizedBox(height: 50),
            Row(
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
            ),
            Divider(
              color: Colors.grey,
              thickness: 2.0,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //TODO; ONTAP Of this button a new dialogue or page will open which will ask user to fill out all the values that we are going to use in our Post Widget. checkout postwidget.dart constructor for the input fields.
        },
        child: Icon(Icons.add_a_photo),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

//Fixes:
// we need to decide from where we have to initialize this profile page values. we have following ways try each and then decide based on performance and effieciency.
// 1. We will save the user information into the sharedpreferences from the login screen and then at profile page we will retrieve it from shared preferences
//2. we already saving the user information into database also so we can fetch it from database. but i think it will reduce the speed or performance. as this value will be constant per user. we are not going to update this during runtime means once user log in this remains same till he logins from another account. so we don't actually need to query database each time.
//3. We can fetch the data on homepage and pass it to the constructor onTap of the profile button
//4. we can fetch the data from database in this page itself and initialize the value. there are two places one is init state and another is build.
//5. I think sharedpreferences will be more suitable use it at authentication.

// major features :
// we need to give user options to change his personal information in setting page or in profile page. Setting page will be easier to update.
// option to change the name, profile photo, caption / subtitle aslo.
// also we need to check that user can delete, edit his post.
// also he should be able to add new post from the profile page.
