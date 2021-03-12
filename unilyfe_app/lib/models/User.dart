class User {
  String username;
  String displayName;
  String bio;
  String picturePath;

  User(
    this.username,
    //this.displayName,
    //this.bio,
    //this.picturePath,
  );

  Map<String, dynamic> toJson() => {
        'username': username,
        'displayName': displayName,
        'bio': bio,
        'picturePath': picturePath,
      };
}
