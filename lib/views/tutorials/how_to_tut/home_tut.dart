import 'package:artsvalley/providers/uploadPostProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeTutorial extends StatefulWidget {
  @override
  _HomeTutorialState createState() => _HomeTutorialState();
}

class _HomeTutorialState extends State<HomeTutorial> {
  int level = 4;
  bool val = false;

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User>(context, listen: false);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tutorial Level 4',
          style: GoogleFonts.poppins(),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 20),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              steps('How to Draw a House – Step by Step Easy And Fast',
                  FontWeight.w500, 22, TextAlign.center),
              SizedBox(
                height: 30,
              ),
              steps('This tutorial has 9 simple steps to follow.',
                  FontWeight.w300, 18, TextAlign.justify),
              SizedBox(
                height: 10,
              ),
              steps('What you need :-', FontWeight.w300, 17, TextAlign.justify),
              SizedBox(
                height: 10,
              ),
              steps('1. pencil or marker', FontWeight.w300, 17,
                  TextAlign.justify),
              SizedBox(
                height: 5,
              ),
              steps('2. An A4 size plain drawing paper', FontWeight.w300, 17,
                  TextAlign.justify),
              SizedBox(
                height: 5,
              ),
              steps('3. An Eraser', FontWeight.w300, 17, TextAlign.justify),
              SizedBox(
                height: 5,
              ),
              steps('4. An Scale', FontWeight.w300, 17, TextAlign.justify),
              SizedBox(
                height: 5,
              ),
              steps('5. Colours (crayons, watercolour, or sketch pens)',
                  FontWeight.w300, 17, TextAlign.justify),
              SizedBox(
                height: 15,
              ),
              steps('Home Drawing Instructions are as follows :- ',
                  FontWeight.w500, 17, TextAlign.justify),
              SizedBox(
                height: 10,
              ),
              steps('Step 1 - Draw the First Section of the House',
                  FontWeight.w500, 18, TextAlign.justify),
              SizedBox(
                height: 10,
              ),
              steps('Draw the first part of the house', FontWeight.w300, 17,
                  TextAlign.justify),
              SizedBox(
                height: 15,
              ),
              image(
                "assets/tutorials/home/1.png",
                size.width * 0.75,
              ),
              SizedBox(
                height: 20,
              ),
              steps('Step 2 - Draw the First Section of the Roof',
                  FontWeight.w500, 18, TextAlign.justify),
              SizedBox(
                height: 10,
              ),
              steps(
                  'Add the roof with it’s edges hanging slightly over that section of the house.',
                  FontWeight.w300,
                  17,
                  TextAlign.justify),
              SizedBox(
                height: 10,
              ),
              image(
                "assets/tutorials/home/2.png",
                size.width * 0.75,
              ),
              SizedBox(
                height: 10,
              ),
              steps('Step 3 - Draw the Second Section of the House ',
                  FontWeight.w500, 18, TextAlign.justify),
              SizedBox(
                height: 10,
              ),
              steps(
                  'Onto the first section add the second section of the house along with it’s roof.',
                  FontWeight.w300,
                  17,
                  TextAlign.justify),
              SizedBox(
                height: 10,
              ),
              image(
                "assets/tutorials/home/3.png",
                size.width * 0.75,
              ),
              SizedBox(
                height: 10,
              ),
              steps('Step 4 - Draw the Outlines of the Windows ',
                  FontWeight.w500, 18, TextAlign.justify),
              SizedBox(
                height: 10,
              ),
              steps(
                  'Draw the outlines of the windows. One large window for each section of the house and one small one at the top of the first part (usually these tend to be for the attic).',
                  FontWeight.w300,
                  17,
                  TextAlign.justify),
              SizedBox(
                height: 10,
              ),
              image(
                "assets/tutorials/home/4.png",
                size.width * 0.75,
              ),
              SizedBox(
                height: 10,
              ),
              steps('Step 5 - Draw the Door ', FontWeight.w500, 18,
                  TextAlign.justify),
              SizedBox(
                height: 10,
              ),
              steps(
                  'Draw the door with a little platform below it (basically one step).',
                  FontWeight.w300,
                  17,
                  TextAlign.justify),
              SizedBox(
                height: 10,
              ),
              image(
                "assets/tutorials/home/5.png",
                size.width * 0.75,
              ),
              SizedBox(
                height: 10,
              ),
              steps('Step 6 - Draw the Chimney', FontWeight.w500, 18,
                  TextAlign.justify),
              SizedBox(
                height: 10,
              ),
              steps(
                  'Draw the chimney at the top of the second section of the house.',
                  FontWeight.w300,
                  17,
                  TextAlign.justify),
              SizedBox(
                height: 10,
              ),
              image(
                "assets/tutorials/home/6.png",
                size.width * 0.75,
              ),
              SizedBox(
                height: 10,
              ),
              steps('Step 7 - Draw the Smaller Details ', FontWeight.w500, 18,
                  TextAlign.justify),
              SizedBox(
                height: 10,
              ),
              steps(
                  'Draw the window frames by first basically tracing a smaller rectangle inside the larger windows and then adding the dividers for all of them. You can also add a handle to the door (simple make it round).',
                  FontWeight.w300,
                  17,
                  TextAlign.justify),
              SizedBox(
                height: 10,
              ),
              image(
                "assets/tutorials/home/7.png",
                size.width * 0.75,
              ),
              SizedBox(
                height: 10,
              ),
              steps('Step 8 - Finish the Line Drawing ', FontWeight.w500, 18,
                  TextAlign.justify),
              SizedBox(
                height: 10,
              ),
              steps(
                  'To make the house look a little more lively you can add some bushes in a few area around it. To do this simply erase that part of the house and draw the bushes with sort of “cloud like” shapes. Once you confirm that everything seems to be in the right place go over go over your drawing with either darker pencil lines, black pen or marker. ',
                  FontWeight.w300,
                  17,
                  TextAlign.justify),
              SizedBox(
                height: 10,
              ),
              image(
                "assets/tutorials/home/8.png",
                size.width * 0.75,
              ),
              SizedBox(
                height: 10,
              ),
              steps('Step 9 - Color the House ', FontWeight.w500, 18,
                  TextAlign.justify),
              SizedBox(
                height: 10,
              ),
              steps(
                  'You can use anything you like to color the drawing (pencils, paints, markers, etc…). For a nice color combination you can make the house yellow, the roof red, and the windows blue. Make the door brown and the bushes green. You can leave the frames around the larger windows white.',
                  FontWeight.w300,
                  17,
                  TextAlign.justify),
              SizedBox(
                height: 10,
              ),
              image(
                "assets/tutorials/home/9.png",
                size.width * 0.75,
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                child: CheckboxListTile(
                  title: steps('Mark As Complete', FontWeight.w500, 18,
                      TextAlign.justify),
                  value: val,
                  onChanged: (bool newValue) async {
                    if (newValue) {
                      await FirebaseFirestore.instance
                          .collection('acheivements')
                          .doc(user.uid)
                          .set({
                        'userId': user.uid,
                        'level': level,
                      });
                      setState(() {
                        val = newValue;
                        print("checked");
                      });
                    } else {
                      Provider.of<UploadPost>(context, listen: false)
                          .deleteAcheivementFromCloudAndDb(user.uid);
                      // print("unchecked");
                      setState(() {
                        val = newValue;
                      });
                    }
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              steps(
                  'Congratulations! You have just learned how to draw a home , And you have acheived your fourth acheivement.',
                  FontWeight.w500,
                  18,
                  TextAlign.justify),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget image(String imagepath, double width) {
  return Container(
    alignment: Alignment.center,
    child: Image.asset(
      '$imagepath',
      width: width,
    ),
  );
}

Widget steps(
    String text, FontWeight fontWeight, double fontsize, TextAlign textAlign) {
  return Text(
    '$text',
    style: GoogleFonts.poppins(
      textStyle: TextStyle(
        fontSize: fontsize,
        fontWeight: fontWeight,
      ),
    ),
    textAlign: textAlign,
  );
}
