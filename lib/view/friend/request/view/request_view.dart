// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gout_app/core/services/constant/color/color_constants.dart';
import 'package:gout_app/core/widgets/appBar/gout_appbar.dart';
import 'package:gout_app/view/friend/profile/view/friend_profile_view.dart';
import 'package:gout_app/view/friend/request/viewmodel/request_view_model.dart';

class RequestView extends StatelessWidget {
  RequestView({super.key, required this.list});
  List list;
  final controller = Get.put(RequestViewModel());  

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RequestViewModel>(
      init: RequestViewModel(),
      builder: (controller) {
        controller.getFriendRequest(list);
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
          itemCount: controller.friendRequestList.length,
          itemBuilder: (context, index) {
            return _friendRequestCard(
              id: controller.friendRequestList[index].id,
              name: controller.friendRequestList[index].name,
              nickname: controller.friendRequestList[index].nickname,
              index: index
            );
          },
        ),
      ),
    );
  }

  Widget _friendRequestCard(
      {required String id, required String name, required String nickname, required int index}) {
    return Row(
      children: [
        // ! USER INFO
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Get.width * .03, vertical: Get.height * .01),
          child: InkWell(
            onTap: () {
              Get.to(()=>FriendProfileView(id: id,));
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
        // ! ACCEPT
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * .02),
          child: InkWell(
            onTap: () {
              controller.acceptRequest(id, index);
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
              controller.cancelRequest(id, index);
              
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
