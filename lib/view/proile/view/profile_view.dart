// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gout_app/core/constant/color/color_constants.dart';
import 'package:gout_app/core/widgets/bottomNavigatorBar/gout_bottom.dart';
import 'package:gout_app/core/widgets/eventCard/event_card.dart';
import 'package:gout_app/view/friend/request/view/request_view.dart';
import 'package:gout_app/view/friend/friends/view/friends_view.dart';
import 'package:gout_app/view/proile/viewmodel/profile_view_model.dart';

class ProfileView extends StatelessWidget {
  ProfileView({super.key});
  final controller = Get.put(ProfileViewModel());
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileViewModel>(
      init: ProfileViewModel(),
      builder: (controller) {
        controller.getUserEvents(box.read("userUID"));
        controller.getUserInfo();
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: ColorConstants.black,
          bottomSheet: goutBottomAppBar(
            pageId: 3,
          ),
          body: _bodyField(),
        );
      },
    );
  }

  Widget _bodyField() {
    return SizedBox(
      height: Get.height,
      width: Get.width,
      child: Stack(
        children: [
          _userEventsField(),
          _userCard(),
        ],
      ),
    );
  }

  Widget _userCard() {
    return Container(
      height: Get.height * .37,
      width: Get.width,
      decoration: const BoxDecoration(
        color: ColorConstants.backgrounColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: Get.height * .07),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: Get.width * .04),
              child: SizedBox(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ! USER IMAGE
                    GestureDetector(
                      onTap: () {
                        userPhotoPicker();
                      },
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: Get.width * .04),
                        child: Container(
                          height: Get.height * .15,
                          width: Get.width * .3,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: ColorConstants.backgrounColor),
                          child: Obx(() => ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: controller
                                        .profileUserModel.value.photoURL.isEmpty
                                    ? Image.asset(
                                        "assets/images/no_profile_photo.png",
                                        fit: BoxFit.cover,
                                      )
                                    : Image.network(
                                        controller
                                            .profileUserModel.value.photoURL,
                                        fit: BoxFit.cover,
                                      ),
                              )),
                        ),
                      ),
                    ),
                    // ! USER NAME AND NICKNAME
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: Get.height * .06),
                      child: Obx(() => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller.profileUserModel.value.name,
                                style: const TextStyle(
                                  color: ColorConstants.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "@${controller.profileUserModel.value.nickname}"
                                    .toLowerCase(),
                                style: const TextStyle(
                                  color: ColorConstants.grey,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          )),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: Get.width * .01,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Get.to(() => RequestView(
                                list: controller.profileUserModel.value.requests,
                              ));
                        },
                        child: SizedBox(
                          height: Get.height * .2,
                          width: Get.width * .2,
                          child: Stack(
                            children: [
                              // ! ICON OF FRIENDS REQUEST
                              Padding(
                                padding: EdgeInsets.only(
                                    top: Get.height * .0075,
                                    left: Get.width * .05),
                                child: Container(
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          width: 1.5,
                                          color: ColorConstants.goutWhite)),
                                  child: Padding(
                                    padding: EdgeInsets.all(Get.width * .015),
                                    child: const Icon(
                                      Icons.group,
                                      color: ColorConstants.goutWhite,
                                      size: 22,
                                    ),
                                  ),
                                ),
                              ),
                              // ! COUNT OF FRIENDS REQUEST
                              if (controller
                                  .profileUserModel.value.requests.isEmpty)
                                const SizedBox()
                              else
                                Positioned(
                                  left: Get.width * .1,
                                  child: SizedBox(
                                    width: Get.width * .05,
                                    child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: Get.height * 0.005),
                                        child: Container(
                                            decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.red),
                                            child: Center(
                                              child: Text(
                                                controller.profileUserModel.value
                                                    .requests.length
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                            ))),
                                  ),
                                )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //* POST COUNT
                userTab(controller.userEventList.length, "Posts"),
                //* FRIENDS COUNT
                InkWell(
                    onTap: () {
                      Get.to(() => FriendsView(
                          list: controller.profileUserModel.value.followers));
                    },
                    child: userTab(
                        controller.profileUserModel.value.followers.length,
                        "Friends")),
              ],
            )
          ],
        ),
      ),
    );
  }

  userTab(int length, String tabText) {
    return Column(
      children: [
        Text(
          "$length",
          style: const TextStyle(color: ColorConstants.white),
        ),
        Text(
          tabText,
          style: const TextStyle(color: ColorConstants.white),
        ),
      ],
    );
  }

  userPhotoPicker() {
    return Get.dialog(
      Center(
        child: SizedBox(
            height: Get.height * .22,
            width: Get.width * .4,
            child: Material(
              borderRadius: BorderRadius.circular(30),
              color: ColorConstants.goutWhite,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: Get.height * .02),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: Get.width * .3,
                        height: Get.height * .1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              onPressed: () {
                                controller.pickImageFromGallery();
                              },
                              icon: const Icon(
                                Icons.photo_library,
                                color: ColorConstants.black,
                                size: 30,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                controller.pickImageFromCamera();
                              },
                              icon: const Icon(
                                Icons.photo_camera,
                                color: ColorConstants.black,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorConstants.black,
                          ),
                          onPressed: () {
                            controller.changeProfileImage();
                          },
                          child: const Text(
                            "upload",
                            style: TextStyle(
                                color: ColorConstants.goutWhite,
                                fontWeight: FontWeight.bold,
                                fontSize: 17),
                          ))
                    ],
                  ),
                ),
              ),
            )),
      ),
    );
  }
  
  Widget _userEventsField() {
    return Positioned(
      top: Get.height * .32,
      left: Get.width * .05,
      right: Get.width * .05,
      child: SizedBox(
          height: Get.height * .6,
          width: Get.width,
          child: Obx(
            () => controller.userEventList.isEmpty
                ? const Text(
                    "not found event",
                    style: TextStyle(color: ColorConstants.goutWhite),
                  )
                : ListView.builder(
                    itemCount: controller.userEventList.length,
                    prototypeItem: const EventCard(
                        month: "June",
                        day: "10",
                        eventTitle: "Birthday",
                        nickname: "ozancamur",
                        eventId: "ozancamur10062000",
                        createrName: "Ozan Camur",
                        createrId: "createrId",
                        arrivals: [],
                        friends: [],),
                    itemBuilder: (context, index) {
                      DateTime date =
                          controller.userEventList[index].date.toDate();
                      String month = controller.monthMap[date.month]!;
                      String day;
                      date.day < 10
                          ? day = "0${date.day}"
                          : day = "${date.day}";
                      return EventCard(
                        month: month,
                        day: day,
                        eventTitle: controller.userEventList[index].eventTitle,
                        nickname: controller.profileUserModel.value.nickname,
                        eventId: controller.userEventList[index].id,
                        createrName: controller.profileUserModel.value.name,
                        createrId: controller.userEventList[index].createrId,
                        arrivals: controller.userEventList[index].arrivals,
                        friends: controller.profileUserModel.value.followers,
                      );
                    },
                  ),
          )),
    );
  }
}
