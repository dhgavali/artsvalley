// import 'package:artsvalley/profile_page/edit_Profile.dart';
// import 'package:artsvalley/shared/constants.dart';
// import 'package:artsvalley/shared/shared_widgets.dart';
// import 'package:artsvalley/profile_page/posts/uploadPostProvider.dart';
// import 'package:artsvalley/views/settings.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';

// class Profile extends StatefulWidget {
//   @override
//   _ProfileState createState() => _ProfileState();
// }

// class _ProfileState extends State<Profile> {
//   String _name;

//   @override
//   Widget build(BuildContext context) {
//     var user = Provider.of<User>(context, listen: false);
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "Profile",
//           style: GoogleFonts.dancingScript(
//             textStyle: TextStyle(
//               fontSize: 30,
//               fontWeight: FontWeight.bold,
//               color: ProConstants.appBarTitleColor,
//             ),
//           ),
//         ),
//         centerTitle: true,
//         actions: [
//           IconButton(
//               icon: Icon(Icons.settings),
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   CupertinoPageRoute(
//                     builder: (_) => SettingsPage(),
//                   ),
//                 );
//               })
//         ],
//       ),

//       //fetching data here by calling methods from Profile data helpers
//       body: SingleChildScrollView(
//         child: Container(
//           padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//           child: Column(
//             children: [
//               GestureDetector(
//                 onTap: () {
//                   Provider.of<EditProfile>(context, listen: false)
//                       .selectProfileImageType(context);
//                 },
//                 child: Container(
//                   alignment: Alignment.center,
//                   padding: EdgeInsets.all(10),
//                   child: _profilePhoto(),
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Column(
//                 children: [
//                   Text(
//                     (_name != null) ? _name.toString() : "Welcome To profile",
//                     style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 5),
//                   Text(
//                     user.email,
//                     style: TextStyle(fontSize: 18),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 50),
//               CountData(),
//               customDivider(context),

//               // customDivider(context),
//               //
//               //TODO: GridView of Post or Listview of Posts; all the profile section will be converted into silvers and gridview will be below
//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Provider.of<UploadPost>(context, listen: false)
//               .selectPostImageType(context);
//         },
//         child: Icon(
//           Icons.add_a_photo,
//         ),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//       //
//     );
//   }

//   Widget addPostButton() {
//     return Container(
//       padding: const EdgeInsets.all(5.0),
//       decoration: BoxDecoration(
//         color: Colors.teal,
//         borderRadius: BorderRadius.circular(50),
//         boxShadow: customShadowButton(),
//       ),
//       child: IconButton(
//         icon: Icon(
//           Icons.add_a_photo,
//           color: Colors.white,
//         ),
//         onPressed: () {
//           Provider.of<UploadPost>(context, listen: false)
//               .selectPostImageType(context);
//         },
//       ),
//     );
//   }

//   Widget _profilePhoto() {
//     return FutureBuilder<QuerySnapshot>(
//         future: FirebaseFirestore.instance
//             .collection("users")
//             .where("userid", isEqualTo: Provider.of<User>(context).uid)
//             .get(),
//         builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           String _profileurl;
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return LinearProgressIndicator();
//           }
//           if (snapshot.connectionState == ConnectionState.done) {
//             if (snapshot.hasData) {
//               if (snapshot.hasError) {
//                 return Center(
//                   child: Text("OOPS eerror occuered"),
//                 );
//               }
//               snapshot.data.docs.map((value) {
//                 _profileurl = value.data()['photoUrl'] ?? "";
//                 _name = value.data()['displayname'];
//                 print(_name);
//               }).toList();
//             }

//             return CircleAvatar(
//               radius: 60,
//               // backgroundImage: NetworkImage("_profileurl") ??
//               backgroundImage: (_profileurl.length > 0)
//                   ? NetworkImage(_profileurl)
//                   : AssetImage('assets/images/profile.png'),
//               backgroundColor: Colors.white38,
//             );
//           }
//           return LinearProgressIndicator();
//         });
//   }
// }

// class CountData extends StatelessWidget {
//   const CountData({
//     Key key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       children: [
//         BoxContent(
//           textInside: "Total Posts",
//           numvalue: 25,
//         ),
//         BoxContent(
//           textInside: "Total Likes",
//           numvalue: 250,
//         ),
//         BoxContent(
//           textInside: "Arts Sold",
//           numvalue: 2,
//         ),
//       ],
//     );
//   }
// }
