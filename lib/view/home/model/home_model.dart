import 'package:cloud_firestore/cloud_firestore.dart';

class HomeModel {
  HomeModel({
    required this.eventTitle,
    required this.eventDescription,
    required this.location,
    required this.date
  });

  String eventTitle;
  String eventDescription;
  String location;
  Timestamp date;
  
}