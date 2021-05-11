import 'package:artsvalley/shared/constants.dart';
import 'package:artsvalley/shared/default_button.dart';
import 'package:artsvalley/shared/shared_widgets.dart';
import 'package:flutter/material.dart';

class AccountsPage extends StatefulWidget {
  @override
  _AccountsPageState createState() => _AccountsPageState();
}

class _AccountsPageState extends State<AccountsPage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController contactController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

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

  String cityValidator(String value) {
    if (value.isEmpty) return "Phone can't be empty";
    if (!stringvalueValidator.hasMatch(value)) {
      return 'Please enter valid City Name';
    } else {
      return null;
    }
  }

  bool showMobileField = false;
  bool showAddressField = false;
  bool showPinCodeField = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Account"),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Form(
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    headingtext("Email"),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        headingtext("Mobile Number"),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white24,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: IconButton(
                            icon: showMobileField
                                ? Icon(Icons.clear_outlined)
                                : Icon(Icons.add),
                            onPressed: () {
                              setState(() {
                                showMobileField = !showMobileField;
                              });
                            },
                            color: kPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                    showMobileField
                        ? customInputField1(
                            //Here we have to fetch data from the database

                            "9892832983",
                            Icons.phone,
                            contactController,
                            emailValidator,
                            bgcolor: Colors.black12,
                          )
                        : Container(),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        headingtext('Address'),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white24,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: IconButton(
                            icon: showAddressField
                                ? Icon(Icons.clear_outlined)
                                : Icon(Icons.add),
                            onPressed: () {
                              setState(() {
                                showAddressField = !showAddressField;
                              });
                            },
                            color: kPrimaryColor,
                          ),
                        ),
                      ],
                    ),
                    showAddressField
                        ? customInputField("City", Icons.location_on_sharp,
                            cityController, cityValidator)
                        : Container(),
                    headingtext("Select Gender"),
                    Row(
                      children: [
                        Text("male"),
                        SizedBox(
                          width: 50,
                        ),
                        Text("female"),
                      ],
                    ),
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

Widget headingtext(String title) {
  return Text(
    "$title",
    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
  );
}
