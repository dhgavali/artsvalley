import 'package:flutter/material.dart';

class CustomAlerts extends StatelessWidget {
  final int som = 1;
  final List interests = [
    'hello',
    'width',
    'height',
    'child',
    'animal',
    'call',
    'police',
    'house'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Custom Dialog"),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(6, 6, 0, 0),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.039,
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(1),
              itemCount: 10,
              itemBuilder: (context, index) {
                return Container(
                    margin: EdgeInsets.only(right: 9),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.yellow[100])),
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.030,
                        vertical: MediaQuery.of(context).size.height * 0.0045),
                    child: Text(
                      interests[index],
                      style: TextStyle(fontSize: 12),
                    ));
              }),
        ),
      ),
    );
  }

  showFirstDialog(BuildContext context, int value) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("value is $value"),
          );
        });
  }

  showSecondDialog(BuildContext context, int value) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("value is not equal to 0"),
            content: Text("value is $value"),
          );
        });
  }
}
