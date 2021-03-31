import 'package:flutter/material.dart';
import 'package:artsvalley/components/text_field_container.dart';
import 'package:artsvalley/shared/constants.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final TextEditingController myController;
  final ValueChanged<String> onChanged;
  const RoundedInputField({
    Key key,
    this.hintText,
    this.icon = Icons.person,
    this.onChanged,
    this.myController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
