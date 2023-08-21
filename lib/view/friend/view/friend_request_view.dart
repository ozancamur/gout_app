import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gout_app/core/constant/color/color_constants.dart';
import 'package:gout_app/core/firebase/firebase_firestore.dart';
import 'package:gout_app/core/widgets/appBar/gout_appbar.dart';
import 'package:gout_app/view/friend/viewmodel/friend_view_model.dart';
import 'package:gout_app/view/proile/viewmodel/profile_view_model.dart';

class FriendRequestView extends StatelessWidget {
  FriendRequestView({super.key});
  final profileController = Get.put(ProfileViewModel());
  final controller = Get.put(FriendViewModel());
  final firestore = Get.put(FirebaseFirestoreController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FriendViewModel>(
      init: FriendViewModel(),
      builder: (controller) {
        controller.getFriendRequest();
        return SafeArea(
          child: Scaffold(
            backgroundColor: ColorConstants.black,
            appBar: goutAppBar("Friend Requests"),
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
          itemCount: controller.friendRequest.length,
          itemBuilder: (context, index) {
            return _friendRequestCard(
              id: controller.friendRequest[index].id,
              name: controller.friendRequest[index].name,
              nickname: controller.friendRequest[index].nickname,
            );
          },
        ),
      ),
    );
  }

  Widget _friendRequestCard(
      {required String id, required String name, required String nickname}) {
    return Row(
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
        // ! ACCEPT
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * .02),
          child: InkWell(
            onTap: () {
              firestore.acceptFriendRequest(id);
            },
            child: Container(
              height: Get.height * .05,
              width: Get.width * .175,
              decoration: BoxDecoration(
                  color: ColorConstants.goutGreen,
                  borderRadius: BorderRadius.circular(50)),
              child: const Icon(
                Icons.check_circle_outline,
                size: 30,
                color: ColorConstants.goutWhite,
              ),
            ),
          ),
        ),
        // ! CANCEL
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * .02),
          child: InkWell(
            onTap: () {
              firestore.cancelFriendRequest(id);
              print("view cancel");
            },
            child: Container(
              height: Get.height * .051,
              width: Get.width * .175,
              decoration: BoxDecoration(
                  color: ColorConstants.goutRed,
                  borderRadius: BorderRadius.circular(50)),
              child: const Icon(
                Icons.cancel_outlined,
                size: 30,
                color: ColorConstants.goutWhite,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
