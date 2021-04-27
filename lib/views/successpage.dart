import 'package:artsvalley/components/rounded_button.dart';
import 'package:artsvalley/shared/BottomNavigationBar.dart';
import 'package:artsvalley/shared/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        offset: Offset(2.0, 2.0),
                        color: ProConstants.shadowColor,
                        blurRadius: 10,
                      ),
                      BoxShadow(
                        offset: Offset(2.0, 2.0),
                        color: ProConstants.shadowColor,
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: Container(
                        height: 100,
                        width: 100,
                        child: SvgPicture.asset("assets/images/congrats.svg")),
                  ),
                ),
                SizedBox(height: 25),
                Text(
                  "You Have Shared Post Successfully",
                  style: TextStyle(fontSize: 24, fontStyle: FontStyle.italic),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      CupertinoPageRoute(
                        builder: (builder) => CustomNavigationBar(),
                      ),
                    );
                  },
                  child: RoundedButton(
                    color: Color(0xffB20D30),
                    text: "Back to Profile",
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
