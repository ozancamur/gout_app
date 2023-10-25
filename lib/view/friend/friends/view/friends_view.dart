// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gout_app/core/constant/color/color_constants.dart';
import 'package:gout_app/core/widgets/appBar/gout_appbar.dart';
import 'package:gout_app/view/friend/friends/viewmodel/friends_view_model.dart';
import 'package:gout_app/view/friend/profile/view/friend_profile_view.dart';

class FriendsView extends StatelessWidget {
  FriendsView({super.key, required this.list});
  List list;
  
  final controller = Get.put(FriendsViewModel());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FriendsViewModel>(
      init: FriendsViewModel(),
      builder: (controller) {
        controller.getFriends(list);
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
          itemCount: controller.friendsList.length,
          itemBuilder: (context, index) {
            return _friendsCard(
                controller.friendsList[index].name,
                controller.friendsList[index].nickname,
                controller.friendsList[index].id,
                controller.friendsList[index].photoURL,
                index);
          },
        ),
      ),
    );
  }

  Widget _friendsCard(String name, String nickname, String id, String photoURL, int index) {
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
              Get.off(() => FriendProfileView(id: id,));
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
                      child: CircleAvatar(
                            backgroundImage: const AssetImage(
                              "assets/images/no_profile_photo.png",
                            ),
                            foregroundImage: NetworkImage(photoURL),
                          ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: Get.height * .005),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              width: Get.width * .3,
                              height: Get.height * .025,
                              child: Text(
                                name,
                                style: const TextStyle(
                                  color: ColorConstants.goutWhite,
                                ),
                              )),
                          SizedBox(
                              width: Get.width * .3,
                              height: Get.height * .025,
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
            onTap: () {
              Get.defaultDialog(
                title: name,
                  backgroundColor: ColorConstants.white,
                  middleText: "are you sure to unfollow?",
                  titleStyle: const TextStyle(
                    fontSize: 17.5,
                    color: ColorConstants.backgrounColor,
                  ),
                  onConfirm: () {
                    controller.unfollowFriend(id, index);
                    Get.back();
                  },
                  onCancel: () {},
                  );
            },
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
