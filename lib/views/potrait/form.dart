import 'dart:developer';
import 'package:artsvalley/helper/validators.dart';
import 'package:artsvalley/providers/uploadPostProvider.dart';
import 'package:artsvalley/services/databaseService.dart';
import 'package:artsvalley/views/settings/myaccount.dart';
import 'package:artsvalley/views/potrait/submitmsg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FormToGetPortait extends StatefulWidget {
  @override
  _FormToGetPortaitState createState() => _FormToGetPortaitState();
}

class _FormToGetPortaitState extends State<FormToGetPortait> {
  TextEditingController _fnameController = TextEditingController();
  TextEditingController _lnameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _pincodeController = TextEditingController();

  final GlobalKey<FormState> _portaitFormKey = GlobalKey<FormState>();

  var imagePath;

  @override
  void initState() {
    // TODO: implement initState
    Provider.of<UploadPost>(context, listen: false).portraitImage = null;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Portrait Form',
          style: GoogleFonts.poppins(),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 12,
          ),
          child: Form(
            key: _portaitFormKey,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(
                    top: 10,
                  ),
                  child: Text(
                    'To get your own portrait from our best artists, fill the following form.',
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
                SizedBox(height: 10),
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
                  height: 20,
                ),
                headingtext('Portrait Photo'),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  child: Container(
                    alignment: Alignment.center,
                    width: 400,
                    height: 300,
                    color: Colors.grey[200],
                    child: ClipRect(
                      child: Consumer<UploadPost>(
                          builder: (context, value, child) {
                        return (value.portraitImage != null)
                            ? Image.file(
                                value.portraitImage,
                                frameBuilder: (BuildContext context,
                                        Widget child,
                                        int frame,
                                        bool wasSynchronouslyLoaded) =>
                                    wasSynchronouslyLoaded
                                        ? child
                                        : AnimatedOpacity(
                                            child: child,
                                            opacity: frame == null ? 0 : 1,
                                            duration:
                                                const Duration(seconds: 2),
                                            curve: Curves.easeOut,
                                          ),
                              )
                            : Container();
                      }),
                    ),

                    /* Text(
                      'Click here to Select Picture ',
                      style: GoogleFonts.poppins(),
                      textAlign: TextAlign.center,
                    ), */
                  ),
                  onTap: () {
                    Provider.of<UploadPost>(context, listen: false)
                        .pickPortraitImage(context);
                    print('opened gallery');
                  },
                ),
                SizedBox(
                  height: 8,
                ),
                Container(
                  child: Text(
                    'Tip :- For reselcting image , tap again on picture box.',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
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
                  onPressed: () async {
                    //FormSubmit here
                    await Provider.of<UploadPost>(context, listen: false)
                        .uploadPotraitImage();
                    if (_portaitFormKey.currentState.validate()) {
                      log("inside validation");
                      Map<String, dynamic> portraitdata = {
                        'First name': _fnameController.text.trim(),
                        'Last name': _lnameController.text.trim(),
                        'phone number': _phoneController.text.trim(),
                        'email': _emailController.text.toLowerCase().trim(),
                        'address': _addressController.text.trim(),
                        'city': _cityController.text.trim(),
                        'state': _stateController.text.trim(),
                        'pincode': _pincodeController.text.trim(),
                        'portraitImageUrl':
                            Provider.of<UploadPost>(context, listen: false)
                                .portraitImageUrl,
                        'userid': Provider.of<User>(context, listen: false).uid,
                      };

                      await Provider.of<DatabaseService>(context, listen: false)
                          .addPortraitDetails(portraitdata);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SubmitMsgForPortraitForm(),
                        ),
                      );
                    }
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
