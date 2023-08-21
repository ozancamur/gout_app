import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gout_app/core/enum/firebase_enum.dart';
import 'package:gout_app/core/widgets/error/snackbar/error_snackbar.dart';
import 'package:gout_app/view/proile/model/profile_event_model.dart';
import 'package:gout_app/view/proile/model/profile_user_model.dart';

class ProfileViewModel extends GetxController {
  static ProfileViewModel get instance => Get.find();
  final box = GetStorage();
  var isLoading = false.obs;

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

  List<ProfileEventModel> userEventList = <ProfileEventModel>[].obs;
  Rx<ProfileUserModel> profileUserModel = ProfileUserModel(
    email: '',
    name: '',
    nickname: '',
    password: '',
    date: Timestamp(0, 0),
    friends: [],
    friendRequest: [],
  ).obs;

  Future<void> getUserEvents(String id) async {
    isLoading.value = true;
    try {
      QuerySnapshot events = await FirebaseFirestore.instance
          .collection("user")
          .doc(id)
          .collection("event")
          .get();
      for (final event in events.docs) {
        userEventList.clear();
        userEventList.add(
          ProfileEventModel(
            id: id,
            eventTitle: event["eventTitle"],
            eventDescription: event["eventDescription"],
            date: event["date"],
          ),
        );
        update();
        
      }
    } catch (e) {
      errorSnackbar("ProfileController, getUserEvents ERROR: ", "$e");
    }
    isLoading.value = false;
  }

  Future<void> getUserInfo() async {
    isLoading.value = true;
    try {
      DocumentSnapshot user =
          await FirebaseCollectionsEnum.user.col.doc(box.read("userUID")).get();

      profileUserModel.update(
        (val) {
          val!.email = user["email"];
          val.name = user["name"];
          val.nickname = user["nickname"];
          val.password = user["password"];
          val.friends = user["friends"];
          val.friendRequest = user["friendRequest"];
          update();
        },
      );
    } catch (e) {
      errorSnackbar("ProfileController, getUserInfoERROR: ", "$e");
    }
    isLoading.value = false;
  }
}
