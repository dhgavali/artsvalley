import 'package:artsvalley/shared/shared_widgets.dart';
import 'package:artsvalley/views/tutorials/tutorial_list.dart';
import 'package:flutter/material.dart';

class TutorialHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tutorials"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(),
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.only(bottom: 15),
        child: ElevatedButton(
          onPressed: () {
            //It will navigate to tutorialsPageList
            moveToPage(context, TutorialsListPage());
          },
          child: Text("learn To Draw"),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
