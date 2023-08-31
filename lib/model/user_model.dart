class UserModel {
  String email;
  String name;
  String bio;
  String profilePicture;
  String createAt;
  String phoneNumber;
  String uid;

  UserModel({
    required this.email,
    required this.name,
    required this.bio,
    required this.profilePicture,
    required this.createAt,
    required this.phoneNumber,
    required this.uid,
  });
  //from mao
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      bio: map['bio'] ?? '',
      profilePicture: map['profilePicture'] ?? '',
      createAt: map['createAt'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      uid: map['uid'] ?? '',
    );
  }
  //to map
  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "bio": bio,
      "uid": uid,
      "profilePicture": profilePicture,
      "phoneNumber": phoneNumber,
      "createAt": createAt,
    };
  }
}
