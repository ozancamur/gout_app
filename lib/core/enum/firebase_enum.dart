

import 'package:cloud_firestore/cloud_firestore.dart';

enum FirebaseCollectionsEnum {
  user,
  event,
  version;

  CollectionReference get col => 
    FirebaseFirestore.instance.collection(name);

  

}