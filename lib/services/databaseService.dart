import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:artsvalley/profile_page/edit_Profile.dart';

class DatabaseService with ChangeNotifier {
  final String uid;
  DatabaseService({this.uid});

  String userEmail, userName, userImage, fullName;
  String get getUserName => userName;
  String get getUserEmail => userEmail;
  String get getUserImage => userImage;
  String get getName => fullName;
  TextEditingController fullNameInputController = new TextEditingController();

  final userid = FirebaseAuth.instance.currentUser.uid;

  UploadTask imageUploadTask;

  //collection refernce
  final CollectionReference userDataref =
      FirebaseFirestore.instance.collection('users');

  //Actully this function that i created we are using it for creating record collection to cloud firebase and  updation of data
  //ignore this

  Future updateUserData(String username, String name, String email,
      String profilePhotoUrl) async {
    return await userDataref.doc(uid).set({
      'Fullname': fullNameInputController.text,
      'email': email,
      'username': username,
      'profilephoto': profilePhotoUrl,
      'createdAt': FieldValue.serverTimestamp(),
      //'UpdatedAt': FieldValue.serverTimestamp(),
    });
  }

/*   Future updateUserData(BuildContext context/* String username, String name, String email,
      String profilePhotoUrl */) async {
    return await userDataref.doc(uid).set({
      'Fullname': fullNameInputController.text,
      'email': user.email,
      'username': user.email.replaceAll("@gmail.com", "").trim() ,
      'profilephoto': Provider.of<EditProfile>(context,listen: false).getUserProfileImageUrl,
      'createdAt': FieldValue.serverTimestamp(),
      //'UpdatedAt': FieldValue.serverTimestamp(),
    });
  } */



 //ignore this
/*   ProfileData _myUserDataFromSnapshot(DocumentSnapshot snapshot) {
    return ProfileData(
      name: snapshot.get('name') ?? '',
      email: snapshot.get('email') ?? '',
      profileimage: snapshot.get('profilephoto') ??
          Image.network(
              'https://lh3.googleusercontent.com/proxy/a34VSeclECQE_BkxVVNF4d9hVtYRoxZYcVDwNEOX29Kiolht0guT8B4d-UjzcVDDruCHMi7btrLRHy7s7_KvAdJHG_OqXAnNdfu9yayR5EjrlIPGJHEQ'),
      username: snapshot.get('username'),
    );
  }
 //ignore this
  Stream<ProfileData> get userData {
    return userDataref.doc(uid).snapshots().map(_myUserDataFromSnapshot);
  } */

  //get usersdata from snapshot
  //Stream collectionStream = FirebaseFirestore.instance.collection('users').snapshots();

  /* List<ProfileData> _dataFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc){
      return ProfileData(
        name: doc.data()['name'] ?? '',
        email: doc.data()['email'] ?? '',
        username: doc.data()['username'] ?? '',
        profileimage: doc.data()['profileData'] ?? Image.network('https://lh3.googleusercontent.com/proxy/a34VSeclECQE_BkxVVNF4d9hVtYRoxZYcVDwNEOX29Kiolht0guT8B4d-UjzcVDDruCHMi7btrLRHy7s7_KvAdJHG_OqXAnNdfu9yayR5EjrlIPGJHEQ')
      );
    }).toList();
  }*/

  // Get userdata stream
/*   Stream<QuerySnapshot> get usersData {
    return userDataref.snapshots();
  }  */

  //initial data for stream


//for profile picture
  //user Profile image upload task
  Future uploadUserProfileImage(BuildContext context) async {
    Reference imgReference = FirebaseStorage.instance.ref().child(
        'UserProfileImage/${Provider.of<EditProfile>(context, listen: false).userProfileImage.path}/${TimeOfDay.now()}');

    imageUploadTask = imgReference.putFile(
        Provider.of<EditProfile>(context, listen: false).getUserProfileImage);
    await imageUploadTask.whenComplete(() {
      print("Image Uploaded");
    });
    imgReference.getDownloadURL().then((url) {
      Provider.of<EditProfile>(context, listen: false).userProfileImageUrl =
          url.toString();
      print(
          "User Profile image url = ${Provider.of<EditProfile>(context, listen: false).getUserProfileImageUrl}");
      notifyListeners();
    });
  }

//creating post collection into firestore
  Future uploadPostData(String postId, dynamic data) async {
    return FirebaseFirestore.instance.collection('posts').doc(postId).set(data);
  }

  //creating collection
  Future createUserCollection(BuildContext context, dynamic data) async {
    return userDataref
        .doc(userid)
        .set(data);
  }
  //for accessing data fro, firestore
  Future initUserData(BuildContext context)async{
    return userDataref
    .doc(userid)
    .get()
    .then((doc) => {
      print('Fetching user data'),
      userName = doc.data()['username'],
      userEmail = doc.data()['email'],
      userImage = doc.data()['photophoto'],
      fullName = doc.data()['name'],
      print(userName),
      print(userEmail),
      print(userImage),
      print(fullName),
      notifyListeners(),
    });
  }

  notifyListeners();
}
