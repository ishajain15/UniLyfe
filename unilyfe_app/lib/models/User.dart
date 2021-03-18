class User {
  String username;
  String displayName;
  String bio;
  String year;
  String picturePath;
  String covid;
  String location;

  User(this.username, this.displayName, this.bio, this.year
      //this.displayName,
      //this.bio,
      //this.picturePath,
      );


  Map<String, dynamic> toJson() => {
        'username': username,
        'displayName': displayName,
        'bio': bio,
        'picturePath': picturePath,
        'covid': covid,
        'location': location,
      };
}
