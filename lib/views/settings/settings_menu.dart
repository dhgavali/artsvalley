import 'package:artsvalley/shared/constants.dart';
import 'package:flutter/material.dart';

class SettingMenu extends StatelessWidget {
  SettingMenu({
    Key key,
    @required this.text,
    @required this.icon,
    this.press,
  }) : super(key: key);

  final String text;
  final IconData icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: GestureDetector(
        onTap: press,
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            // color: keggshell,
            // color: kdarkpurple
            // color: kteagreen2,
            color: kPrimaryColorDark,
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: kPrimaryColor,
                size: 24,
              ),
              SizedBox(width: 20),
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Icon(Icons.arrow_forward_ios),
            ],
          ),
        ),
      ),
    );
  }
}
