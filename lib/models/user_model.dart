import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  @JsonKey(ignore: true)
  String? uid;
  final String firstName;
  final String lastName;
  final String college;
  final String location;
  final String email;

  UserModel({
    this.uid,
    required this.firstName,
    required this.lastName,
    required this.college,
    required this.location,
    required this.email,
  });

  factory UserModel.fromDocument(Map<String, dynamic> data, String uid) {
    return _$UserModelFromJson(data)..uid = uid;
  }

  toJson() {
    return _$UserModelToJson(this);
  }
}
