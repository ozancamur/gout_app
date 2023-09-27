import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gout_app/core/services/constant/color/color_constants.dart';
import 'package:gout_app/core/services/firebase/firebase_auth_controller.dart';
import 'package:gout_app/core/widgets/error/snackbar/error_snackbar.dart';
import 'package:gout_app/view/login/view/register_view.dart';

class LoginViewModel extends GetxController {
  final firebaseAuth = Get.put(FirebaseAuthController());

  Rx<bool> passwordVisible = false.obs;

  TextEditingController tecMail = TextEditingController();
  TextEditingController tecPassword = TextEditingController();

  List<Color> colors = [
    ColorConstants.goutSecondColor,
    ColorConstants.goutMainColor,
    ColorConstants.goutThirdColor
  ];


  var keybord = false.obs;

  Future<void> login(String email, String password) async {
    String? error =
        await firebaseAuth.loginWithEmailAndPassword(email, password);
    if (error != null) {
      errorSnackbar("LoginViewModel, loginERROR: ", error);
    }
  }

  void goToRegisterView() {
    Get.off(() => RegisterView());
  }
}
