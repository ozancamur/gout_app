import 'package:cloud_firestore/cloud_firestore.dart';

class HomeModel {
  HomeModel({
    required this.createdOnDate,
    required this.createrId,
    required this.date,
    required this.eventDescription,
    required this.eventTitle,
    required this.id,
    required this.arrivals
  });
  String id;
  Timestamp createdOnDate;
  String createrId;
  Timestamp date;
  String eventDescription;
  String eventTitle;
  List arrivals;
  
}