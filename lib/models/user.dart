import 'package:equatable/equatable.dart';

class User extends Equatable {
  int? id;
  String? username;
  String? name;
  String? role;
  String? noHp;
  String? dateOfBirth;
  String? email;
  String? createdAt;
  String? updatedAt;
  String? photo;
 static String? token;

  User(
      {this.id,
      this.username,
      this.name,
      this.role,
      this.noHp,
      this.dateOfBirth,
      this.email,
      this.createdAt,
      this.updatedAt,
      this.photo,
    });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    name = json['name'];
    role = json['role'];
    noHp = json['no_hp'];
    dateOfBirth = json['date_of_birth'];
    email = json['email'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['name'] = this.name;
    data['role'] = this.role;
    data['no_hp'] = this.noHp;
    data['date_of_birth'] = this.dateOfBirth;
    data['email'] = this.email;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }

  User copyWith({
  String? username,
  String? name,
  String? role,
  String? noHp,
  String? dateOfBirth,
  String? email,
  String? photo,
  }){
    return User(
      id:id,
      username:username??this.username,
      name:name??this.name,
      role:role??this.role,
      noHp:noHp??this.noHp,
      dateOfBirth:dateOfBirth??this.dateOfBirth,
      email:email??this.email,
      photo: photo??this.photo,
      createdAt:createdAt,
      updatedAt:updatedAt,
    );
  }
  
  @override
  List<Object?> get props =>[
    id,
      username,
      name,
      role,
      noHp,
      dateOfBirth,
      email,
      createdAt,
      updatedAt,
      photo,
  ];
}