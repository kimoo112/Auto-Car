class LoginResponseModel {
  String? id;
  String? name;
  String? email;
  String? token;

  LoginResponseModel({this.id, this.name, this.email, this.token});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      token: json['token'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'email': email,
        'token': token,
      };
}
