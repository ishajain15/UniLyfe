class User {
  String username;
  String bio;
  String picturePath;

  User(this.username);

    Map<String, dynamic> toJson() => {
    'username': username,
    //'bio': bio,
    //'picturePath': picturePath,
  };

}