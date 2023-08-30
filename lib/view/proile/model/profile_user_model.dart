// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileUserModel {
  String name;
  String nickname;
  String email;
  String password;
  Timestamp date;
  List followers;
  List requests;
  List favorites;
  String photoURL;
  ProfileUserModel({
    required this.name,
    required this.nickname,
    required this.email,
    required this.password,
    required this.date,
    required this.followers,
    required this.requests,
    required this.favorites,
    required this.photoURL
    
  });
}
