//TODO: here we will show some notifications to the users.
//Those will be the custom notification.

import 'package:artsvalley/shared/constants.dart';
import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notifications"),
        leading: Icon(Icons.notifications),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          children: [
            Container(
              alignment: Alignment.topCenter,
              child: Icon(
                Icons.notifications_active,
                size: 150,
                color: kpurpledark,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: Text(
                "You have no Notifications so Far",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
