class PostDataModel {
  final String caption;
  final String postId;
  final String postUrl;
  final String username;
  final String userId;
  final String userProfile;
  final List tags;
  final Map likes;
  final String timestamp;

  PostDataModel(
      {this.caption,
      this.postId,
      this.postUrl,
      this.username,
      this.userId,
      this.userProfile,
      this.tags,
      this.likes,
      this.timestamp});
}
