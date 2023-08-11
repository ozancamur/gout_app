

import 'package:cloud_firestore/cloud_firestore.dart';

enum FirebaseCollectionsEnum {
  user;

  CollectionReference get reference => 
    FirebaseFirestore.instance.collection(name);

}