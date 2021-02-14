import 'package:artsvalley/views/shared_widgets.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
            Navigator.pop(context);
          },
        ),
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
                backgroundImage: AssetImage("assets/images/logo.png"),
                backgroundColor: Colors.white24,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Column(
              children: [
                Text(
                  "Johny Deep",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text(
                  "Creativity takes courage",
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
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add_a_photo),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
