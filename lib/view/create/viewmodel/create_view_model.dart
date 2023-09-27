// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gout_app/core/enum/firebase_enum.dart';
import 'package:gout_app/core/services/constant/color/color_constants.dart';
import 'package:gout_app/core/services/firebase/firebase_firestore.dart';
import 'package:gout_app/core/widgets/add_friend_card/add_friend_card.dart';
import 'package:gout_app/core/widgets/error/snackbar/error_snackbar.dart';
import 'package:gout_app/view/create/model/create_model.dart';
import 'package:gout_app/view/create/model/friend_model.dart';

class CreateViewModel extends GetxController {
  final firebaseFirestore = Get.put(FirebaseFirestoreController());

  TextEditingController tecEventTitle = TextEditingController();
  TextEditingController tecEventDescription = TextEditingController();

  List<Color> colors = [
    ColorConstants.goutSecondColor,
    ColorConstants.goutThirdColor
  ];

  final box = GetStorage();

  var currentDate = DateTime.now().obs;
  var currentTime = TimeOfDay.now().obs;

  

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  var markers = <Marker>{}.obs;
  MarkerId markerId = const MarkerId("event_location");
  var lat = 39.925018.obs;
  var long = 32.836956.obs;
  List<FriendModel> friendList = <FriendModel>[].obs;
  List<String> invitedList = <String>[].obs;

  pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: currentDate.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != currentDate.value) {
      currentDate.value = pickedDate;
      update();
    }
  }

  pickTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: Get.context!,
      initialTime: currentTime.value,
    );
    if (pickedTime != null && pickedTime != currentTime.value) {
      currentTime.value = pickedTime;
    }
  }

  pickLocation() async {
    Get.dialog(
      Obx(
        () => GoogleMap(
          mapType: MapType.hybrid,
          initialCameraPosition:
              CameraPosition(target: LatLng(lat.value, long.value), zoom: 16.0),
          markers: markers,
          onMapCreated: (
            GoogleMapController controller,
          ) {
            if (!_controller.isCompleted) {
              _controller.complete(controller);
            } else {}
          },
          onTap: (argument) {
            lat.value = argument.latitude;
            long.value = argument.longitude;
            markers.add(
              Marker(
                markerId: markerId,
                position: LatLng(lat.value, long.value),
              ),
            );
            Future.delayed(const Duration(seconds: 1), () {
              Get.back();
            });
          },
        ),
      ),
    );
  }

  chooseFriends(List friends) async {
    Get.dialog(
      Center(
        child: Container(
          width: Get.width * .6,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: ColorConstants.goutMainDarkColor,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: ListView.builder(
                  itemCount: friends.length,
                  shrinkWrap: true,
                  itemBuilder: (ctx, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        FriendCard(
                          nickname: friends[index].nickname!,
                          name: friends[index].name!,
                          id: friends[index].id!,
                          photoURL: friends[index].photoURL,
                        ),
                        IconButton(
                          onPressed: () {
                            if (invitedList.contains(friends[index].id)) {
                              Get.showSnackbar(const GetSnackBar(
                                message: "you invited this friend",
                              ));
                            } else {
                              invitedList.add(friends[index].id);
                            }
                          },
                          icon: const Icon(
                            Icons.add,
                            size: 20,
                            color: ColorConstants.goutWhite,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getFriends() async {
    try {
      friendList.clear();
      List list;
      DocumentSnapshot me =
          await FirebaseCollectionsEnum.user.col.doc(box.read("userUID")).get();
      list = me["followers"];
      list.forEach((user) async {
        DocumentSnapshot friend =
            await FirebaseCollectionsEnum.user.col.doc(user).get();
        friendList.add(
          FriendModel(
            nickname: friend["nickname"],
            name: friend["name"],
            id: friend.id,
            photoURL: friend["photoURL"],
          ),
        );
      });
    } catch (e) {
      errorSnackbar("getFriends, ERROR => ", "$e");
      debugPrint("$e");
    }
  }

  Future<void> createEvent(CreateModel model) async {
    try {
      firebaseFirestore.createAnEvent(model);
    } catch (e) {
      errorSnackbar("CreateViewModel, createEventERROR: ", "$e");
    }
  }
}
