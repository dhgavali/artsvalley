import 'package:artsvalley/shared/constants.dart';
import 'package:artsvalley/shared/default_button.dart';
import 'package:artsvalley/shared/shared_widgets.dart';
import 'package:flutter/material.dart';

class AccountsPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController contactController = TextEditingController();

  final GlobalKey<FormState> _personaldetailsFormKey = GlobalKey<FormState>();

  String emailValidator(String value) {
    if (value.isEmpty) return "Email can't be empty";
    if (!emailValidatorRegExp.hasMatch(value)) {
      return 'Email format is invalid';
    } else {
      return null;
    }
  }

  String numberValidator(String value) {
    if (value.isEmpty) return "Phone can't be empty";
    if (!contactNumberValidator.hasMatch(value)) {
      return 'Phone number is invalid';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: Icon(Icons.security),
        title: Text("Account"),
        elevation: 0.0,
      ),
      body: Form(
        key: _personaldetailsFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                "Personal Information",
                style: TextStyle(
                    fontSize: 22,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
              ),
              child: Text(
                "Complete your profile by adding personal information and make your account more secure by updating with the latest information",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Email",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  customInputField1(
                    "Username",
                    Icons.email,
                    emailController,
                    emailValidator,
                    bgcolor: Colors.black12,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              margin: const EdgeInsets.only(bottom: 10, left: 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Mobile Number",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {},
                        color: kPrimaryColor,
                      ),
                    ],
                  ),
                  // customInputField1(
                  //   "9892832983",
                  //   Icons.phone,
                  //   contactController,
                  //   emailValidator,
                  //   bgcolor: Colors.black12,
                  // ),
                ],
              ),
            ),
            Container(
              // padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              width: MediaQuery.of(context).size.width - 100,
              decoration: BoxDecoration(
                  // color: Colors.red,
                  ),
              child: DefaultButton(
                text: "Update",
              ),
            )
          ],
        ),
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
