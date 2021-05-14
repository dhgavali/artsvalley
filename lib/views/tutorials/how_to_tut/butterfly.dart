import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ButterflyTutorial extends StatelessWidget {
  int level = 2;

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User>(context, listen: false);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tutorial Level 2',
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
                  'How to Draw a Butterfly – Step by Step Easy And Fast',
                  FontWeight.w500,
                  22,
                  TextAlign.center),

              SizedBox(
                height: 30,
              ),
              image(
                "assets/tutorials/butterfly/1.png",
                size.width * 0.75,
              ),
              SizedBox(height: 20,),
              steps('This tutorial has 10 simple steps to follow.',
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
              steps('2. An A4 size plain drawing paper', FontWeight.w300, 17, TextAlign.justify),
              SizedBox(
                height: 10,
              ),
              steps('3. An Eraser', FontWeight.w300, 17,
                  TextAlign.justify),
              SizedBox(
                height: 5,
              ),
              steps('4. An Scale', FontWeight.w300, 17,
                  TextAlign.justify),
              SizedBox(
                height: 5,
              ),
              steps('5. Colours (crayons, watercolour, or sketch pens)', FontWeight.w300, 17,
                  TextAlign.justify),
              SizedBox(
                height: 10,
              ),

              
              steps('Butterfly Drawing Instructions are as follows :- ',
                  FontWeight.w500, 17, TextAlign.justify),
              SizedBox(
                height: 10,
              ),
              steps('Step 1 - Starting your butterfly wings drawing', FontWeight.w500, 18, TextAlign.justify),
              SizedBox(
                height: 10,
              ),
              steps(
                'We are starting to draw a butterfly by outlining both forewings symmetrically.  If you are using a pencil for your drawing, don’t apply too much pressure for the first three steps since these lines are not final and most likely be corrected later. The forewings are closer to the butterfly’s head and are roughly triangular. ',
                  FontWeight.w300,
                  17,
                  TextAlign.justify),
              SizedBox(
                height: 15,
              ),

              image(
                "assets/tutorials/butterfly/2.png",
                size.width * 0.75,
              ),
              SizedBox(
                height: 20,
              ),
              steps('Step 2 -  Adding Hindwings', FontWeight.w500, 18, TextAlign.justify),
              SizedBox(
                height: 10,
              ),
              steps(
                'Proceed by drawing outlines of two hindwings of your butterfly. Make sure to make them smaller in size.  Now you have a general layout of butterfly’s wings.',
                  FontWeight.w300,
                  17,
                  TextAlign.justify),
              SizedBox(
                height: 10,
              ),
              image(
                "assets/tutorials/butterfly/3.png",
                size.width * 0.75,
              ),
              SizedBox(
                height: 10,
              ),

              steps('Step 3 - ', FontWeight.w500, 18, TextAlign.justify),
              SizedBox(
                height: 10,
              ),
              steps(
                'Now it’s time to draw a butterfly’s body. Start by drawing the central part – thorax.  Note that forewings and hindwings are attached to the thorax, so draw the thorax right in the middle where all wings come together. Then add a small circle on the top – the head – and the abdomen below the thorax.',
                  FontWeight.w300,
                  17,
                  TextAlign.justify),
              SizedBox(
                height: 10,
              ),
              image(
                "assets/tutorials/butterfly/4.png",
                size.width * 0.75,
              ),
              SizedBox(
                height: 10,
              ),

              steps('Step 4 - ', FontWeight.w500, 18, TextAlign.justify),
              SizedBox(
                height: 10,
              ),
              steps(
                'Add two eyes to the butterfly’s head and two antennae. Don’t curve antennae too much. Now draw horizontal section dividers on the abdomen of your butterfly. Your butterfly is taking its shape!',
                  FontWeight.w300,
                  17,
                  TextAlign.justify),
              SizedBox(
                height: 10,
              ),

              image(
                "assets/tutorials/butterfly/5.png",
                size.width * 0.75,
              ),
              SizedBox(
                height: 10,
              ),

              steps('Step 5 - ', FontWeight.w500, 18, TextAlign.justify),
              SizedBox(
                height: 10,
              ),
              steps(
                'Remember, we were talking about making the first outlines of the wings pretty light? At this step, you can use the full pencil pressure when drawing the final shapes of the beautiful butterfly’s wings. ',
                  FontWeight.w300,
                  17,
                  TextAlign.justify),
              SizedBox(
                height: 10,
              ),

              image(
                "assets/tutorials/butterfly/6.png",
                size.width * 0.75,
              ),
              SizedBox(
                height: 10,
              ),

              steps('Step 6 - ', FontWeight.w500, 18, TextAlign.justify),
              SizedBox(
                height: 10,
              ),
              steps('This step brings a few challenges. The best way to draw cells on the hindwings would be starting from the inner part of the wings located by the abdomen. Second, do the big cell in the upper part. Add other cells afterward and don’t try to be precise – all butterflies have a bit different patterns.', FontWeight.w300, 17,
                  TextAlign.justify),
              SizedBox(
                height: 10,
              ),

              image(
                "assets/tutorials/butterfly/7.png",
                size.width * 0.75,
              ),
              SizedBox(
                height: 10,
              ),

              steps('Step 7 - ', FontWeight.w500, 18, TextAlign.justify),
              SizedBox(
                height: 10,
              ),
              steps(
                'Drawing the pattern on the forewings is a little easier.  There is one distinct large cell on the top and 3-4 horizontal ones. Don’t forget to add thin veins to each cell. ',
                  FontWeight.w300,
                  17,
                  TextAlign.justify),
              SizedBox(
                height: 10,
              ),

              image(
                "assets/tutorials/butterfly/8.png",
                size.width * 0.75,
              ),
              SizedBox(
                height: 10,
              ),

              steps('Step 8 - ', FontWeight.w500, 18, TextAlign.justify),
              SizedBox(
                height: 10,
              ),
              steps(
                'Start darkening space between cells. ',
                  FontWeight.w300,
                  17,
                  TextAlign.justify),
              SizedBox(
                height: 10,
              ),

              image(
                "assets/tutorials/butterfly/9.png",
                size.width * 0.75,
              ),
              SizedBox(
                height: 10,
              ),

              steps('Step 9 - ', FontWeight.w500, 18, TextAlign.justify),
              SizedBox(
                height: 10,
              ),
              steps(
                'Finish drawing butterfly’s wings.',
                  FontWeight.w300,
                  17,
                  TextAlign.justify),
              SizedBox(
                height: 10,
              ),

              image(
                "assets/tutorials/butterfly/10.png",
                size.width * 0.75,
              ),

              SizedBox(
                height: 10,
              ),

              steps('Step 10 -', FontWeight.w500, 18, TextAlign.justify),
              SizedBox(
                height: 10,
              ),
              steps(
                'Coloring can be done with pencils, watercolors, or inks.  Sometimes, the hindwings are lighter and forewings are more reddish but you may use any colors you want if you are not trying to draw a typical American Monarch Butterfly. ',
                  FontWeight.w300,
                  17,
                  TextAlign.justify),
              SizedBox(
                height: 10,
              ),

              image(
                "assets/tutorials/butterfly/11.png",
                size.width * 0.75,
              ),

              SizedBox(
                height: 15,
              ),
              steps(
                  'Congratulations! You have just learned how to draw a butterfly , And you have acheived your Second acheivement.',
                  FontWeight.w500,
                  18,
                  TextAlign.justify),
              SizedBox(
                height: 20,
              ),

              Container(
                alignment: Alignment.center,
                child: ElevatedButton(
                    onPressed: () async {
                      await FirebaseFirestore.instance
                          .collection('tutorials')
                          .doc(user.uid)
                          .set({
                        'userId': user.uid,
                        'level': level,
                      });
                      print('added');
                    },
                    child: Text('See Your acheivement here')),
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
