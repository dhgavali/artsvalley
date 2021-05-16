import 'package:artsvalley/providers/uploadPostProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CarTutorial extends StatefulWidget {
  @override
  _CarTutorialState createState() => _CarTutorialState();
}

class _CarTutorialState extends State<CarTutorial> {
  int level = 3;
  bool val = false;

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<User>(context, listen: false);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tutorial Level 3',
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
              steps('How to Draw a Car – Step by Step Easy And Fast',
                  FontWeight.w500, 22, TextAlign.center),
              SizedBox(
                height: 30,
              ),
              image(
                "assets/tutorials/car/1.png",
                size.width * 0.75,
              ),
              SizedBox(
                height: 20,
              ),
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
                height: 10,
              ),
              steps('Car Drawing Instructions are as follows :- ',
                  FontWeight.w500, 17, TextAlign.justify),
              SizedBox(
                height: 10,
              ),
              steps('Step 1 - Draw a Horizontal Line and Two Circles Over It',
                  FontWeight.w500, 18, TextAlign.justify),
              SizedBox(
                height: 10,
              ),
              steps(
                  'Using a scale, draw a horizontal line on the bottom half of the A4 sized drawing paper. Then draw two circles over the line, as shown in the figure. These circles are the wheels that will take you places!',
                  FontWeight.w300,
                  17,
                  TextAlign.justify),
              SizedBox(
                height: 15,
              ),
              image(
                "assets/tutorials/car/2.png",
                size.width * 0.75,
              ),
              SizedBox(
                height: 20,
              ),
              steps('Step 2 -  Draw Smaller Circles Inside the Wheels',
                  FontWeight.w500, 18, TextAlign.justify),
              SizedBox(
                height: 10,
              ),
              steps(
                  'Now, draw another circle on the inside of the car wheels, as shown in the figure below. This is what we call the barrel of the wheel.',
                  FontWeight.w300,
                  17,
                  TextAlign.justify),
              SizedBox(
                height: 10,
              ),
              image(
                "assets/tutorials/car/3.png",
                size.width * 0.75,
              ),
              SizedBox(
                height: 10,
              ),
              steps('Step 3 - Draw the Third Set of Circles Inside the Wheels',
                  FontWeight.w500, 18, TextAlign.justify),
              SizedBox(
                height: 10,
              ),
              steps(
                  'Draw a small circle in the centre of each wheel. Your drawing might look like scary eyes right now, but trust me, it is your car. We’re just making it simple for you. These little circles, by the way, are the centre caps.',
                  FontWeight.w300,
                  17,
                  TextAlign.justify),
              SizedBox(
                height: 10,
              ),
              image(
                "assets/tutorials/car/4.png",
                size.width * 0.75,
              ),
              SizedBox(
                height: 10,
              ),
              steps(
                  'Step 4 - Draw Lines From the Innermost Circle Till the Second Circle ',
                  FontWeight.w500,
                  18,
                  TextAlign.justify),
              SizedBox(
                height: 10,
              ),
              steps(
                  'On each wheel, now draw five equidistant lines starting from the innermost circle and ending at the second circle. These lines are the spokes of the wheels. You may choose to use your scale to draw these lines or go freehand.',
                  FontWeight.w300,
                  17,
                  TextAlign.justify),
              SizedBox(
                height: 10,
              ),
              image(
                "assets/tutorials/car/5.png",
                size.width * 0.75,
              ),
              SizedBox(
                height: 10,
              ),
              steps('Step 5 - Connect the Wheels With Two Horizontal Lines',
                  FontWeight.w500, 18, TextAlign.justify),
              SizedBox(
                height: 10,
              ),
              steps(
                  'Now connect the wheels with two horizontal lines. You can use your scale here as well. These lines form the base of the car. Before we proceed, is it just us or does the drawing look like a pair of glasses on a pair of eyes?',
                  FontWeight.w300,
                  17,
                  TextAlign.justify),
              SizedBox(
                height: 10,
              ),
              image(
                "assets/tutorials/car/6.png",
                size.width * 0.75,
              ),
              SizedBox(
                height: 10,
              ),
              steps('Step 6 - Draw Two Rectangles on Either Side of the Wheels',
                  FontWeight.w500, 18, TextAlign.justify),
              SizedBox(
                height: 10,
              ),
              steps(
                  'Now, on either side of the wheels, draw two rectangles extending away from each other, as shown in the figure below.',
                  FontWeight.w300,
                  17,
                  TextAlign.justify),
              SizedBox(
                height: 10,
              ),
              image(
                "assets/tutorials/car/7.png",
                size.width * 0.75,
              ),
              SizedBox(
                height: 10,
              ),
              steps('Step 7 -  Draw the Body of the Car ', FontWeight.w500, 18,
                  TextAlign.justify),
              SizedBox(
                height: 10,
              ),
              steps(
                  'To make this part of the drawing simple, we’ll break it down in three steps – ',
                  FontWeight.w300,
                  17,
                  TextAlign.justify),
              SizedBox(
                height: 5,
              ),
              steps(
                  ' 1. First, from the left-hand side of the drawing paper, and from above the rectangle, draw a curved line that stops just above the end of the wheel on the right-hand side. The front portion of this curve will be the hood of your car.',
                  FontWeight.w300,
                  17,
                  TextAlign.justify),
              SizedBox(
                height: 5,
              ),
              steps(
                  ' 2. Then, to connect the rear of the car, draw another curved line from the end of the rectangle on the right-hand side till the point where the first line stops. This part is the trunk of your car.',
                  FontWeight.w300,
                  17,
                  TextAlign.justify),
              SizedBox(
                height: 5,
              ),
              steps(
                  ' 3. Now, draw a semi-circle on the top, starting from the point where the first two curved lines met till the end of the first wheel. Voila! You just drew the windshield and the roof of the car!.',
                  FontWeight.w300,
                  17,
                  TextAlign.justify),
              SizedBox(
                height: 10,
              ),
              image(
                "assets/tutorials/car/8.png",
                size.width * 0.75,
              ),
              SizedBox(
                height: 10,
              ),
              steps('Step 8 - Draw the Car Door and the Headlight',
                  FontWeight.w500, 18, TextAlign.justify),
              SizedBox(
                height: 10,
              ),
              steps(
                  'Now, let’s add a car door and a headlight. For this step, you have to draw two slightly curved lines in the centre portion of the car, as shown in the figure below. Add a small rectangle near the second line for the handle. This completes your car door! ',
                  FontWeight.w300,
                  17,
                  TextAlign.justify),
                  SizedBox(
                height: 5,
              ),
                  steps(
                  'Drawing the headlight of the car is even more simple! Just draw an oval on the hood of the car (the curve on the extreme left of your drawing paper). ',
                  FontWeight.w300,
                  17,
                  TextAlign.justify),
              SizedBox(
                height: 10,
              ),
              image(
                "assets/tutorials/car/9.png",
                size.width * 0.75,
              ),
              SizedBox(
                height: 10,
              ),
              steps('Step 9 - Draw the Windows With Two Quadrants',
                  FontWeight.w500, 18, TextAlign.justify),
              SizedBox(
                height: 10,
              ),
              steps(
                  'Now, draw two quadrants, one big and one small to make the windows of your car. You can use your scale to get the lines straight, but it’s not required. Just make them look like the car windows given in the image below.',
                  FontWeight.w300,
                  17,
                  TextAlign.justify),
              SizedBox(
                height: 10,
              ),
              image(
                "assets/tutorials/car/10.png",
                size.width * 0.75,
              ),
              SizedBox(
                height: 10,
              ),
              steps('Step 10 - Paint It On!', FontWeight.w500, 18,
                  TextAlign.justify),
              SizedBox(
                height: 10,
              ),
              steps(
                  'Wow! Your car has really come together well! Now all that’s remaining is to gather your favourite colours and paint that car!',
                  FontWeight.w300,
                  17,
                  TextAlign.justify),
              SizedBox(
                height: 10,
              ),
              image(
                "assets/tutorials/car/11.png",
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
                height: 15,
              ),
              steps(
                  'Congratulations! You have just learned how to draw a car , And you have acheived your third acheivement.',
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
