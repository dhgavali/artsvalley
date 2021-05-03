import 'package:artsvalley/components/text_field_container.dart';
import 'package:artsvalley/shared/constants.dart';
import 'package:flutter/material.dart';

class BoxContent extends StatelessWidget {
  final String textInside;
  final int numvalue;
  BoxContent({this.textInside, this.numvalue});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width - 100) / 3,
      height: 80,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          color: Colors.grey),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            textInside,
            style: TextStyle(fontSize: 16),
          ),
          Text(
            numvalue.toString(),
            style: TextStyle(fontSize: 22),
          ),
        ],
      ),
    );
  }
}

Widget customInputField1(
  String hintText,
  IconData customIcon,
  TextEditingController mycontroller,
  FormFieldValidator<String> validator,
) {
  return TextFieldContainer(
    child: TextFormField(
      controller: mycontroller,
      cursorColor: kPrimaryColor,
      validator: validator,
      decoration: InputDecoration(
        icon: Icon(
          customIcon,
          color: kPrimaryColor,
        ),
        // errorStyle: TextStyle(),
        hintText: hintText,
        border: InputBorder.none,
      ),
    ),
  );
}

Widget customInputField(String hintText, IconData customIcon,
    TextEditingController mycontroller, FormFieldValidator<String> validator,
    [bool obsecureText = false]) {
  Icon myIcon = Icon(customIcon, color: Colors.grey);
  String hint = hintText;
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 20),
    margin: EdgeInsets.symmetric(vertical: 10),
    child: TextFormField(
      controller: mycontroller,
      obscureText: obsecureText,
      validator: validator,
      decoration: InputDecoration(
        fillColor: Colors.black,
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.deepOrange, width: 0.2),
        ),
        suffixIcon: GestureDetector(
          onTap: () {
            obsecureText ? obsecureText = false : obsecureText = true;
          },
          child: myIcon,
        ),
        labelText: hint,
        labelStyle: TextStyle(color: Colors.black),
        contentPadding: EdgeInsets.only(left: 25, top: 10),
      ),
    ),
  );
}

Widget loginButton(String title, BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width - 30,
    padding: EdgeInsets.symmetric(vertical: 15),
    alignment: Alignment.center,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.white54,
              offset: Offset(3.0, 3.0),
              blurRadius: 5,
              spreadRadius: 2)
        ],
        gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Color(0xfffbb448), Color(0xfff7892b)])),
    child: Text(
      title,
      style: TextStyle(fontSize: 20, color: Colors.white),
    ),
  );
}

Widget googleWidget(String title, BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width - 30,
    padding: EdgeInsets.symmetric(vertical: 7.5),
    alignment: Alignment.center,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.white54,
              offset: Offset(3.0, 3.0),
              blurRadius: 5,
              spreadRadius: 2)
        ],
        gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [Color(0xff02ddd2), Color(0xff02fdd3)])),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: Colors.transparent,
          backgroundImage: AssetImage("assets/images/googlemini.png"),
        ),
        SizedBox(
          width: 20,
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: ProConstants.buttonfontsize,
            color: ProConstants.bgcolor,
          ),
        )
      ],
    ),
  );
}

Widget createAccountLabel(String label, String action) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 20),
    padding: EdgeInsets.all(20),
    alignment: Alignment.bottomCenter,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          action,
          style: TextStyle(
              color: Colors.deepOrange,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              decorationStyle: TextDecorationStyle.solid,
              decoration: TextDecoration.underline,
              decorationThickness: 2.0),
        ),
      ],
    ),
  );
}

Widget customDivider(BuildContext context, Color color, {double thikness}) {
  return Center(
    child: SizedBox(
      height: 5,
      width: MediaQuery.of(context).size.width,
      child: Divider(
        color: color,
        thickness: thikness,
      ),
    ),
  );
}

List<BoxShadow> customShadowButton() {
  return <BoxShadow>[
    BoxShadow(
      blurRadius: 5,
      color: Color(0xff212121),
      offset: Offset(0.2, 0.5),
    ),
    BoxShadow(
      blurRadius: 5,
      color: Color(0xfff1f1f1),
      offset: Offset(0.2, 0.5),
    ),
  ];
}

class HorizontalLine extends StatelessWidget {
  ///
  ///
  ///stateless widget which return a Padding widget with Divider

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 150),
      child: Divider(
        thickness: 4.0,
        color: Colors.white10,
      ),
    );
  }
}

Widget infoLabel(String label, double fontsize, {Color color = Colors.black}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5.0),
    child: Text(
      label,
      overflow: TextOverflow.visible,
      maxLines: 5,
      style: TextStyle(
        fontSize: fontsize,
        color: color,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

Widget headline(BuildContext context, String title) {
  return Column(
    children: [
      Text(
        "$title",
        style: TextStyle(
            fontSize: ProConstants.headingsize, fontWeight: FontWeight.bold),
      ),
      Container(
          width: MediaQuery.of(context).size.width,
          child: customDivider(context, Colors.grey)),
    ],
  );
}