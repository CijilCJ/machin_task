class UserModel {
  String uuid;
  String name;
  String email;
  String role;

  UserModel({
    required this.uuid,
    required this.name,
    required this.email,
    required this.role
  });

  factory UserModel.fromjson(Map<String,dynamic>json){
    return UserModel(
      uuid: json["uuid"], 
      name: json["name"], 
      email: json["email"], 
      role: json["role"]
    );
  }
  Map<String,dynamic>toJson(){
    return{
      "uuid":uuid,
      "name":name,
      "email":email,
      "role":role
    };
  }
}