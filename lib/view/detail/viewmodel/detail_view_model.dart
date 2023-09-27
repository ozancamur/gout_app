// ignore_for_file: avoid_function_literals_in_foreach_calls
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gout_app/core/enum/firebase_enum.dart';
import 'package:gout_app/core/services/firebase/firebase_firestore.dart';
import 'package:gout_app/core/services/firebase/firebase_storage_controller.dart';
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
  TextEditingController tecEventTitle = TextEditingController();
  TextEditingController tecEventDescription = TextEditingController();


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
          location: const GeoPoint(0.0, 0.0))
      .obs;
  List<MomentModel> momentsList = <MomentModel>[].obs;
  var comingQuestion = false.obs;
  var isComing = false.obs;
  var isFavorite = false.obs;
  var momentTime = false.obs;

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

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

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
          val.eventTitle = eventDoc["eventTitle"];
          val.invited = eventDoc["invited"];
          val.location = eventDoc["location"];
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
              owner: moment["owner"]),
        );
      }
    } catch (e) {
      errorSnackbar("getEventMoments, ERROR", "$e");
    }
  }

  void checkDateTime(Timestamp eventDate) async {
    DateTime event = eventDate.toDate();
    DateTime now = DateTime.now();
    Duration difference = now.difference(event);
    if(difference.isNegative == true) {
      debugPrint("duration ${difference.isNegative}");
    }
    // neg ise bitmedi
    // poz ise bitti
  }
  
  void checkUserForEvent(List arrivals, List invited, String creater, Timestamp eventDate) {
    DateTime event = eventDate.toDate();
    DateTime now = DateTime.now();
    Duration difference = now.difference(event);
    if(difference.isNegative == false) {
      if(arrivals.contains(box.read("userUID")) || creater == box.read("userUID")){
        momentTime.value = true;
        update();
      }
    } else {
      momentTime.value = false;
    }

    if (arrivals.contains(box.read("userUID"))) {
      isComing.value = true;
      update();
    } else {
      if (creater == box.read("userUID")) {
        isComing.value = true;
      } else {
        isComing.value = false;
      }
    }

    if (invited.contains(box.read("userUID"))) {
      comingQuestion.value = true;
    } else {
      comingQuestion.value = false;
    }
  }

  void acceptRequest(String id) {
    isLoading.value = true;
    firestore.acceptEventRequest(id);
    isLoading.value = false;
  }

  void cancelRequest(String id) {
    firestore.cancelEventRequest(id);
  }

  void cantCome(String id) {
    firestore.cantComeEvent(id);
  }

  void eventIsFavorite(String id) {
    firestore.eventIsFavorite(id);
    isFavorite.value = true;
    update();
  }

  void eventIsNotFavorite(String id) {
    firestore.eventIsNotFavorite(id);
    isFavorite.value = false;
    update();
  }

  void pickImageFromGalleryForMoment() {
    storage.imageFromGallery();
  }

  void pickImageFromCameraForMoment() {
    storage.imageFromCamera();
  }

  void createAMoment(String eventId, String comment) {
    storage.uploadFile(eventId, comment);
  }

  void displayLocation(double lat, double long) {
    Get.dialog(GoogleMap(
      mapType: MapType.hybrid,
      initialCameraPosition:
          CameraPosition(target: LatLng(lat, long), zoom: 16.0),
      markers: {
        Marker(
            markerId: const MarkerId("Event Location"),
            position: LatLng(lat, long)),
      },
      onMapCreated: (
        GoogleMapController controller,
      ) {
        if (!_controller.isCompleted) {
          _controller.complete(controller);
        } else {}
      },
    ));
  }

  void changeEventTitle(String id, String newTitle) {
    firestore.changeEventTitle(id, newTitle);
  }
  
  void changeEventDescription(String id, String newDescription) {
    firestore.changeEventDescription(id, newDescription);
  }
  
}
