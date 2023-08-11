import 'package:get/get.dart';
import 'package:gout_app/view/login/controller/login_controller.dart';

class DataControllerBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<LoginController>(LoginController());
  }
}