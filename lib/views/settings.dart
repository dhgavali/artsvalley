import 'package:artsvalley/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:artsvalley/providers/update_data_provider.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  FocusNode myFocusNode;

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var editprovider = context.watch<UpdateDataProvider>();
    return Scaffold(
      backgroundColor: ProConstants.bgcolor,
      appBar: AppBar(
        title: Text("Update Profile"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width - 100,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: TextFormField(
                  focusNode: myFocusNode,
                  key: Key("editusernamekey"),
                  decoration: InputDecoration(
                    hintText: "Username",
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  enabled: editprovider.isEnabled,
                ),
              ),
              IconButton(
                icon: Icon(Icons.edit, color: Colors.white),
                onPressed: () {
                  print("onpressed get called this time");
                  myFocusNode.requestFocus();
                  editprovider.isEnabled = true;
                },
              ),
            ],
          ),
          SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: Text("Update"),
              ),
              SizedBox(
                width: 25,
              ),
              ElevatedButton(
                onPressed: () {
                  editprovider.isEnabled = false;
                  Navigator.pop(context);
                },
                child: Text("cancel"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
