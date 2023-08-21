// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileEventModel {


  String id;
  String eventTitle;
  String eventDescription;
  Timestamp date;
  ProfileEventModel({
    required this.id,
    required this.eventTitle,
    required this.eventDescription,
    required this.date,
  });
  
}
