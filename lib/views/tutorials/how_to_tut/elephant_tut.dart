import 'package:artsvalley/providers/uploadPostProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ElephantTutorial extends StatefulWidget {
  @override
  _ElephantTutorialState createState() => _ElephantTutorialState();
}

class _ElephantTutorialState extends State<ElephantTutorial> {
  int level = 1;
  bool val = false;

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User>(context, listen: false);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tutorial Level 1',
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
              steps(
                  'How to Draw an Elephant – Step by Step Elephant Drawing Tutorial',
                  FontWeight.w500,
                  22,
                  TextAlign.center),

              //steps('Learn how to draw an elephant with our easy to follow step by step drawing instructions .', FontWeight.w300 , 16, TextAlign.justify),
              //SizedBox(height: 10,),
              //steps("Want to draw something else too? Browse all of our drawing tutorials here(ontap navigate to list page).", FontWeight.w300, 16, TextAlign.justify),
              SizedBox(
                height: 30,
              ),
             // SizedBox(height: 10,),
              image(
                "assets/tutorials/elephant/1.png",
                size.width * 0.75,
              ),
              SizedBox(height: 20,),
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
              steps('2. paper :-', FontWeight.w300, 17, TextAlign.justify),
              SizedBox(
                height: 10,
              ),
              
              steps('Elephant Drawing Instructions are as follows :- ',
                  FontWeight.w500, 17, TextAlign.justify),
              SizedBox(
                height: 10,
              ),
              steps('Step 1 :-', FontWeight.w500, 18, TextAlign.justify),
              SizedBox(
                height: 10,
              ),
              steps(
                  'Depending on which direction your elephant will be facing either draw an S or a reversed S.',
                  FontWeight.w300,
                  17,
                  TextAlign.justify),
              SizedBox(
                height: 10,
              ),

              image(
                "assets/tutorials/elephant/2.png",
                size.width * 0.75,
              ),
              SizedBox(
                height: 20,
              ),
              steps('Step 2 :-', FontWeight.w500, 18, TextAlign.justify),
              SizedBox(
                height: 10,
              ),
              steps(
                  'Draw another shape just like it under it. You can also see the elephant trunk forming.',
                  FontWeight.w300,
                  17,
                  TextAlign.justify),
              SizedBox(
                height: 10,
              ),
              image(
                "assets/tutorials/elephant/3.png",
                size.width * 0.75,
              ),
              SizedBox(
                height: 10,
              ),

              steps('Step 3 :- ', FontWeight.w500, 18, TextAlign.justify),
              SizedBox(
                height: 10,
              ),
              steps(
                  'Finish up the trunk. Also start drawing the elephant head and a little “lens” shape at the bottom of the head.',
                  FontWeight.w300,
                  17,
                  TextAlign.justify),
              SizedBox(
                height: 10,
              ),
              image(
                "assets/tutorials/elephant/4.png",
                size.width * 0.75,
              ),
              SizedBox(
                height: 10,
              ),

              steps('Step 4 :- ', FontWeight.w500, 18, TextAlign.justify),
              SizedBox(
                height: 10,
              ),
              steps(
                  'Draw the tusk, the big C or reversed C shaped ear and an eye. As this is a cartoon like elephant, there is no need for “attention to detail”. However if you want to be more specific, you can draw rounded ears for an African elephant and more triangle like ears for the Asian elephant.',
                  FontWeight.w300,
                  17,
                  TextAlign.justify),
              SizedBox(
                height: 10,
              ),

              image(
                "assets/tutorials/elephant/5.png",
                size.width * 0.75,
              ),
              SizedBox(
                height: 10,
              ),

              steps('Step 5 :- ', FontWeight.w500, 18, TextAlign.justify),
              SizedBox(
                height: 10,
              ),
              steps(
                  'Draw the other ear. Also draw a line from the tusk towards the ear, but don’t make it all the way to the ear. You have just drawn your elephant head. Pretty neat right?',
                  FontWeight.w300,
                  17,
                  TextAlign.justify),
              SizedBox(
                height: 10,
              ),

              image(
                "assets/tutorials/elephant/6.png",
                size.width * 0.75,
              ),
              SizedBox(
                height: 10,
              ),

              steps('Step 6 :- ', FontWeight.w500, 18, TextAlign.justify),
              SizedBox(
                height: 10,
              ),
              steps('Draw the first pair of legs.', FontWeight.w300, 17,
                  TextAlign.justify),
              SizedBox(
                height: 10,
              ),

              image(
                "assets/tutorials/elephant/7.png",
                size.width * 0.75,
              ),
              SizedBox(
                height: 10,
              ),

              steps('Step 7 :- ', FontWeight.w500, 18, TextAlign.justify),
              SizedBox(
                height: 10,
              ),
              steps(
                  'Make the belly by connecting the legs with a curved line. Also draw the back, start by the ears and work your way through the leg.',
                  FontWeight.w300,
                  17,
                  TextAlign.justify),
              SizedBox(
                height: 10,
              ),

              image(
                "assets/tutorials/elephant/8.png",
                size.width * 0.75,
              ),
              SizedBox(
                height: 10,
              ),

              steps('Step 8 :- ', FontWeight.w500, 18, TextAlign.justify),
              SizedBox(
                height: 10,
              ),
              steps(
                  'Continue with the other pair of legs. We’re almost finished!',
                  FontWeight.w300,
                  17,
                  TextAlign.justify),
              SizedBox(
                height: 10,
              ),

              image(
                "assets/tutorials/elephant/9.png",
                size.width * 0.75,
              ),
              SizedBox(
                height: 10,
              ),

              steps('Step 9 :- ', FontWeight.w500, 18, TextAlign.justify),
              SizedBox(
                height: 10,
              ),
              steps(
                  'All there is left to do is to make the tail and add a few details.',
                  FontWeight.w300,
                  17,
                  TextAlign.justify),
              SizedBox(
                height: 10,
              ),

              image(
                "assets/tutorials/elephant/10.png",
                size.width * 0.75,
              ),

              SizedBox(
                height: 10,
              ),

              steps('Color', FontWeight.w500, 18, TextAlign.justify),
              SizedBox(
                height: 10,
              ),
              steps(
                  'Bring your elephant drawing to life with some color. We think blue and gray look great when it comes to coloring an elephant, but let your imagination be the guide.',
                  FontWeight.w300,
                  17,
                  TextAlign.justify),
              SizedBox(
                height: 10,
              ),

              image(
                "assets/tutorials/elephant/11.png",
                size.width * 0.75,
              ),

              SizedBox(height: 20,),

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
                height: 10,
              ),
              steps(
                  'Congratulations! You have just learned how to draw an elephant , And you have acheived your first acheivement.',
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
