// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gout_app/core/enum/firebase_enum.dart';
import 'package:gout_app/core/firebase/firebase_firestore.dart';
import 'package:gout_app/core/widgets/error/snackbar/error_snackbar.dart';
import 'package:gout_app/view/friend/model/friend_user_model.dart';
import 'package:gout_app/view/proile/viewmodel/profile_view_model.dart';

class RequestViewModel extends GetxController {
  final box = GetStorage();
  final firestore = Get.put(FirebaseFirestoreController());
  var isLoading = false.obs;
  final friendRequestsList = Get.put(ProfileViewModel());


  List<FriendUserModel> friendRequestList = <FriendUserModel>[].obs;

  Future<void> getFriendRequest() async {
    isLoading.value = true;
    try {
      friendRequestsList.profileUserModel.value.friendRequest.forEach(
        (query) async {
          await FirebaseCollectionsEnum.user.col
              .where("uuid", isGreaterThanOrEqualTo: query)
              .get()
              .then((value) {
            friendRequestList.clear();
            for (final val in value.docs) {
              if (val.id != box.read("userUID")) {
                friendRequestList.add(
                  FriendUserModel(
                      id: val.id,
                      name: val["name"],
                      nickname: val["nickname"],
                      friends: val["friends"], 
                      ),
                );
              } else {
                null;
              }
            }
          });
        },
      );
      update();
    } catch (e) {
      errorSnackbar("FriendViewModel, getFriendRequest ERROR:", "$e");
    }
    isLoading.value = false;
  }



}
