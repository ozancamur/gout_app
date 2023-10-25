// ignore_for_file: unnecessary_null_comparison, file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gout_app/core/constant/color/color_constants.dart';
import 'package:gout_app/core/services/firebase/firebase_auth_controller.dart';
import 'package:gout_app/core/random_nick/random_nick.dart';
import 'package:gout_app/view/login/view/login_view.dart';

import '../../../core/widgets/error/snackbar/error_snackbar.dart';

class RegisterViewModel extends GetxController {

  final firebaseAuth = Get.put(FirebaseAuthController());
  RandomNick randomNick = RandomNick();

  Rx<bool> passwordVisible = false.obs;

  TextEditingController tecName = TextEditingController();
  TextEditingController tecMail = TextEditingController();
  TextEditingController tecPassword = TextEditingController();

  List<Color> colors = [
    ColorConstants.goutSecondColor,
    ColorConstants.goutMainColor,
    ColorConstants.goutThirdColor
  ];

  void register(String name, String email, String password) {
    try {
        String nickname = randomNick.getRandomNick(7);
        firebaseAuth.createUserWithEmailAndPassword(name, email, password, nickname);
    } catch (e) {
      errorSnackbar("RegisterViewModel, registerERROR: ", "$e");
    }
  }

  void goToLoginView() {
    Get.off(() => LoginView());
  }
}
