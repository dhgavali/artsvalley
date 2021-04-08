import 'package:artsvalley/helper/sharedpref.dart';

class UserData {
  final String userName;
  final String userEmail;
  final String profileUrl;
  final String displayName;
  final String userId;
  UserData(
      {this.userName,
      this.userEmail,
      this.profileUrl,
      this.displayName,
      this.userId});

 SharedPrefsHelper _sharedPref = new SharedPrefsHelper();
  void getData() async{
     String _username = await _sharedPref.getUsername();
                String _userPhotoUrl = await _sharedPref.getUserProfileUrl();
                String _userDisplayName = await _sharedPref.getDisplayName();
                String _userId = await _sharedPref.getUserId();
  }
}
