import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gout_app/core/constant/color/color_constants.dart';
import 'package:gout_app/core/services/firebase/firebase_auth_controller.dart';
import 'package:gout_app/core/widgets/bottomNavigatorBar/gout_bottom.dart';
import 'package:gout_app/core/widgets/card/change_card.dart';
import 'package:gout_app/view/settings/viewmodel/settings_view_model.dart';

class SettingsView extends StatelessWidget {
  SettingsView({super.key});
  final controller = Get.put(SettingsViewModel());
  final firebaseAuth = Get.put(FirebaseAuthController());
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    controller.joinedDate();
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstants.black,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          shadowColor: ColorConstants.goutWhite,
          backgroundColor: ColorConstants.black,
          title: const Text(
            "Settings",
            style: TextStyle(color: ColorConstants.goutWhite, fontSize: 25),
          ),
        ),
        bottomSheet: goutBottomAppBar(
          pageId: 4,
        ),
        body: Padding(
          padding: EdgeInsets.only(top: Get.height * .02),
          child: Column(
            children: [
              changeCard("change your nickname", "nickname", TextInputType.text, Icons.edit, controller.tecText,() => controller.changeNickname()),
              changeCard("change your email", "email", TextInputType.emailAddress, Icons.email, controller.tecText, () => controller.changeEmail()),
              changeCard("change your password", "password", TextInputType.visiblePassword, Icons.password, controller.tecText, () => controller.changePassword()),
              _joinedDate(),
              _notificationPermission(),
              _signOutButton(),
            ],
          ),
        ),
      ),
    );
  }
  Widget _joinedDate() {
    return Container(
      height: Get.height * .06,
      width: Get.width,
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: ColorConstants.grey,
            width: 1,
          ),
          bottom: BorderSide(
            color: ColorConstants.grey,
            width: 1.5,
          ),
        ),
      ),
      child: Center(
        child: Obx(() => Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * .075),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.date_range,
                    color: ColorConstants.white,
                    size: 20,
                  ),
                  SizedBox(
                    width: Get.width * .025,
                  ),
                  const Text(
                    "joined:",
                    style: TextStyle(color: ColorConstants.goutWhite),
                  ),
                  Text(
                    " ${controller.settings.value.joinedDate.day}/${controller.settings.value.joinedDate.month}/${controller.settings.value.joinedDate.year}",
                    style: const TextStyle(color: ColorConstants.white),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  Widget _notificationPermission() {
    return InkWell(
      onTap: () {

      },
      child: Container(
        height: Get.height * .06,
        width: Get.width,
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: ColorConstants.grey,
              width: 1,
            ),
            bottom: BorderSide(
              color: ColorConstants.grey,
              width: 1.5,
            ),
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * .075),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                controller.notificationPermission.value 
                ? const Icon(
                  Icons.notifications,
                  color: ColorConstants.white,
                  size: 20,
                )
                : const Icon(
                  Icons.notifications_active,
                  color: ColorConstants.goutMainColor,
                  size: 20,
                ),
                SizedBox(
                  width: Get.width * .025,
                ),
                const Text(
                  "notification permission",
                  style: TextStyle(color: ColorConstants.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _signOutButton() {
    return InkWell(
      onTap: () {
        controller.signOut();
      },
      child: Container(
        height: Get.height * .06,
        width: Get.width,
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: ColorConstants.grey,
              width: 1,
            ),
            bottom: BorderSide(
              color: ColorConstants.grey,
              width: 1.5,
            ),
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * .075),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.logout_outlined,
                  color: ColorConstants.white,
                  size: 20,
                ),
                SizedBox(
                  width: Get.width * .025,
                ),
                const Text(
                  "sign out",
                  style: TextStyle(color: ColorConstants.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}