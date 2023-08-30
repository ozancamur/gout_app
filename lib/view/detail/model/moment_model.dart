// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class MomentModel {
  String comment;
  Timestamp createdOnDate;
  String createrId;
  String momentImageUrl;
  String owner;
  MomentModel({
    required this.comment,
    required this.createdOnDate,
    required this.createrId,
    required this.momentImageUrl,
    required this.owner
  });
}
