class User {
  User(this.username, this.displayName, this.bio, this.year, this.classes,
      this.hobbies, this.points);
  String username;
  String displayName;
  String bio;
  String year;
  String picturePath;
  String covid;
  String location;
  int points;
  List<String> classes;
  List<String> hobbies;

  Map<String, dynamic> toJson() => {
        'username': username,
        'displayName': displayName,
        'bio': bio,
        'picturePath': picturePath,
        'covid': covid,
        'location': location,
        'year': year,
        'classes': classes,
        'hobbies': hobbies
      };
}
