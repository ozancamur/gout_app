import 'package:get/get.dart';
import 'package:gout_app/core/firebase/firebase_auth_controller.dart';

class SettingsViewModel extends GetxController {

  static SettingsViewModel get instance => Get.find();

  final firebaseAuth = Get.put(FirebaseAuthController.instance);

  void signOut () {
    firebaseAuth.signOut();
  }
}