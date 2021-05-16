import 'package:artsvalley/providers/uploadPostProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MickeyMouseTutorial extends StatefulWidget {
  @override
  _MickeyMouseTutorialState createState() => _MickeyMouseTutorialState();
}

class _MickeyMouseTutorialState extends State<MickeyMouseTutorial> {
  int level = 5;
  bool val = false;

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User>(context, listen: false);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tutorial Level 5',
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
                  'How to Draw a Mickey Mouse – Step by Step Easy And Fast',
                  FontWeight.w500,
                  22,
                  TextAlign.center),

              SizedBox(
                height: 30,
              ),
              image(
                "assets/tutorials/mickeyMouse/1.png",
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
                height: 5,
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

              
              steps('Mickey Mouse Drawing Instructions are as follows :- ',
                  FontWeight.w500, 17, TextAlign.justify),
              SizedBox(
                height: 10,
              ),
              steps('Step 1 - ', FontWeight.w500, 18, TextAlign.justify),
              SizedBox(
                height: 10,
              ),
              steps(
                'First, draw the contours of the head and torso. As you can see, it looks like a curved hole for the door key. The head has the shape of an ordinary circle. The head should be much wider than the body.',
                  FontWeight.w300,
                  17,
                  TextAlign.justify),
              SizedBox(
                height: 15,
              ),

              image(
                "assets/tutorials/mickeyMouse/2.png",
                size.width * 0.75,
              ),
              SizedBox(
                height: 20,
              ),
              steps('Step 2 - ', FontWeight.w500, 18, TextAlign.justify),
              SizedBox(
                height: 10,
              ),
              steps(
                'Huge hands are typical of Disney characters. The thumb is opposed to the rest of the fingers at an angle of 90 degrees.',
                  FontWeight.w300,
                  17,
                  TextAlign.justify),
              SizedBox(
                height: 10,
              ),
              image(
                "assets/tutorials/mickeyMouse/3.png",
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
                'Draw the contours of the legs. You can see very thin legs and huge, rounded feet. This is also a very recognizable mark of Disney characters.',
                  FontWeight.w300,
                  17,
                  TextAlign.justify),
              SizedBox(
                height: 10,
              ),
              image(
                "assets/tutorials/mickeyMouse/4.png",
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
                'In this step, i will draw the outlines of Mickey Mouse’s features. Notice that his eyes are very close together. The nose looks like a flat oval. The mouth is formed by several smooth figures. All features are located in the same sloping plane as the head.',
                  FontWeight.w300,
                  17,
                  TextAlign.justify),
              SizedBox(
                height: 10,
              ),

              image(
                "assets/tutorials/mickeyMouse/5.png",
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
                'Remember the colors Mickey Mouse painted in? Remember the usual colors of Mickey Mouse? On his head, there is a black edging. Let’s outline this edging. In the same step, draw the outlines of large oval ears.',
                  FontWeight.w300,
                  17,
                  TextAlign.justify),
              SizedBox(
                height: 10,
              ),

              image(
                "assets/tutorials/mickeyMouse/6.png",
                size.width * 0.75,
              ),
              SizedBox(
                height: 10,
              ),

              steps('Step 6 - ', FontWeight.w500, 18, TextAlign.justify),
              SizedBox(
                height: 10,
              ),
              steps('Mickey Mouse loves to wear shorts with two white circles. Let’s draw it. Also in this step, I will outline smooth lines of fingers and palms.', FontWeight.w300, 17,
                  TextAlign.justify),
              SizedBox(
                height: 10,
              ),

              image(
                "assets/tutorials/mickeyMouse/7.png",
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
                'We have a finished sketch of Mickey Mouse. Now let’s work with the details to get the contour of all your favorite little mouse. In this step, I draw the contours of the pupils and the folds around the mouth. I will also erase all the extra lines from the face and make the final lines darker and more contrast. ',
                  FontWeight.w300,
                  17,
                  TextAlign.justify),
              SizedBox(
                height: 10,
              ),

              image(
                "assets/tutorials/mickeyMouse/8.png",
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
                'I repeat the same actions with the trunk and limbs. Also, I draw small folds on the shoes. Draw the tail.',
                  FontWeight.w300,
                  17,
                  TextAlign.justify),
              SizedBox(
                height: 10,
              ),

              image(
                "assets/tutorials/mickeyMouse/9.png",
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
                'In this step, I will add some colors. As you know, Mickey Mouse is a little black mouse. Therefore, I will paint it in black color, leaving some areas unpainted. We are talking about the face, palms, feet, and elements of clothing. After you have worked in black color, you can paint the clothes and hands of our character.',
                  FontWeight.w300,
                  17,
                  TextAlign.justify),
              SizedBox(
                height: 10,
              ),

              image(
                "assets/tutorials/mickeyMouse/10.png",
                size.width * 0.75,
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
                height: 20,
              ),
              steps(
                  'Congratulations! You have just learned how to draw a Mickey Mouse , And you have acheived your fifth acheivement.',
                  FontWeight.w500,
                  18,
                  TextAlign.justify),
              
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
