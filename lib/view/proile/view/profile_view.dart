// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gout_app/core/constant/color/color_constants.dart';
import 'package:gout_app/core/widgets/bottomNavigatorBar/gout_bottom.dart';
import 'package:gout_app/core/widgets/eventCard/event_card.dart';
import 'package:gout_app/view/friend/view/request_view.dart';
import 'package:gout_app/view/friend/view/friends_view.dart';
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
          _eventField(),
          _userCard(),
        ],
      ),
    );
  }

  Widget _eventField() {
    return Positioned(
      top: Get.height * .32,
      left: Get.width * .05,
      right: Get.width * .05,
      child: Container(
        height: Get.height * .55,
        width: Get.width,
        decoration: const BoxDecoration(color: ColorConstants.black),
        child: ListView.builder(
          itemCount: controller.userEventList.length,
          itemBuilder: (context, index) {
            DateTime date = controller.userEventList[index].date.toDate();
            String month = controller.monthMap[date.month]!;
            String day;
            date.day < 10 ? day = "0${date.day}" : day = "${date.day}";
            return EventCard(
              month: month,
              day: day,
              eventTitle: controller.userEventList[index].eventTitle,
              nickname: controller.profileUserModel.value.nickname,
              eventId: controller.userEventList[index].id,
              createrName: controller.profileUserModel.value.name,
            );
          },
        ),
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
              padding: EdgeInsets.only(top: Get.width * .05),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ! USER IMAGE
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Get.width * .05),
                    child: Container(
                      height: Get.height * .15,
                      width: Get.width * .3,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: ColorConstants.backgrounColor),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          "assets/images/me.png",
                          fit: BoxFit.cover,
                        ),
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
                      left: Get.width * .075,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => RequestView());
                      },
                      child: SizedBox(
                        height: Get.height * .2,
                        width: Get.width * .1,
                        child: Stack(
                          children: [
                            // ! ICON OF FRIENDS REQUEST
                            Padding(
                              padding: EdgeInsets.only(top: Get.height * .0075),
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
                                .profileUserModel.value.friendRequest.isEmpty)
                              const SizedBox()
                            else
                              Positioned(
                                left: Get.width * .05,
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
                                                  .friendRequest.length
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
            Padding(
              padding: EdgeInsets.symmetric(vertical: Get.height * .01),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // ! POST COUNT
                  Column(
                    children: [
                      Text(
                        controller.userEventList.length.toString(),
                        style: const TextStyle(color: ColorConstants.white),
                      ),
                      const Text(
                        "Posts",
                        style: TextStyle(color: ColorConstants.white),
                      ),
                    ],
                  ),
                  // ! FRIENDS COUNT
                  InkWell(
                    onTap: () {
                      Get.to(() => FriendsView());
                    },
                    child: Column(
                      children: [
                        Text(
                          controller.profileUserModel.value.friends.length
                              .toString(),
                          style: const TextStyle(color: ColorConstants.white),
                        ),
                        const Text(
                          "Friends",
                          style: TextStyle(color: ColorConstants.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
