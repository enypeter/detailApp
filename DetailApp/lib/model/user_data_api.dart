import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  final String firstName;
  final String lastName;
  final String address;
  final String designation;
  final String hobby;
  final String interest;

  UserModel({
    this.firstName,
    this.lastName,
    this.address,
    this.designation,
    this.hobby,
    this.interest,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        firstName: json['firstName'],
        lastName: json['lastName'],
        address: json['address'],
        designation: json['designation'],
        hobby: json['hobby'],
        interest: json['interest'],
      );

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'address': address,
        'designation': designation,
        'hobby': hobby,
        'interest': interest,
      };
}
