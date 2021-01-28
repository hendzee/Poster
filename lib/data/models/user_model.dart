import 'dart:convert';

class UserModel {
  final String id;
  final String firstName;
  final String lastName;
  final String photo;
  final String country;
  final String email;
  final String phone;
  final String password;

  UserModel({
    this.id = '',
    this.firstName = '',
    this.lastName = '',
    this.photo = '',
    this.country = '',
    this.email = '',
    this.phone = '',
    this.password = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'photo': photo,
      'country': country,
      'email': email,
      'phone': phone,
      'password': password,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return UserModel(
      id: map['id'].toString(),
      firstName: map['first_name'],
      lastName: map['last_name'],
      photo: map['photo'],
      country: map['country'],
      email: map['email'],
      phone: map['phone'],
      password: map['password'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
