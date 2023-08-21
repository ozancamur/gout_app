import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gout_app/core/constant/color/color_constants.dart';
import 'package:gout_app/core/widgets/appbar/gout_appbar.dart';
import 'package:gout_app/core/widgets/bottomNavigatorBar/gout_bottom.dart';
import 'package:gout_app/view/proile/view/profile_view.dart';
import 'package:gout_app/view/settings/viewmodel/settings_view_model.dart';

class SettingsView extends StatelessWidget {
  SettingsView({super.key});

  final controller = Get.put(SettingsViewModel());

  @override
  Widget build(BuildContext context) {
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
              _editNickButton(),
              _signOutButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _editNickButton() {
    return InkWell(
      onTap: () {
        Get.defaultDialog(
            backgroundColor: ColorConstants.white,
            title: "change your nickname",
            titlePadding: EdgeInsets.only(top: Get.height*.025,left: Get.width*.05, right: Get.width*.05),
            content: Column(
              children: [_dialogTextField(), _dialogButtonField()],
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

  Padding _dialogTextField() {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: Get.height * .01, horizontal: Get.width * .04),
      child: TextField(
        controller: controller.tecNickname,
        cursorColor: ColorConstants.white,
        keyboardType: TextInputType.emailAddress,
        strutStyle: const StrutStyle(fontSize: 15),
        style: const TextStyle(color: ColorConstants.white),
        decoration: InputDecoration(
          hintText: "nickname",
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

  Padding _dialogButtonField() {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: Get.height * .01, horizontal: Get.width * .04),
      child: InkWell(
        onTap: () {
          controller.changeNickname();
          Get.to(() => ProfileView());
        },
        child: Container(
          width: Get.width*.35,
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
}
