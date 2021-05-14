import 'package:artsvalley/models/userdata_model.dart';
import 'package:artsvalley/services/fetchuserdata.dart';
import 'package:artsvalley/shared/constants.dart';
import 'package:artsvalley/shared/default_button.dart';
import 'package:artsvalley/shared/shared_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:provider/provider.dart';

class AccountsPage extends StatefulWidget {
  @override
  _AccountsPageState createState() => _AccountsPageState();
}

class _AccountsPageState extends State<AccountsPage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController contactController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  final GlobalKey<FormState> _personaldetailsFormKey = GlobalKey<FormState>();
  String gender;
  List<String> genderList = <String>["Male", "Female"];
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Account"),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: StreamBuilder<UserProfileData>(
          stream: FetchUserData(
                  userid: Provider.of<User>(context, listen: false).uid)
              .userData,
          builder: (context, AsyncSnapshot<UserProfileData> snapshot) {
            UserProfileData userdata = snapshot.data;
            // print(userdata.email);
            return Form(
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        headingtext("Email"),
                        customInputField(
                          userdata.email,
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
                        headingtext("Mobile Number"),
                        customInputField(
                          //Here we have to fetch data from the database
                          userdata.mobileNumber ?? 'Add Mobile Number',
                          Icons.phone,
                          contactController,
                          emailValidator,
                          bgcolor: Colors.black12,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        headingtext('Address'),
                        customInputField(
                            userdata.address ?? "Add City",
                            Icons.location_on_sharp,
                            cityController,
                            cityValidator),
                        SizedBox(
                          height: 20,
                        ),
                        headingtext("Select Gender"),
                        Container(
                          padding: const EdgeInsets.all(10),
                          child: GroupButton(
                            buttons: genderList,
                            selectedButtons:
                                genderList.contains(userdata.gender)
                                    ? (userdata.gender == "Male"
                                        ? [genderList[0]]
                                        : [genderList[1]])
                                    : [],
                            isRadio: true,
                            spacing: 15.0,
                            borderRadius: BorderRadius.circular(10),
                            onSelected: (index, isSelected) {
                              if (isSelected) {
                                gender = genderList[index];
                                print(gender);
                              }
                            },
                          ),
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
                      press: () {
                        //TODO: update record at databse users
                        //TODO
                      },
                    ),
                  )
                ],
              ),
            );
          },
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
