// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gout_app/core/enum/firebase_enum.dart';
import 'package:gout_app/core/firebase/firebase_firestore.dart';
import 'package:gout_app/core/widgets/error/snackbar/error_snackbar.dart';
import 'package:gout_app/view/friend/profile/model/friend_user_model.dart';
import 'package:gout_app/view/proile/viewmodel/profile_view_model.dart';

class FriendsViewModel extends GetxController {
  final box = GetStorage();
  final firestore = Get.put(FirebaseFirestoreController());
  var isLoading = false.obs;
  final profileViewModel = Get.put(ProfileViewModel());
  final message = "".obs;

  List<FriendUserModel> friendsList = <FriendUserModel>[].obs;

  Future<void> getFriends(List list) async {
    isLoading.value = true;
    try {
      list.forEach(
        (element) async {
          friendsList.clear();
          DocumentSnapshot friend =
              await FirebaseCollectionsEnum.user.col.doc(element).get();
          friendsList.add(
            FriendUserModel(
              id: friend.id,
              name: friend["name"],
              nickname: friend["nickname"],
              followers: friend["followers"],
            ),
          );
        },
      );
    } catch (e) {
      errorSnackbar("getFriends ERROR:", "$e");
    }
    isLoading.value = false;
  }

  Future<void> unfollowFriend(String id, index) async {
    firestore.unfollowTheUser(id);
    friendsList.removeAt(index);
  }
}
