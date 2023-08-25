// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class FriendEventModel {


  String id;
  String eventTitle;
  String eventDescription;
  Timestamp date;
  FriendEventModel({
    required this.id,
    required this.eventTitle,
    required this.eventDescription,
    required this.date,
  });
  
}
