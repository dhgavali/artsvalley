import 'package:artsvalley/profile_page/profile.dart';
import 'package:artsvalley/services/auth.dart';
import 'package:artsvalley/shared/constants.dart';
import 'package:artsvalley/views/settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:artsvalley/views/postwidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
        actions: [
          Container(
            padding: const EdgeInsets.only(
              right: 16,
            ),
            child: IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    // builder: (context) => ProfilePage(),
                    builder: (context) => Profile(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      drawer: Theme(
        data: Theme.of(context).copyWith(canvasColor: ProConstants.drawerColor),
        child: MyDrawer(),
      ),
      body:
      //TODO: 
      //here we are basically going to create two separate classes or a single class which will contain the
      //user and posts database. and fetch the data from the two databaase then return a single list which will be used 
      //here to fetch the data. and this will be a streabuilder which will be like using behavirol subject for fetching the data.
      //
       StreamBuilder(
        stream: FirebaseFirestore.instance.collection("posts").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          if (snapshot.hasData) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return LinearProgressIndicator();
            }

            String _username;
            String _profileUrl;
            return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot mypost = snapshot.data.docs[index];
                  FirebaseFirestore.instance
                      .collection("users")
                      .where('userId', isEqualTo: mypost['userId'])
                      .get()
                      .then((userdata) {
                    userdata.docs.map((values) {
                      _username = values.data()['username'];
                      _profileUrl = values.data()['photoUrl'];
                      print(_username);
                      print(_profileUrl);
                    });
                  });
                  print("line no.86 home page");
                  print(mypost['userId']);

                  return PostWidget(
                    username: "Goerge Bush",
                    profileurl: "assets/images/logo.png",
                    posturl: mypost['postUrl'],
                    caption: mypost['caption'],
                    likescount: mypost['likes'],
                    postId: mypost['postId'],
                    userId: mypost['userId'],
                  );
                });
          }
          return LinearProgressIndicator();
        },
      ),
    );
  }

//   Widget myDrawer() {

// }

}

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0.0,
      child: ListView(
        children: [
          ListTile(
            onTap: (){
              Navigator.of(context).pop();
            },
            leading: Icon(
              Icons.close,
              size: 32.0,
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: 150,
            child: Container(
              child: Column(
                children: [],
              ),
            ),
          ),
          menuItem("Home", Icons.home),
          menuItem("Profile", Icons.person),
          menuItem("Explore", Icons.explore),
          GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => SettingsPage(),
                  ),
                );
              },
              child: menuItem("settings", Icons.settings)),
          menuItem("About us", Icons.info),
          GestureDetector(
              onTap: () {
                context.read<AuthMethods>().signOut(context);
              },
              child: menuItem("Logout", Icons.logout)),
        ],
      ),
    );
  }

  Widget menuItem(String value, IconData icons) {
    return ListTile(
      leading: Icon(
        icons,
        color: ProConstants.bgcolor,
      ),
      title: Text(
        value,
        style: TextStyle(
          fontSize: 20,
          color: ProConstants.bgcolor,
        ),
      ),
    );
  }
}
