// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileUserModel {
  String name;
  String nickname;
  String email;
  String password;
  Timestamp date;
  List friends;
  List friendRequest;
  ProfileUserModel({
    required this.name,
    required this.nickname,
    required this.email,
    required this.password,
    required this.date,
    required this.friends,
    required this.friendRequest
  });
}
