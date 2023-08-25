// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gout_app/core/enum/firebase_enum.dart';
import 'package:gout_app/core/firebase/firebase_firestore.dart';
import 'package:gout_app/core/widgets/error/snackbar/error_snackbar.dart';
import 'package:gout_app/view/friend/model/friend_event_model.dart';
import 'package:gout_app/view/friend/model/friend_user_model.dart';

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
    friends: [], 
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
        val.friends = friend["friends"];
      });
      update();
    } catch (e) {
      errorSnackbar("FriendViewModel, getFriendsInfo ERROR: ", "$e");
    }
  }

  void isMyFriendCheck () {
    user.value.friends.forEach((element) { 
      if(element == box.read("userUID")) {
        isMyFriend.value = true;
        update();
      }
    });
  }

  Future<void> getFriendsEvents(String id) async {
    try {
      QuerySnapshot events = await FirebaseFirestore.instance
          .collection("user")
          .doc(id)
          .collection("event")
          .get();
      userEvents.clear();
      for (final event in events.docs) {
        userEvents.add(
          FriendEventModel(
            id: id,
            eventTitle: event["eventTitle"],
            eventDescription: event["eventDescription"],
            date: event["date"],
          ),
        );
      }
      update();
    } catch (e) {
      errorSnackbar("ProfileController, getUserEvents ERROR: ", "$e");
    }
  }

}
