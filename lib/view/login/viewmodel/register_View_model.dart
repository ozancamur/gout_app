// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gout_app/core/firebase/firebase_auth_controller.dart';
import 'package:gout_app/view/login/view/login_view.dart';

import '../../../core/widgets/error/snackbar/error_snackbar.dart';

class RegisterViewModel extends GetxController {
  static RegisterViewModel get instance => Get.find();

  final firebaseAuth = Get.put(FirebaseAuthController.instance);

  Rx<bool> passwordVisible = false.obs;

  TextEditingController tecName = TextEditingController();
  TextEditingController tecMail = TextEditingController();
  TextEditingController tecPassword = TextEditingController();

  void register(String email, String password) {
    Future<String?> error =
        firebaseAuth.createUserWithEmailAndPassword(email, password);
    if (error != null) {
      errorSnackbar("RegisterViewModel, registerERROR: ", "$error");
    }
  }

  void goToLoginView() {
    Get.to(() => LoginView());
  }
}
