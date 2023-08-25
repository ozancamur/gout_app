// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gout_app/core/constant/color/color_constants.dart';
import 'package:gout_app/core/widgets/bottomNavigatorBar/gout_bottom.dart';
import 'package:gout_app/core/widgets/eventCard/event_card.dart';
import 'package:gout_app/view/friend/viewmodel/friend_profile_view_model.dart';

class FriendProfileView extends StatelessWidget {
  FriendProfileView({required this.id, super.key});

  String id;
  final controller = Get.put(FriendProfileViewModel());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FriendProfileViewModel>(
      init: FriendProfileViewModel(),
      builder: (controller) {
        controller.getFriendInfo(id);
        controller.getFriendsEvents(id);
        controller.isMyFriendCheck();
        return SafeArea(
          child: Scaffold(
            bottomNavigationBar: goutBottomAppBar(pageId: 1),
            resizeToAvoidBottomInset: false,
            backgroundColor: ColorConstants.black,
            body: _bodyField(),
          ),
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
      top: Get.height * .35,
      left: Get.width * .05,
      right: Get.width * .05,
      child: Container(
        height: Get.height * .55,
        width: Get.width,
        decoration: const BoxDecoration(color: ColorConstants.black),
        child: ListView.builder(
          itemCount: controller.userEvents.length,
          itemBuilder: (context, index) {
             DateTime date =
                      controller.userEvents[index].date.toDate();
                  String month = controller.monthMap[date.month]!;
                  String day;
                  date.day < 10
                      ? day = "0${date.day}"
                      : day = "${date.day}";
            return EventCard(
              month: month,
              day: day,
              eventTitle: controller.userEvents[index].eventTitle,
              nickname: controller.user.value.nickname,
              eventId: controller.userEvents[index].id,
              createrName: controller.user.value.name,
            );
          },
        ),
      ),
    );
  }

  Widget _userCard() {
    return Container(
      height: Get.height * .35,
      width: Get.width,
      decoration: const BoxDecoration(
        color: ColorConstants.backgrounColor,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(150)),
      ),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Stack(
              children: [
                Center(
                  child: Container(
                    height: Get.height * .2,
                    width: Get.width * .57,
                    decoration: const BoxDecoration(
                      color: ColorConstants.goutMainDarkColor,
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(100)),
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // ! USER IMAGE
                      Padding(
                        padding: EdgeInsets.only(top: Get.height*.015),
                        child: SizedBox(
                          height: Get.height * .1,
                          width: Get.width * .2,
                          child: const CircleAvatar(
                            foregroundImage: AssetImage(
                              "assets/images/me.png",
                            ),
                          ),
                        ),
                      ),
                      // ! USER NAME AND NICKNAME
                      Text(
                        controller.user.value.name,
                        style: const TextStyle(
                          color: ColorConstants.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "@${controller.user.value.nickname}".toLowerCase(),
                        style: const TextStyle(
                          color: ColorConstants.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: Get.height * .015),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // ! POST COUNT
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        controller.userEvents.length.toString(),
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
                    onTap: () {},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          controller.user.value.friends.length.toString(),
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
            ),
            //! FOLLOW BUTTON
            Padding(
              padding: EdgeInsets.only(top: Get.height*.015,bottom: Get.height * .015),
              child: controller.isMyFriend.value 
              ?  InkWell(
                onTap: () {},
                child: Container(
                  height: Get.height * .03,
                  width: Get.width * .25,
                  decoration: BoxDecoration(
                      color: ColorConstants.goutMainDarkColor,
                      borderRadius: BorderRadius.circular(30)),
                  child: const Center(
                    child: Text(
                      "unfollow",
                      style: TextStyle(
                        color: ColorConstants.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ), 
                ),
              )
              : InkWell(
                onTap: () {
                  controller.firestore.followTheUser(id);
                },
                child: Container(
                  height: Get.height * .03,
                  width: Get.width * .25,
                  decoration: BoxDecoration(
                      color: ColorConstants.goutMainDarkColor,
                      borderRadius: BorderRadius.circular(30)),
                  child: const Center(
                    child: Text(
                      "follow",
                      style: TextStyle(
                        color: ColorConstants.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ), 
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}
