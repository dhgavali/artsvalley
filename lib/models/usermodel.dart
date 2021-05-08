class UserModel {
  String username;
  String email;
  String photoUrl;
  String userId;
  String name;

  UserModel({
    this.username,
    this.email,
    this.userId,
    this.photoUrl,
    this.name
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    name = json['displayname'];
    photoUrl = json['photoUrl'];
    userId = json['userid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['email'] = this.email;
    data['displayname'] = this.name;
    data['photoUrl'] = this.photoUrl;
    data['userid'] = this.userId;

    return data;
  }
}
