import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';


class RegisterController extends GetxController {

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  void registerUser(String email, String password) {
    try {
      firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    } catch(e) {
      Get.snackbar("RegisterControllerERROR:", "$e");
    }
  }



}