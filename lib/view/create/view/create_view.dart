// ignore: unused_import
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gout_app/core/constant/color/color_constants.dart';
import 'package:gout_app/core/widgets/add_friend_card/add_friend_card.dart';
import 'package:gout_app/core/widgets/appBar/gout_appbar.dart';
import 'package:gout_app/core/widgets/bottomNavigatorBar/gout_bottom.dart';
import 'package:gout_app/core/widgets/button/gout_button.dart';
import 'package:gout_app/core/widgets/error/snackbar/error_snackbar.dart';
import 'package:gout_app/view/create/model/create_model.dart';
import 'package:gout_app/view/create/viewmodel/create_view_model.dart';
import 'package:gout_app/view/home/view/home_view.dart';

class CreateView extends StatelessWidget {
  CreateView({super.key});

  final controller = Get.put(CreateViewModel());
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    var choosedDate = Timestamp.fromDate(
      DateTime(
        controller.currentDate.value.year,
        controller.currentDate.value.month,
        controller.currentDate.value.day,
        controller.currentTime.value.hour,
        controller.currentTime.value.minute,
      ),
    );
    controller.getFriends();
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorConstants.black,
      appBar: goutAppBar("Create an Event"),
      bottomSheet: goutBottomAppBar(pageId: 2),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Get.width * .05, vertical: Get.height * .03),
        child: Column(
          children: [
            _titleField(),
            _descriptionField(),
            _dateTimeLocationAndInviteField(),
            goutButton(
              controller.colors,
              "Create an Event",
              () {
                if (controller.tecEventTitle.text != "" &&
                    controller.tecEventDescription.text != "" &&
                    controller.friendList.isNotEmpty) {
                  controller.createEvent(
                    CreateModel(
                      arrivals: [],
                      createdOnDate: Timestamp.fromDate(DateTime.now()),
                      createrId: box.read("userUID"),
                      date: choosedDate,
                      eventDescription: controller.tecEventDescription.text,
                      eventTitle: controller.tecEventTitle.text,
                      invited: controller.invitedList,
                      location: GeoPoint(
                        controller.lat.value,
                        controller.long.value,
                      ),
                    ),
                  );
                  Get.off(() => HomeView());
                } else {
                  errorSnackbar("ERROR", "You must fill in all fields");
                  
                }
              },
            ),
          ],
        ),
      ),
    ));
  }

  Widget _titleField() {
    return Padding(
      padding: EdgeInsets.only(top: Get.height * .05),
      child: TextField(
        maxLength: 20,
        controller: controller.tecEventTitle,
        cursorColor: ColorConstants.white,
        keyboardType: TextInputType.emailAddress,
        strutStyle: const StrutStyle(fontSize: 15),
        style: const TextStyle(color: ColorConstants.white),
        decoration: InputDecoration(
          hintText: "Enter event's title ",
          hintStyle: const TextStyle(color: ColorConstants.grey),
          filled: true,
          fillColor: ColorConstants.backgrounColor,
          labelText: "Event Title*",
          labelStyle: const TextStyle(color: ColorConstants.white),
          border: OutlineInputBorder(
              borderSide:
                  const BorderSide(width: 1.5, color: ColorConstants.grey),
              borderRadius: BorderRadius.circular(30)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 1.5,
                color: ColorConstants.goutMainColor,
              ),
              borderRadius: BorderRadius.circular(30)),
        ),
      ),
    );
  }

  Widget _descriptionField() {
    return Padding(
      padding: EdgeInsets.only(top: Get.height * .03),
      child: TextField(
        maxLength: 99,
        controller: controller.tecEventDescription,
        cursorColor: ColorConstants.white,
        keyboardType: TextInputType.emailAddress,
        strutStyle: const StrutStyle(fontSize: 15),
        style: const TextStyle(color: ColorConstants.white),
        decoration: InputDecoration(
          hintText: "Enter event's description ",
          hintStyle: const TextStyle(color: ColorConstants.grey),
          filled: true,
          fillColor: ColorConstants.backgrounColor,
          labelText: "Event Description*",
          labelStyle: const TextStyle(color: ColorConstants.white),
          border: OutlineInputBorder(
              borderSide:
                  const BorderSide(width: 1.5, color: ColorConstants.grey),
              borderRadius: BorderRadius.circular(30)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 1.5,
                color: ColorConstants.goutMainColor,
              ),
              borderRadius: BorderRadius.circular(30)),
        ),
      ),
    );
  }

  Widget _dateTimeLocationAndInviteField() {
    return Padding(
        padding: EdgeInsets.only(top: Get.height * .03),
        child: SizedBox(
          height: Get.height * .15,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //! DATE AND TIME
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //! DATE
                  SizedBox(
                    height: Get.height * .045,
                    width: Get.width * .4,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        controller.pickDate();
                      },
                      icon: const Icon(
                        Icons.date_range,
                        color: ColorConstants.black,
                      ),
                      label: Obx(() => Text(
                            "${controller.currentDate.value.day}/${controller.currentDate.value.month}/${controller.currentDate.value.year}",
                            style: const TextStyle(
                                color: ColorConstants.black,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                  ),
                  //! TIME
                  SizedBox(
                    height: Get.height * .045,
                    width: Get.width * .4,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        controller.pickTime();
                      },
                      icon: const Icon(
                        Icons.access_time_filled_outlined,
                        color: ColorConstants.black,
                      ),
                      label: Obx(() => Text(
                            "${controller.currentTime.value.hour} : ${controller.currentTime.value.minute}",
                            style: const TextStyle(
                                color: ColorConstants.black,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                  ),
                ],
              ),
              //! LOCAITON AND INVITE
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //! LOCAITON
                  SizedBox(
                    height: Get.height * .045,
                    width: Get.width * .4,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        controller.pickLocation();
                      },
                      icon: const Icon(
                        Icons.location_on,
                        color: ColorConstants.black,
                      ),
                      label: const Text(
                        "Location",
                        style: TextStyle(
                          color: ColorConstants.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  //! INVITE
                  SizedBox(
                    height: Get.height * .045,
                    width: Get.width * .4,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        controller.chooseFriends(controller.friendList);
                      },
                      icon: const Icon(
                        Icons.person_add_alt_rounded,
                        color: ColorConstants.black,
                      ),
                      label: const Text(
                        "Add",
                        style: TextStyle(
                          color: ColorConstants.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
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
                            if (controller.invitedList.contains(friends[index].id)) {
                              Get.showSnackbar(const GetSnackBar(
                                message: "you invited this friend",
                              ));
                            } else {
                              controller.invitedList.add(friends[index].id);
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
}
