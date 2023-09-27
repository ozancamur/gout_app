import 'package:get/get.dart';
import 'package:gout_app/core/services/firebase/firebase_auth_controller.dart';
import 'package:gout_app/core/services/firebase/firebase_firestore.dart';
import 'package:gout_app/core/services/firebase/firebase_storage_controller.dart';
import 'package:gout_app/view/create/viewmodel/create_view_model.dart';
import 'package:gout_app/view/detail/viewmodel/detail_view_model.dart';
import 'package:gout_app/view/friend/friends/viewmodel/friends_view_model.dart';
import 'package:gout_app/view/friend/profile/viewmodel/friend_profile_view_model.dart';
import 'package:gout_app/view/friend/request/viewmodel/request_view_model.dart';
import 'package:gout_app/view/home/viewmodel/home_view_model.dart';
import 'package:gout_app/view/login/viewmodel/login_view_model.dart';
import 'package:gout_app/view/proile/viewmodel/profile_view_model.dart';
import 'package:gout_app/view/search/viewmodel/search_view_model.dart';
import 'package:gout_app/view/settings/viewmodel/settings_view_model.dart';

class DataControllerBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<LoginViewModel>(LoginViewModel());
    Get.put<HomeViewModel>(HomeViewModel());
    Get.put<FirebaseAuthController>(FirebaseAuthController());
    Get.put<FirebaseFirestoreController>(FirebaseFirestoreController());
    Get.put<DetailViewModel>(DetailViewModel());    
    Get.put<SearchViewModel>(SearchViewModel());
    Get.put<CreateViewModel>(CreateViewModel());
    Get.put<ProfileViewModel>(ProfileViewModel());
    Get.put<SettingsViewModel>(SettingsViewModel());
    Get.put<RequestViewModel>(RequestViewModel());
    Get.put<FriendsViewModel>(FriendsViewModel()); 
    Get.put<FriendProfileViewModel>(FriendProfileViewModel());
    Get.put<FirebaseStorageController>(FirebaseStorageController());
  }
}
