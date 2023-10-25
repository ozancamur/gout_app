import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gout_app/core/constant/color/color_constants.dart';

AppBar goutAppBar(String title) {
  return AppBar(
    shadowColor: ColorConstants.goutWhite,
    backgroundColor: ColorConstants.black,
    leading: IconButton(
      onPressed: () => Get.back(),
      icon: const Icon(
        Icons.arrow_back,
        color: ColorConstants.white,
        size: 20,
      ),
    ),
    title: Text(
      title,
      style: const TextStyle(color: ColorConstants.white, fontSize: 25),
    ),
  );
}
