import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gout_app/core/services/constant/color/color_constants.dart';

Padding goutButton(List<Color> colors, String buttonText, Function() onPressed,) {
  return Padding(
    padding: EdgeInsets.only(top: Get.height * .05, bottom: Get.height * .025),
    child: Container(
      width: Get.width,
      height: Get.height * .075,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: LinearGradient(
              colors: colors,
              begin: Alignment.centerLeft,
              end: Alignment.centerRight)),
      child: TextButton(
        onPressed: onPressed,
        child: SizedBox(
          width: Get.width,
          height: Get.height * .075,
          child: Center(
            child: Text(
              buttonText,
              style: const TextStyle(color: ColorConstants.white, fontSize: 20),
            ),
          ),
        ),
      ),
    ),
  );
}
