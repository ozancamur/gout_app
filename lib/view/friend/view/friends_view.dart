import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gout_app/core/constant/color/color_constants.dart';
import 'package:gout_app/core/widgets/appBar/gout_appbar.dart';
import 'package:gout_app/view/friend/viewmodel/friend_view_model.dart';
import 'package:gout_app/view/proile/viewmodel/profile_view_model.dart';

class FriendsView extends StatelessWidget {
  FriendsView({super.key});
  final profileController = Get.put(ProfileViewModel());
  final controller = Get.put(FriendViewModel());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FriendViewModel>(
      init: FriendViewModel(),
      builder: (controller) {
        controller.getFriends();
        return SafeArea(
          child: Scaffold(
            backgroundColor: ColorConstants.black,
            appBar: goutAppBar("Friends"),
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
      child: Obx(
        () => ListView.builder(
          itemCount: controller.friends.length,
          itemBuilder: (context, index) {
            return _friendsCard(controller.friends[index].name,
                controller.friends[index].nickname);
          },
        ),
      ),
    );
  }

  Widget _friendsCard(String name, String nickname) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // ! USER INFO
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Get.width * .03, vertical: Get.height * .01),
          child: InkWell(
            onTap: () {
              // ? go to user profile
            },
            child: Container(
                height: Get.height * .08,
                width: Get.width * .5,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: ColorConstants.backgrounColor),
                child: Row(
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: Get.width * .03),
                      child: const CircleAvatar(
                        foregroundImage:
                            AssetImage("assets/images/profile_photo.png"),
                        backgroundColor: ColorConstants.goutWhite,
                        maxRadius: 20,
                        minRadius: 20,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: Get.height * .0075),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              width: Get.width * .3,
                              height: Get.height * .02,
                              child: Text(
                                name,
                                style: const TextStyle(
                                  color: ColorConstants.goutWhite,
                                ),
                              )),
                          SizedBox(
                              width: Get.width * .3,
                              height: Get.height * .02,
                              child: Text(
                                "@$nickname",
                                style: const TextStyle(
                                  color: ColorConstants.goutWhite,
                                ),
                              )),
                        ],
                      ),
                    ),
                  ],
                )),
          ),
        ),
        // ! UNFOLLOW
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * .02),
          child: InkWell(
            onTap: () {},
            child: Container(
              height: Get.height * .035,
              width: Get.width * .3,
              decoration: BoxDecoration(
                  color: ColorConstants.goutMainColor,
                  borderRadius: BorderRadius.circular(50)),
              child: const Center(
                child: Text(
                  "unfollow",
                  style: TextStyle(
                    color: ColorConstants.white,
                    fontSize: 17,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
