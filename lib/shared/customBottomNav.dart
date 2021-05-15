// import 'package:artsvalley/profile_page/newDesignProfile/newProfileDesign.dart';
// import 'package:artsvalley/providers/uploadPostProvider.dart';
// import 'package:artsvalley/shared/constants.dart';
// import 'package:artsvalley/views/home.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class CustomBottomNavBar extends StatelessWidget {
//   CustomBottomNavBar({
//     @required this.selectedMenu,
//   });

//   final MenuState selectedMenu;

//   @override
//   Widget build(BuildContext context) {
//     // final Color inActiveIconColor = Colors.red.shade900;
//     final Color inActiveIconColor = kPrimaryColor;
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 5),
//       decoration: BoxDecoration(
//         color: kPrimaryColorDark,
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           IconButton(
//             icon: Icon(
//               Icons.home,
//               size: 28,
//             ),
//             color: MenuState.home == selectedMenu
//                 ? inActiveIconColor
//                 : Colors.black,
//             onPressed: () =>
//                 Navigator.pushReplacementNamed(context, HomePage.routeName),
//           ),
//           GestureDetector(
//             onTap: () {
//               Provider.of<UploadPost>(context, listen: false)
//                   .selectPostImageType(context);
//             },
//             child: Container(
//               padding: const EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                 // color: Color(0xfff1f1f1),
//                 color: kerichblack,
//                 borderRadius: BorderRadius.circular(50),
//               ),
//               child: Icon(
//                 Icons.add_rounded,
//                 color: Colors.white,
//                 size: 28,
//               ),
//             ),
//           ),
//           IconButton(
//               icon: Icon(
//                 Icons.person_rounded,
//                 size: 28,
//               ),
//               color: MenuState.profile == selectedMenu
//                   ? inActiveIconColor
//                   : Colors.black,
//               onPressed: () {
//                 Navigator.pushReplacementNamed(
//                     context, ProfilePageNew.routeName);
//               }),
//         ],
//       ),
//     );
//   }
// }
