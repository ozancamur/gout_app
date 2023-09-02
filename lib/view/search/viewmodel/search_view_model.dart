import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gout_app/core/constant/color/color_constants.dart';
import 'package:gout_app/core/enum/firebase_enum.dart';
import 'package:gout_app/core/widgets/error/snackbar/error_snackbar.dart';
import 'package:gout_app/view/search/model/search_event_model.dart';
import 'package:gout_app/view/search/model/search_user_model.dart';

class SearchViewModel extends GetxController {
  final box = GetStorage();

  List<Color> unactiveColor = [
    ColorConstants.backgrounColor,
    ColorConstants.backgrounColor
  ];
  List<Color> userActiveColor = [
    ColorConstants.goutSecondColor,
    ColorConstants.goutThirdColor
  ];
  List<Color> eventActiveColor = [
    ColorConstants.goutThirdColor,
    ColorConstants.goutSecondColor
  ];
  Rx<int> buttonId = 1.obs;
  var isLoading = false.obs;

  RxList<SearchUserModel> userList =
      List<SearchUserModel>.empty(growable: true).obs;
  RxList<SearchEventModel> eventList =
      List<SearchEventModel>.empty(growable: true).obs;

  Future<void> getUserSearch(String query) async {
    isLoading.value = true;
    try {
      userList.clear();
      await FirebaseCollectionsEnum.user.col
          .where("nickname", isGreaterThanOrEqualTo: query)
          .get()
          .then((value) {
        for (final val in value.docs) {
          if(val.id != box.read("userUID")) {
            userList.add(SearchUserModel(id: val.id,name: val["name"], nickname: val["nickname"], imageURL: val["photoURL"]));
          }
        }
      });
      update();
    } catch (e) {
      errorSnackbar("SearchViewController, getUserSearchERROR: ", "$e");
    }
    isLoading.value = false;
  }

  Future<void> getEventSearch(String query) async {
    isLoading.value = true;
    try {
      eventList.clear();
      await FirebaseCollectionsEnum.event.col
          .where("eventTitle", isGreaterThanOrEqualTo: query)
          .get()
          .then((value) {
        for (final val in value.docs) {
          eventList
              .add(SearchEventModel(id: val.id, eventTitle: val["eventTitle"]));
        }
      });
      update();
    } catch (e) {
      errorSnackbar("SearchViewController, getEventSearchERROR: ", "$e");
    }
    isLoading.value = false;
  }
}
