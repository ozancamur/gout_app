import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gout_app/core/constant/color/color_constants.dart';
import 'package:gout_app/core/firebase/firebase_auth_controller.dart';
import 'package:gout_app/core/widgets/appbar/gout_appbar.dart';
import 'package:gout_app/core/widgets/bottomNavigatorBar/gout_bottom.dart';
import 'package:gout_app/view/settings/viewmodel/settings_view_model.dart';

class SettingsView extends StatelessWidget {
  SettingsView({super.key});
  final controller = Get.put(SettingsViewModel());
  final firebaseAuth = Get.put(FirebaseAuthController());

  @override
  Widget build(BuildContext context) {
    controller.joinedDate();

    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstants.black,
        appBar: goutAppBar("Settings"),
        bottomSheet: goutBottomAppBar(
          pageId: 4,
        ),
        body: Padding(
          padding: EdgeInsets.only(top: Get.height * .02),
          child: Column(
            children: [
              _changeNickname(),
              _changeEmail(),
              _changePassword(),
              _joinedDate(),
              _signOutButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _changeNickname() {
    return InkWell(
      onTap: () {
        Get.defaultDialog(
            backgroundColor: ColorConstants.white,
            title: "change your nickname",
            titlePadding: EdgeInsets.only(
                top: Get.height * .025,
                left: Get.width * .05,
                right: Get.width * .05),
            content: Column(
              children: [_dialogTextField("nickname"), _dialogButtonField(0)],
            ));
      },
      child: Container(
        height: Get.height * .06,
        width: Get.width,
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: ColorConstants.grey,
              width: 1.5,
            ),
            bottom: BorderSide(
              color: ColorConstants.grey,
              width: 1,
            ),
          ),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.edit,
                color: ColorConstants.white,
                size: 20,
              ),
              SizedBox(
                width: Get.width * .025,
              ),
              const Text(
                "edit your nickname",
                style: TextStyle(color: ColorConstants.white),
              ),
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
        child: Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
            )),
      ),
    );
  }

  Widget _changeEmail() {
    return InkWell(
      onTap: () {
        Get.defaultDialog(
            backgroundColor: ColorConstants.white,
            title: "change your email",
            titlePadding: EdgeInsets.only(
                top: Get.height * .025,
                left: Get.width * .05,
                right: Get.width * .05),
            content: Column(
              children: [_dialogTextField("email"), _dialogButtonField(1)],
            ));
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.email_outlined,
                color: ColorConstants.white,
                size: 20,
              ),
              SizedBox(
                width: Get.width * .025,
              ),
              const Text(
                "change your email",
                style: TextStyle(color: ColorConstants.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _changePassword() {
    return InkWell(
      onTap: () {
        Get.defaultDialog(
            backgroundColor: ColorConstants.white,
            title: "change your password",
            titlePadding: EdgeInsets.only(
                top: Get.height * .025,
                left: Get.width * .05,
                right: Get.width * .05),
            content: Column(
              children: [_dialogTextField("password"), _dialogButtonField(2)],
            ));
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.password_outlined,
                color: ColorConstants.white,
                size: 20,
              ),
              SizedBox(
                width: Get.width * .025,
              ),
              const Text(
                "change your password",
                style: TextStyle(color: ColorConstants.white),
              ),
            ],
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
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
    );
  }

  // ! GET.DEFAULTDIALOG WIDGETS

  Widget _dialogTextField(String field) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: Get.height * .01, horizontal: Get.width * .04),
      child: TextField(
        controller: controller.tecText,
        cursorColor: ColorConstants.white,
        keyboardType: TextInputType.emailAddress,
        strutStyle: const StrutStyle(fontSize: 15),
        style: const TextStyle(color: ColorConstants.white),
        decoration: InputDecoration(
          hintText: field,
          hintStyle: const TextStyle(color: ColorConstants.grey),
          filled: true,
          fillColor: ColorConstants.backgrounColor,
          border: OutlineInputBorder(
              borderSide:
                  const BorderSide(width: 1.5, color: ColorConstants.grey),
              borderRadius: BorderRadius.circular(20)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 1.5,
                color: ColorConstants.goutMainColor,
              ),
              borderRadius: BorderRadius.circular(20)),
        ),
      ),
    );
  }

  Widget _dialogButtonField(int id) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: Get.height * .01, horizontal: Get.width * .04),
      child: InkWell(
        onTap: () {
          if (id == 0) {
            controller.changeNickname();
          } else if (id == 1) {
            //controller.changeEmail();
          } else if (id == 2) {
            //controller.changePassword();
          }
        },
        child: Container(
          width: Get.width * .35,
          height: Get.height * .05,
          decoration: BoxDecoration(
              border:
                  Border.all(width: .75, color: ColorConstants.backgrounColor),
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(colors: [
                ColorConstants.goutSecondColor,
                ColorConstants.goutThirdColor
              ], begin: Alignment.centerLeft, end: Alignment.centerRight)),
          child: const Center(
            child: Text(
              "change",
              style: TextStyle(color: ColorConstants.white, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
