import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gout_app/core/constant/color_constants.dart';
import 'package:gout_app/core/widgets/appbar/gout_appbar.dart';
import 'package:gout_app/core/widgets/bottomNavigatorBar/gout_bottom.dart';
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
        bottomSheet: goutBottomAppBar(pageId: 4,),
        body: Padding(
          padding: EdgeInsets.only(top: Get.height * .02),
          child: Column(
            children: [
              _signOutButton(),
              _firstButton(),
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
              width: 0.5,
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

  Widget _firstButton() {
    return InkWell(
      onTap: () {},
      child: Container(
        height: Get.height * .06,
        width: Get.width,
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: ColorConstants.grey,
              width: 0.5,
            ),
            bottom: BorderSide(
              color: ColorConstants.grey,
              width: 0.5,
            ),
          ),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.first_page,
                color: ColorConstants.white,
                size: 20,
              ),
              SizedBox(
                width: Get.width * .025,
              ),
              const Text(
                "first page",
                style: TextStyle(color: ColorConstants.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
