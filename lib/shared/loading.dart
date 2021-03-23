import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff212121),
      child: Center(
        child: SpinKitChasingDots(
          color: Colors.yellow,
          size: 75.0,
        ),
      ),
    );
  }
}
