import 'package:get/get.dart';
import 'package:gout_app/view/home/controller/home_controller.dart';
import 'package:gout_app/view/login/viewmodel/login_view_model.dart';

class DataControllerBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<LoginViewModel>(LoginViewModel());
    Get.put<HomeController>(HomeController());
  }
}