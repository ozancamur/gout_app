

import 'package:cloud_firestore/cloud_firestore.dart';

enum FirebaseCollectionsEnum {
  user,
  event;

  CollectionReference get reference => 
    FirebaseFirestore.instance.collection(name);

}