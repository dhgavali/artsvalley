import 'package:artsvalley/models/userdata_model.dart';
import 'package:artsvalley/providers/loading_provider.dart';
import 'package:artsvalley/services/databaseService.dart';
import 'package:artsvalley/services/fetchuserdata.dart';
import 'package:artsvalley/shared/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:group_button/group_button.dart';
import 'package:provider/provider.dart';
import 'package:artsvalley/providers/visibilityprovider.dart';

class AccountsPage extends StatefulWidget {
  @override
  _AccountsPageState createState() => _AccountsPageState();
}

class _AccountsPageState extends State<AccountsPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final GlobalKey<FormState> _personaldetailsFormKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState> _cityKey = GlobalKey<FormFieldState>();

  String gender;

  FocusNode _emailNode = FocusNode();
  FocusNode _mobileNode = FocusNode();
  FocusNode _addressNode = FocusNode();

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
    if (value.isEmpty) return "Field can't be empty";
    if (!stringvalueValidator.hasMatch(value)) {
      return 'Please enter valid City Name';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    var _visibilityProvider =
        Provider.of<VisibilityProvider>(context, listen: false);
    var _loadProvider = Provider.of<LoadingProvider>(context, listen: false);
    var _dbProvider = Provider.of<DatabaseService>(context, listen: false);

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
            if (snapshot.connectionState == ConnectionState.waiting ||
                snapshot.connectionState == ConnectionState.none) {
              return LinearProgressIndicator();
            }

            if (snapshot.hasError) {
              return Center(
                  child: Text(
                "Oops Some Error Occuered",
                style: TextStyle(fontSize: 24),
              ));
            } else {
              if (snapshot.hasData) {
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
                      //TODO: email field
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                headingtext("Email"),
                                SizedBox(width: 10),
                                TextButton(
                                    onPressed: () {
                                      _emailNode.requestFocus();
                                      _visibilityProvider
                                          .setEmailVisibility(true);
                                    },
                                    child: Icon(Icons.edit))
                              ],
                            ),
                            Consumer<VisibilityProvider>(
                              builder: (context, value, child) {
                                return TextFormField(
                                  focusNode: _emailNode,
                                  decoration: InputDecoration(
                                    hintText: "${userdata.email}",
                                    hintStyle: TextStyle(color: Colors.black87),
                                    enabled: value.isEmailVisible,
                                    border: OutlineInputBorder(),
                                  ),
                                );
                              },
                            ),
                            Consumer<VisibilityProvider>(
                              builder: (context, value, child) {
                                return value.isEmailVisible
                                    ? Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        width: 200,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {},
                                              child: Text("save"),
                                            ),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                primary: kerichblack,
                                              ),
                                              onPressed: () {
                                                _visibilityProvider
                                                    .setEmailVisibility(false);
                                              },
                                              child: Text("cancel"),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Container();
                              },
                            ),
                          ],
                        ),
                      ),

                      //TODO: mobile field
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                headingtext("Mobile Number"),
                                SizedBox(width: 10),
                                TextButton(
                                    onPressed: () {
                                      _visibilityProvider
                                          .setMobileVisiblity(true);
                                    },
                                    child: Icon(Icons.edit))
                              ],
                            ),
                            Consumer<VisibilityProvider>(
                              builder: (context, value, child) {
                                return TextFormField(
                                  focusNode: _mobileNode,
                                  keyboardType: TextInputType.number,
                                  maxLength: 10,
                                  decoration: InputDecoration(
                                    prefix: Text("+91 "),
                                    hintStyle: TextStyle(color: Colors.black87),
                                    contentPadding:
                                        const EdgeInsets.only(left: 15),
                                    counterText: '',
                                    hintText: "${userdata.mobileNumber}",
                                    enabled: value.isMobileVisible,
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: numberValidator,
                                  controller: contactController,
                                );
                              },
                            ),
                            Consumer<VisibilityProvider>(
                              builder: (context, value, child) {
                                return value.isMobileVisible
                                    ? Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        width: 200,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {
                                                //validate number
                                                if (_personaldetailsFormKey
                                                    .currentState
                                                    .validate()) {
                                                  _dbProvider
                                                      .updateUserMobileNumber(
                                                          uid: userdata.useruid,
                                                          mobileNumber:
                                                              contactController
                                                                  .text
                                                                  .trim());
                                                  //hiding field after saving
                                                  _visibilityProvider
                                                      .setMobileVisiblity(
                                                          false);
                                                }
                                              },
                                              child: Text("save"),
                                            ),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                primary: kerichblack,
                                              ),
                                              onPressed: () {
                                                _visibilityProvider
                                                    .setMobileVisiblity(false);
                                              },
                                              child: Text("cancel"),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Container();
                              },
                            ),
                          ],
                        ),
                      ),

                      //TODO : address field
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                headingtext("City"),
                                SizedBox(width: 10),
                                TextButton(
                                    onPressed: () {
                                      _visibilityProvider
                                          .setAddressVisiblity(true);
                                    },
                                    child: Icon(Icons.edit))
                              ],
                            ),
                            Consumer<VisibilityProvider>(
                              builder: (context, value, child) {
                                return TextFormField(
                                  focusNode: _addressNode,
                                  decoration: InputDecoration(
                                    hintText: value.isAddressVisible
                                        ? " "
                                        : "${userdata.address}",
                                    hintStyle: TextStyle(color: Colors.black87),
                                    enabled: value.isAddressVisible,
                                    border: OutlineInputBorder(),
                                  ),
                                  controller: cityController,
                                  key: _cityKey,
                                  validator: cityValidator,
                                );
                              },
                            ),
                            Consumer<VisibilityProvider>(
                              builder: (context, value, child) {
                                return value.isAddressVisible
                                    ? Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        width: 200,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {
                                                if (_cityKey.currentState
                                                    .validate()) {
                                                  _dbProvider.updateUserAddress(
                                                      uid: userdata.useruid,
                                                      address: cityController
                                                          .text
                                                          .trim());
                                                  //hiding field after saving
                                                  _visibilityProvider
                                                      .setAddressVisiblity(
                                                          false);
                                                }
                                              },
                                              child: Text("save"),
                                            ),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                primary: kerichblack,
                                              ),
                                              onPressed: () {
                                                _visibilityProvider
                                                    .setAddressVisiblity(false);
                                              },
                                              child: Text("cancel"),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Container();
                              },
                            ),
                          ],
                        ),
                      ),

                      //TODO: gender field
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                headingtext("Gender"),
                                SizedBox(width: 10),
                                TextButton(
                                    onPressed: () {
                                      _visibilityProvider
                                          .setGenderVisibility(true);
                                    },
                                    child: Icon(Icons.edit))
                              ],
                            ),
                            Consumer<VisibilityProvider>(
                                builder: (context, value, child) {
                              return value.isGenderVisible
                                  ? GroupButton(
                                      buttons: genderList,
                                      spacing: 20.0,
                                      selectedButtons:
                                          (userdata.gender.length > 2)
                                              ? [
                                                  userdata.gender == 'Male'
                                                      ? genderList[0]
                                                      : genderList[1],
                                                ]
                                              : [],
                                      onSelected: (index, isSelected) async {
                                        switch (index) {
                                          case 0:
                                            gender = "Male";
                                            break;

                                          case 1:
                                            gender = "Female";
                                            break;
                                        }
                                      },
                                    )
                                  : Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.grey[300],
                                        ),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 15),
                                      child: headingtext(userdata.gender),
                                    );
                            }),
                            Consumer<VisibilityProvider>(
                              builder: (context, value, child) {
                                return value.isGenderVisible
                                    ? Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        width: 200,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {
                                                Provider.of<DatabaseService>(
                                                        context,
                                                        listen: false)
                                                    .updateUserGender(
                                                        gender: this.gender,
                                                        uid: userdata.useruid);
                                                _visibilityProvider
                                                    .setGenderVisibility(false);
                                              },
                                              child: Text("save"),
                                            ),
                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                primary: kerichblack,
                                              ),
                                              onPressed: () {
                                                _visibilityProvider
                                                    .setGenderVisibility(false);
                                              },
                                              child: Text("cancel"),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Container();
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
            }
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
    style: GoogleFonts.poppins(
      textStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    ),
  );
}
