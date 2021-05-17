import 'package:artsvalley/helper/validators.dart';
import 'package:artsvalley/services/databaseService.dart';
import 'package:artsvalley/shared/constants.dart';
import 'package:artsvalley/views/settings/myaccount.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'notifyingpage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:group_button/group_button.dart';

class ShopForm extends StatefulWidget {
  @override
  _ShopFormState createState() => _ShopFormState();
}

class _ShopFormState extends State<ShopForm> {
  TextEditingController _fnameController = TextEditingController();
  TextEditingController _lnameController = TextEditingController();
  TextEditingController _firmnameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _pincodeController = TextEditingController();
  // TextEditingController _ = TextEditingController();
  List<String> _productsList = <String>[
    "Arts",
    "Sketches",
    "Pottery",
    "DIY",
    "Portrait Paintings",
    "Other"
  ];
  // Map<String, bool> _selectedproducts = {};
  List<String> _selectedProducts = [];
  final GlobalKey<FormState> _merchantFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Shop open Form',
          style: GoogleFonts.poppins(),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 12,
          ),
          child: Form(
            key: _merchantFormKey,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(
                    top: 10,
                  ),
                  child: Text(
                    'To join with our community, fill the following form.',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                headingtext("Personal Information"),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                          child: _formField(
                              label: "First Name",
                              controller: _fnameController,
                              validator: CustomFormValidators().validateName)),
                      SizedBox(
                        width: 20,
                      ),
                      Flexible(
                        child: _formField(
                          label: "Last Name",
                          controller: _lnameController,
                          validator: CustomFormValidators().validateName,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: _formField(
                    label: "Phone Number",
                    prefix: Text("+91 "),
                    controller: _phoneController,
                    isNumeric: true,
                    maxCharacters: 10,
                    validator: CustomFormValidators().validateName,
                  ),
                ),
                Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: _formField(
                      label: "Email",
                      controller: _emailController,
                      validator: CustomFormValidators().emailValidator,
                    )),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: _formField(
                    label: "Name of Firm / Organization / Company",
                    controller: _firmnameController,
                  ),
                ),
                Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Products',
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(fontSize: 18)),
                    )),
                GroupButton(
                  buttons: _productsList,
                  spacing: 10,
                  isRadio: false,
                  selectedColor: kPrimaryColor,
                  onSelected: (index, isSelected) {
                    print("checked: ${isSelected.toString()}");
                    if (isSelected) {
                      // _selectedproducts.addEntries(newEntries)
                      _selectedProducts.add(_productsList[index]);
                    } else {
                      _selectedProducts.remove(_productsList[index]);

                    }
                    // print(_selectedProducts);
                  },
                ),
                SizedBox(height: 20),
                headingtext("Address Information"),
                SizedBox(height: 20),
                Container(
                  child: _formField(
                    label: "Address",
                    controller: _addressController,
                    validator: CustomFormValidators().validateName,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    child: _formField(
                  label: "City",
                  controller: _cityController,
                  validator: CustomFormValidators().validateName,
                )),
                SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: _formField(
                          label: "State",
                          controller: _stateController,
                          validator: CustomFormValidators().validateName,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Flexible(
                        child: _formField(
                          label: "Pincode",
                          controller: _pincodeController,
                          validator: CustomFormValidators().validateName,
                          isNumeric: true,
                          maxCharacters: 6,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                  ),
                  onPressed: () {
                    //FormSubmit here

                    if (_merchantFormKey.currentState.validate()) {
                      Map<String, dynamic> merchantdata = {
                        'First name': _fnameController.text.trim(),
                        'Last name': _lnameController.text.trim(),
                        'phone number': _phoneController.text.trim(),
                        'email': _emailController.text.toLowerCase().trim(),
                        'company name': _firmnameController.text.trim() ?? '',
                        'products': _selectedProducts,
                        'address': _addressController.text.trim(),
                        'city': _cityController.text.trim(),
                        'state': _stateController.text.trim(),
                        'pincode': _pincodeController.text.trim(),
                        'userid': Provider.of<User>(context, listen: false).uid,
                      };

                      Provider.of<DatabaseService>(context, listen: false)
                          .addMerchantDetails(merchantdata);
                    }
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NoftifyUser(),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Submit',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _formField({
  String label,
  String Function(String) validator,
  TextEditingController controller,
  bool isNumeric = false,
  int maxCharacters,
  dynamic prefix,
}) {
  return TextFormField(
    validator: validator,
    controller: controller,
    style: GoogleFonts.poppins(),
    keyboardType: isNumeric ? TextInputType.number : TextInputType.text,
    maxLength: maxCharacters,
    decoration: InputDecoration(
      border: OutlineInputBorder(),
      prefix: prefix ?? null,
      contentPadding: const EdgeInsets.only(left: 10),
      labelText: label,
      labelStyle: GoogleFonts.poppins(),
      counterText: "",
    ),
  );
}
