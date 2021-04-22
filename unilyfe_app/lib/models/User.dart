class User {

  User(this.username, this.displayName, this.bio, this.year, this.classes,
      this.hobbies, this.points, this.awards);
  String username;
  String displayName;
  String bio;
  String year;
  String picturePath;
  String covid;
  String location;
  List<String> classes;
  List<String> hobbies;
  int points;
  int awards;

  Map<String, dynamic> toJson() => {
        'username': username,
        'displayName': displayName,
        'bio': bio,
        'picturePath': picturePath,
        'covid': covid,
        'location': location,
        'year': year,
        'classes': classes,
        'hobbies': hobbies,
        'awards': awards
      };
}
