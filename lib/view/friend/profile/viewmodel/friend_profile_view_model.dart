// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gout_app/core/enum/firebase_enum.dart';
import 'package:gout_app/core/services/firebase/firebase_firestore.dart';
import 'package:gout_app/core/widgets/error/snackbar/error_snackbar.dart';
import 'package:gout_app/view/friend/friends/model/friend_event_model.dart';
import 'package:gout_app/view/friend/profile/model/friend_user_model.dart';

class FriendProfileViewModel extends GetxController {
  final box = GetStorage();
  final firestore = Get.put(FirebaseFirestoreController());
  var isLoading = false.obs;
  var isMyFriend = false.obs;

  final Map<int, String> monthMap = {
    01: "Jan",
    02: "Feb",
    03: "Mar",
    04: "Apr",
    05: "May",
    06: "June",
    07: "July",
    08: "Aug",
    09: "Sep",
    10: "Oct",
    11: "Nov",
    12: "Dec",
  };

  Rx<FriendUserModel> user = FriendUserModel(
    id: "",
    name: "",
    nickname: "",
    followers: [],
    photoURL: ""
  ).obs;
  List<FriendEventModel> userEvents = <FriendEventModel>[].obs;

  Future<void> getFriendInfo(String id) async {
    try {
      DocumentSnapshot friend =
          await FirebaseCollectionsEnum.user.col.doc(id).get();
      user.update((val) {
        val!.id = friend.id;
        val.name = friend["name"];
        val.nickname = friend["nickname"];
        val.followers = friend["followers"];
        val.photoURL = friend["photoURL"];
      });
      update();
    } catch (e) {
      errorSnackbar("FriendViewModel, getFriendsInfo ERROR: ", "$e");
    }
  }

  Future<void> getFriendEvents(String id) async {
    isLoading.value = true;
    try {
      await FirebaseFirestore.instance
          .collection("event")
          .where("createrId", isEqualTo: box.read("userUID"))
          .get()
          .then(
        (events) {
          userEvents.clear();
          for (final event in events.docs) {
            userEvents.add(
              FriendEventModel(
                id: event.id,
                eventTitle: event["eventTitle"],
                eventDescription: event["eventDescription"],
                date: event["date"],
                createrId: event["createrId"]
              ),
            );
          }
        },
      );
    } catch (e) {
      errorSnackbar("ProfileController, getUserEvents ERROR: ", "$e");
    }
    isLoading.value = false;
  }

  Future<void> isMyFriendCheck(List ids) async {
    if(ids.contains(box.read("userUID"))){
      isMyFriend.value = true;
    } else {
      isMyFriend.value = false;
    }
  }
}
