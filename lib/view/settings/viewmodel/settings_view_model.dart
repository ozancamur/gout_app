import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gout_app/core/enum/firebase_enum.dart';
import 'package:gout_app/core/firebase/firebase_auth_controller.dart';
import 'package:gout_app/core/firebase/firebase_firestore.dart';
import 'package:gout_app/core/widgets/error/snackbar/error_snackbar.dart';
import 'package:gout_app/view/settings/model/settings.dart';

class SettingsViewModel extends GetxController {

  final firebaseAuth = Get.put(FirebaseAuthController());
  final firebaseFirestore = Get.put(FirebaseFirestoreController());
  final box = GetStorage();

  TextEditingController tecText = TextEditingController();
  Rx<SettingsModel> settings = SettingsModel(joinedDate: DateTime(0)).obs;

  void signOut () {
    firebaseAuth.signOut();
  }

  void changeNickname() {
    firebaseFirestore.changeNickName(tecText.text);
    tecText.clear();
  }

  void changeEmail() {
    firebaseFirestore.changeEmail(tecText.text);
    firebaseAuth.changeEmail(tecText.text);
    tecText.clear();
  }

  void changePassword() {
    firebaseFirestore.changePassword(tecText.text);
    firebaseAuth.changePassword(tecText.text);
    tecText.clear();
  }

  Future<void> joinedDate() async {
    try {
      DocumentSnapshot me = await FirebaseCollectionsEnum.user.col.doc(box.read("userUID")).get();
      settings.update((val) { 
        val!.joinedDate = me["joinedDate"].toDate();
      });
      update();
    } catch (e) {
      errorSnackbar("SettingsViewModel, joinedDate ERROR: ", "$e");
    }
  }

}