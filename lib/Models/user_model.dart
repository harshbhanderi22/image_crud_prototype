class UserModel {
  final String name;
  final String uid;
  final String email;
  final List<String> followers;
  final String profile_image;

  UserModel(
      {required this.name,
      required this.uid,
      required this.email,
      required this.followers,
      required this.profile_image});

  Map<String, dynamic> toMap(String id) {
    return {
      'name': name,
      'uid': uid,
      'email': email,
      'followers': followers,
      'profile_image': profile_image,
    };
  }

  UserModel.fromMap(Map<String, dynamic> map)
      : uid = map['uid'] ?? "",
        name = map['name'] ?? '',
        email = map['email'] ?? '',
        profile_image = map['profile_image'] ?? '',
        followers = map['followers'] ?? [];
}
