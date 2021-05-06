import 'package:artsvalley/components/rounded_button.dart';
import 'package:artsvalley/shared/shared_widgets.dart';
import 'package:flutter/material.dart';

class AccountsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.security),
        title: Text("Account"),
        elevation: 0.0,
      ),
      body: ListView(
        children: [
          headline(context, "Personal Details"),
          customTile(
            title: "Email",
            subtitle: "dhgavali@gmail.com",
            icon: Icons.email,
          ),
          customTile(
            title: "Contact No",
            subtitle: "8983631618",
            icon: Icons.phone,
          ),
          customTile(
            title: "Address",
            subtitle:
                "Sector 4, 321 - A, Krishna Kunj Apartment, Satara, 415503",
            icon: Icons.location_on,
          ),
          RoundedButton(
            text: "Update",
            width: 120,
            hpadding: 20,
          ),
        ],
      ),
    );
  }
}

Widget customTile({String title, String subtitle, IconData icon}) {
  return ListTile(
    leading: Icon(icon),
    title: Text(
      "$title",
      style: TextStyle(
          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
    ),
    subtitle: Text(
      "$subtitle",
      style: TextStyle(
        fontSize: 20,
        color: Color(0xff101011),
      ),
    ),
  );
}
