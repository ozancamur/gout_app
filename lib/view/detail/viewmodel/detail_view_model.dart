// ignore_for_file: avoid_function_literals_in_foreach_calls
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gout_app/core/enum/firebase_enum.dart';
import 'package:gout_app/core/firebase/firebase_firestore.dart';
import 'package:gout_app/core/firebase/firebase_storage_controller.dart';
import 'package:gout_app/core/widgets/error/snackbar/error_snackbar.dart';
import 'package:gout_app/view/detail/model/arrivals_model.dart';
import 'package:gout_app/view/detail/model/detail_model.dart';
import 'package:gout_app/view/detail/model/moment_model.dart';

class DetailViewModel extends GetxController {
  final firestore = Get.put(FirebaseFirestoreController());
  final storage = Get.put(FirebaseStorageController());
  final box = GetStorage();
  var down = false.obs;

  TextEditingController tecComment = TextEditingController();
  CollectionReference user = FirebaseCollectionsEnum.user.col;
  CollectionReference event = FirebaseCollectionsEnum.event.col;

  List<UserModelForEvent> arrivalsList = <UserModelForEvent>[].obs;
  Rx<DetailModel> detailModel = DetailModel(
    createdOnDate: Timestamp(0, 0),
    createrId: "",
    date: Timestamp(0, 0),
    eventDescription: "",
    eventTitle: "",
    arrivals: [],
    invited: [], 
    eventID: '',
  ).obs;
  List<MomentModel> momentsList = <MomentModel>[].obs;
  var comingQuestion = false.obs;
  var isComing = false.obs;
  var isFavorite = false.obs;

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

  var isLoading = false.obs;

  Future<void> getEventsDetail(String eventId) async {
    try {
      DocumentSnapshot eventDoc = await event.doc(eventId).get();

      detailModel.update(
        (val) {
          val!.arrivals = eventDoc["arrivals"];
          val.createdOnDate = eventDoc["createdOnDate"];
          val.createrId = eventDoc["createrId"];
          val.date = eventDoc["date"];
          val.eventDescription = eventDoc["eventDescription"];
          val.eventID = eventDoc.id;
          val.eventTitle = eventDoc["eventTitle"];
          val.invited = eventDoc["invited"];
        },
      );
      update();
    } catch (e) {
      errorSnackbar("DetailController, getEventsDetail ERROR: ", "$e");
    }
  }

  Future<void> getEventArrivals(String id, List list) async {
    isLoading.value = true;
    try {
      list.forEach(
        (element) {
          user
              .where("uuid", isGreaterThanOrEqualTo: element)
              .get()
              .then((value) {
            for (final val in value.docs) {
              arrivalsList.add(
                UserModelForEvent(
                    id: val.id,
                    name: val["name"],
                    nickname: val["nickname"],
                    favorites: val["favorites"],
                    photoURL: val["photoURL"]),
              );
            }
          });
        },
      );
    } catch (e) {
      errorSnackbar("DetailControllerERROR,getEventArrivals ERROR: ", "$e");
    }
  }

  Future<void> getEventMoments(String id) async {
    try {
      QuerySnapshot moments = await FirebaseCollectionsEnum.event.col
          .doc(id)
          .collection("moment")
          .get();
      momentsList.clear();
      for (final moment in moments.docs) {
        momentsList.add(
          MomentModel(
            comment: moment["comment"],
            createdOnDate: moment["createdOnDate"],
            createrId: moment["createrId"],
            momentImageUrl: moment["momentImageUrl"],
            owner: moment["owner"]
          ),
        );
      }
    } catch (e) {
      errorSnackbar("ERROR", "$e");
    }
  }

  void checkUserForEvent(List arrivals, List invited, String creater) {
    if (creater == box.read("userUID")) {
      isComing.value = true;
      update();
    } else {
      if (invited.contains(box.read("userUID"))) {
        comingQuestion.value = true;
        update();
      } else {
        comingQuestion.value = false;
        update();
        if (arrivals.contains(box.read("userUID"))) {
          isComing.value = true;
          update();
        } else {
          isComing.value = false;
          update();
        }
      }
    }
  }

  void acceptRequest(String id) {
    firestore.acceptEventRequest(id);
  }

  void cancelRequest(String id) {
    firestore.cancelEventRequest(id);
  }

  void cantCome(String id) {
    firestore.cantComeEvent(id);
  }

  void eventIsFavorite(String id) {
    firestore.eventIsFavorite(id);
  }

  void eventIsNotFavorite(String id) {
    firestore.eventIsNotFavorite(id);
  }

  void isEventFavorite(String eventId) async {
    DocumentSnapshot userInfo = await user.doc(box.read("userUID")).get();
    List<dynamic> list = userInfo["favorites"];
    list.forEach((element) {
      if (element == eventId) {
        isFavorite.value = true;
        update();
      }
    });
  }

  void pickImageFromGallery() {
    storage.imageFromGallery();
  }

  void pickImageFromCamera() {
    storage.imageFromCamera();
  }

  void createAMoment(String eventId, String comment) {
    storage.uploadFile(eventId, comment);
  }
}
