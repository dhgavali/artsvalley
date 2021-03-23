import 'package:flutter/material.dart';

class PostWidget extends StatefulWidget {
  final String profileurl;
  //either we will display a username or full name here
  final String username;
  final String posturl;
  //it may be string or int. we will use one which works easily and then typecast at server level or at UI level
  final int likescount;
  final String caption;
//This is the constructor for this class which initializes the values that are required to create a post template.
// These are named parameters so at the time of calling the constructor you will get hint what to pass to the constructor no need to remember.
// This constructor will be called at homepage inside a streambuilder where a values will be fetched from the datbase and then passed to this constructor.
//There are required some fixes in this that i have mentioned at the end of this page.
  PostWidget(
      {this.profileurl,
      this.username,
      this.posturl,
      this.likescount,
      this.caption});

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 50,
      height: 500,
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: <BoxShadow>[
            BoxShadow(
              offset: Offset(5, 5),
              color: Color(0xff303030),
              blurRadius: 10,
            ),
          ],
          color: Colors.white),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  //TODO: Here implement the gestureDetector which will be invoked on click of the profile photo. as user click on profile photo a viewProfile will be opened. This profile page will be view only. Which will shown the user profile. Basically we have two types of profile pages. One is for the user itself. Where he can change his details update the data or profile photo. and other one is to display to other users. which will show only read only information. and may be we can do a follow option. or we need to find something different than follow. but initially we need to show the details.
                  child: CircleAvatar(
                    backgroundImage: AssetImage(
                      widget.profileurl,
                    ),
                    backgroundColor: Colors.yellow,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  //TODO: The text widget here represents the username. we need to get this from database.
                  child:
                      Text(widget.username, style: TextStyle(fontSize: 20.0)),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 55),
            constraints: BoxConstraints.expand(
              height: 340,
            ),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            //TODO: this is the image fetched from the database which is user post.
            child: Image.asset(
              widget.posturl,
              fit: BoxFit.cover,
            ),
          ),
          //TODO: we need to add these icons with changable colors on tap. based on that we need to increment likes or decrement on server and also change the saving priority
          Positioned(
            bottom: 60,
            right: 10,
            child: Icon(
              Icons.share,
              size: 40,
              color: Colors.teal,
            ),
          ),
          Positioned(
            bottom: 60,
            left: 10,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {},
                  child: Icon(
                    Icons.favorite,
                    size: 40,
                    color: Colors.redAccent,
                  ),
                ),
                Text(
                  widget.likescount.toString(),
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),
          Positioned(
            top: 450,
            left: 16,
            child: Container(
              //TODO: needs to fix this text. When the text is bigger than width we need to adjust it to multiline text. So the text will be displayed on next line automatically. and after 3 lines the readmore button will be shown for the longer captions. So when clicked on readmore text will expand to full size page
              child: Text(
                widget.caption,
                overflow: TextOverflow.visible,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

//The fixes:
// 1. we need to check that image quality is maintained based on the data / network speed
// 2. We need to insure that if image failed to load then it will reload after receiving a network.
// 3. Image should not overflow out of the box. we need to display full image not cropped inside the layout.
// 4. other things are mentioned in todo kindly check that.
// 5. Note: we will have seprate database to maintain the post data where a username / userid will be the foreign key.
