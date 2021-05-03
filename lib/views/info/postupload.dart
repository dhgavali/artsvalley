import 'package:artsvalley/components/rounded_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

    showTutorial(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Important", textAlign: TextAlign.center),
          actions: [
            Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Continue to Share your first Art",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Text(
                      "Note: You can only share arts..such as Painting, drawings, sketches, pottery work, handcrafted things, etc"),
                  InkWell(
                    onTap: () {},
                    child: RoundedButton(
                      text: "I Understood ! Continue ",
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      });
}

checkTheDb(String uid) async {
  final adminRef =
      await FirebaseFirestore.instance.collection("admins").doc(uid).get();
  print(adminRef.exists);
}
