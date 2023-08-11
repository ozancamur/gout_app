import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:gout_app/core/enum/firebase_enum.dart';
import 'package:gout_app/view/login/model/login_model.dart';

class LoginController extends GetxController {
  List<LoginModel> userLoginModelList = <LoginModel>[].obs;

  Future<void> getLogin() async {
    try {
      QuerySnapshot users =
          await FirebaseCollectionsEnum.user.reference.get();

      userLoginModelList.clear();

      for (final doc in users.docs) {
        userLoginModelList.add(LoginModel(
            name: doc["name"], email: doc["email"], password: doc["password"]));
      }

      update();
    } catch (e) {
      Get.snackbar("LoginControllerError:", "$e");
    }
  }
}
