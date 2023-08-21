import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gout_app/core/enum/firebase_enum.dart';
import 'package:gout_app/core/widgets/error/snackbar/error_snackbar.dart';
import 'package:gout_app/view/friend/model/friend_model.dart';
import 'package:gout_app/view/proile/viewmodel/profile_view_model.dart';

class FriendViewModel extends GetxController {
  static FriendViewModel get instance => Get.find();
  final box = GetStorage();
  var isLoading = false.obs;
  final friendRequestsList = Get.put(ProfileViewModel());

  List<FriendModel> friendRequest = <FriendModel>[].obs;
  List<FriendModel> friends = <FriendModel>[].obs;

  Future<void> getFriends() async {
    isLoading.value = true;
    try {
      friendRequestsList.profileUserModel.value.friends.forEach(
        (query) async {
          await FirebaseCollectionsEnum.user.col
              .where("uuid", isGreaterThanOrEqualTo: query)
              .get()
              .then((value) {
            friends.clear();
            for (final val in value.docs) {
              if (val.id != box.read("userUID")) {
                friends.add(FriendModel(
                    id: val.id, name: val["name"], nickname: val["nickname"]));
              } else {
                null;
              }
            } 
          });
        },
      );
      update();
    } catch (e) {
      errorSnackbar(" getFriends ERROR:", "$e");
    }
    isLoading.value = false;
  }

  Future<void> getFriendRequest() async {
    isLoading.value = true;
    try {
      friendRequestsList.profileUserModel.value.friendRequest.forEach(
        (query) async {
          await FirebaseCollectionsEnum.user.col
              .where("uuid", isGreaterThanOrEqualTo: query)
              .get()
              .then((value) {
            friendRequest.clear();
            for (final val in value.docs) {
              if (val.id != box.read("userUID")) {
                friendRequest.add(FriendModel(
                    id: val.id, name: val["name"], nickname: val["nickname"]));
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
