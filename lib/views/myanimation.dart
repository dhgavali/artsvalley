import 'package:flutter/material.dart';

class MyAnimation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          child: TweenAnimationBuilder(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: Duration(seconds: 4),
            builder: (context, value, child) {
              return SizedBox(
                height: 200,
                width: 200,
                child: CircularProgressIndicator(
                  value: value,
                  backgroundColor: Colors.white,
                  strokeWidth: 8,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
