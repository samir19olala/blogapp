
// create class user
class User{
  final String id;
  final String name;
  final String email;
  final String avatar;
  final String role;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.avatar,
    required this.role
    });

  factory User.fromJson(Map<String,dynamic>json){
    return User(
      id: json["_id"],
      name:json["name"],
      avatar:json["avatar"],
      email:json["email"],
      role:json["role"]
    );
  }

  Map<String,dynamic>toJson(){
    return {
      "name": name,
      "email": email,
      "avatar": avatar,
      "role": role
    };
  }

}