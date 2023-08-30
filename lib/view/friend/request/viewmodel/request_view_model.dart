// ignore_for_file: avoid_function_literals_in_foreach_calls
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gout_app/core/enum/firebase_enum.dart';
import 'package:gout_app/core/firebase/firebase_firestore.dart';
import 'package:gout_app/core/widgets/error/snackbar/error_snackbar.dart';
import 'package:gout_app/view/friend/request/model/request_model.dart';
import 'package:gout_app/view/proile/viewmodel/profile_view_model.dart';

class RequestViewModel extends GetxController {
  FirebaseFirestoreController firestore =
      Get.put(FirebaseFirestoreController());
  final box = GetStorage();
  var isLoading = false.obs;
  final profileViewModel = Get.put(ProfileViewModel());

  List<RequestModel> friendRequestList = <RequestModel>[].obs;

  Future<void> getFriendRequest(List list) async {
    isLoading.value = true;
    try {
      list.forEach((element) async {
        friendRequestList.clear();
        DocumentSnapshot request = await FirebaseCollectionsEnum.user.col.doc(element).get();
        friendRequestList.add(RequestModel(
            id: request.id,
            name: request["name"],
            nickname: request["nickname"]));
        
      });
    } catch (e) {
      errorSnackbar("FriendViewModel, getFriendRequest ERROR:", "$e");
    }
    isLoading.value = false;
  }

  void acceptRequest(String id) {
    firestore.acceptFriendRequest(id);
  }

  void cancelRequest(String id) {
    firestore.cancelFriendRequest(id);
  }
}
