import 'package:get/get.dart';
import 'package:gout_app/core/firebase/firebase_auth_controller.dart';
import 'package:gout_app/core/firebase/firebase_firestore.dart';
import 'package:gout_app/view/create/viewmodel/create_view_model.dart';
import 'package:gout_app/view/detail/viewmodel/detail_view_model.dart';
import 'package:gout_app/view/home/viewmodel/home_view_model.dart';
import 'package:gout_app/view/login/viewmodel/login_view_model.dart';
import 'package:gout_app/view/proile/viewmodel/profile_view_model.dart';
import 'package:gout_app/view/search/viewmodel/serach_view_model.dart';
import 'package:gout_app/view/settings/viewmodel/settings_view_model.dart';

class DataControllerBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<FirebaseAuthController>(FirebaseAuthController());
    Get.put<FirebaseFirestoreController>(FirebaseFirestoreController());
    Get.put<LoginViewModel>(LoginViewModel());
    Get.put<HomeViewModel>(HomeViewModel());
    Get.put<DetailViewModel>(DetailViewModel());    
    Get.put<SearchViewModel>(SearchViewModel());
    Get.put<CreateViewModel>(CreateViewModel());
    Get.put<ProfileViewModel>(ProfileViewModel());
    Get.put<SettingsViewModel>(SettingsViewModel());
    //Get.put<NotificationController>(NotificationController());
}
}
