import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gout_app/core/constant/color/color_constants.dart';
import 'package:gout_app/view/home/viewmodel/home_view_model.dart';

class SplashView extends StatelessWidget {
  SplashView({super.key});

  final controller = Get.put(HomeViewModel());
  
  @override
  Widget build(BuildContext context) {
    controller.getImage();
    controller.getEvents();
    controller.getVersion();
    return Scaffold(
      backgroundColor: ColorConstants.backgrounColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Image.asset(
              "assets/logo/ic_app_logo.png",
              width: Get.width*.5,
              height: Get.height*.75,
              ),
              Positioned(
                top: Get.height*.45,
                left: Get.width*.2,
                child: const CircularProgressIndicator()),
              ],
            ),
          
            _appVersion(),
          ],
        ),
      ),
    );
  }

    Widget _appVersion() {
    return Obx(() => SizedBox(
          height: Get.height * .1,
          width: Get.width,
          child: Center(
            child: Text(
              "version ${controller.version.value}",
              style: const TextStyle(
                  color: ColorConstants.goutPurple,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            ),
          ),
        ));
  }
}