import 'package:artsvalley/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReportPage extends StatefulWidget {
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  bool _value = false;
  TextEditingController _commentController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Report an Art"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            children: [
              Text(
                "If you find any post is not related to Art or the art is violated the copyright policies then you can report it.",
                style: GoogleFonts.poppins(
                    fontSize: 20,
                    color: kPrimaryColorDark,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Our team will inspect the reports and will take a required action..",
                style:
                    GoogleFonts.poppins(fontSize: 18, color: kPrimaryColorDark),
              ),
              SizedBox(height: 10),
              CheckboxListTile(
                value: _value,
                onChanged: (value) {
                  setState(() {
                    this._value = value;
                  });
                },
                title: Text("Is not an Art"),
                checkColor: Color(0xffff00ff),
                tileColor: keggshell,
              ),
              SizedBox(
                height: 25,
              ),
              CheckboxListTile(
                value: _value,
                onChanged: (value) {
                  setState(() {
                    this._value = value;
                  });
                },
                key: GlobalKey(),
                title: Text("It violates the copyrights"),
                checkColor: Color(0xffff00ff),
                tileColor: keggshell,
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                width: MediaQuery.of(context).size.width - 100,
                child: TextFormField(
                  controller: _commentController,
                  maxLines: 5,
                  maxLength: 160,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Comment",
                    // labelStyle:
                  ),
                ),
              ),
              SizedBox(height: 50),
              GestureDetector(
                onTap: () {
                  // TODO: Add record to reports database
                  print(_commentController.text);
                  // print()
                },
                child: Container(
                  width: 180,
                  height: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: kPrimaryColorDark,
                  ),
                  child: Text(
                    "Report",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
