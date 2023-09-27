import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gout_app/core/services/constant/color/color_constants.dart';
import 'package:gout_app/core/enum/firebase_enum.dart';
import 'package:gout_app/core/widgets/error/snackbar/error_snackbar.dart';
import 'package:gout_app/view/search/model/search_event_model.dart';
import 'package:gout_app/view/search/model/search_user_model.dart';
import 'package:gout_app/view/search/model/serch_event_creater_model.dart';

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

  RxList<SearchUserModel> userList =
      List<SearchUserModel>.empty(growable: true).obs;

  List<SearchEventCreaterModel> createrList = <SearchEventCreaterModel>[].obs;

  RxList<SearchEventModel> eventList =
      List<SearchEventModel>.empty(growable: true).obs;

  Future<void> getEventSearch(String query) async {
    userList.clear();
    isLoading.value = true;
    try {
      eventList.clear();
      await FirebaseCollectionsEnum.event.col
          .where("eventTitle", isGreaterThanOrEqualTo: query)
          .get()
          .then(
        (query) {
          for (final doc in query.docs) {
            eventList.add(
              SearchEventModel(
                id: doc.id,
                createdOnDate: doc["createdOnDate"],
                createrId: doc["createrId"],
                date: doc["date"],
                eventDescription: doc["eventDescription"],
                eventTitle: doc["eventTitle"],
              ),
            );
          }
        },
      );
      update();
    } catch (e) {
      errorSnackbar("SearchViewController, getEventSearchERROR: ", "$e");
    }
    isLoading.value = false;
  }

  Future<void> getUserSearch(String query) async {
    eventList.clear();
    isLoading.value = true;
    try {
      userList.clear();
      await FirebaseCollectionsEnum.user.col
          .where("nickname", isGreaterThanOrEqualTo: query)
          .get()
          .then(
        (value) {
          for (final val in value.docs) {
            if (val.id != box.read("userUID")) {
              userList.add(
                SearchUserModel(
                    id: val.id,
                    name: val["name"],
                    nickname: val["nickname"],
                    imageURL: val["photoURL"]),
              );
            }
          }
        },
      );
      update();
    } catch (e) {
      errorSnackbar("SearchViewController, getUserSearchERROR: ", "$e");
    }
    isLoading.value = false;
  }

  void getCreaterNickname(String id) async {
    isLoading.value = true;
    try {
      DocumentSnapshot creater =
          await FirebaseCollectionsEnum.user.col.doc(id).get();
      createrList.add(
        SearchEventCreaterModel(
          nickname: creater["nickname"],
          name: creater["name"],
        ),
      );
      update();
    } catch (e) {
      errorSnackbar("HomeViewModel_getEvents_ERROR: ", "$e");
    }
    isLoading.value = false;
  }
}
