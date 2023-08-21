import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gout_app/core/firebase/firebase_auth_controller.dart';
import 'package:gout_app/core/firebase/firebase_firestore.dart';

class SettingsViewModel extends GetxController {

  static SettingsViewModel get instance => Get.find();
  final firebaseAuth = Get.put(FirebaseAuthController.instance);
  final firebaseFirestore = Get.put(FirebaseFirestoreController());

  TextEditingController tecNickname = TextEditingController();

  void signOut () {
    firebaseAuth.signOut();
  }

  void changeNickname() {
    firebaseFirestore.changeNickName(tecNickname.text);
    tecNickname.clear();
  }

}