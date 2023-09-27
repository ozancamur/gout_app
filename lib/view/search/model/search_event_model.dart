// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchEventModel {
  String id;
  Timestamp createdOnDate;
  String createrId;
  Timestamp date;
  String eventDescription;
  String eventTitle;
  SearchEventModel({
    required this.id,
    required this.createdOnDate,
    required this.createrId,
    required this.date,
    required this.eventDescription,
    required this.eventTitle,
  });

}
