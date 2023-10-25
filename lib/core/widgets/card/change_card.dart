import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gout_app/core/constant/color/color_constants.dart';


PopupMenuItem changeEvent(String title, String whichField, TextInputType keybordType, TextEditingController textEditingController, Function() onTap) {
  return PopupMenuItem(
        onTap: () {
          Get.defaultDialog(
            backgroundColor: ColorConstants.backgrounColor,
            title: title,
            titleStyle: const TextStyle(color: ColorConstants.goutWhite),
            titlePadding: EdgeInsets.only(
                top: Get.height * .025,
                left: Get.width * .05,
                right: Get.width * .05),
            content: Column(
              children: [_dialogTextField(whichField,textEditingController, keybordType), _dialogButtonField(onTap)],
            ));
        },
        child: Text(
          title,
          style: const TextStyle(color: ColorConstants.goutWhite),
        ));  
}

changeCard(String title, String whichField, TextInputType keybordType, IconData icon, TextEditingController textEditingController, Function() onTap) {
  return InkWell(
      onTap: () {
        Get.defaultDialog(
            backgroundColor: ColorConstants.backgrounColor,
            title: title,
            titleStyle: const TextStyle(color: ColorConstants.goutWhite),
            titlePadding: EdgeInsets.only(
                top: Get.height * .025,
                left: Get.width * .05,
                right: Get.width * .05),
            content: Column(
              children: [_dialogTextField(whichField,textEditingController, keybordType), _dialogButtonField(onTap)],
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
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * .075),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: ColorConstants.white,
                  size: 20,
                ),
                SizedBox(
                  width: Get.width * .025,
                ),
                Text(
                  "edit your $whichField",
                  style: const TextStyle(color: ColorConstants.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
}

Widget _dialogTextField(String field, TextEditingController textEditingController, TextInputType keybordType) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: Get.height * .01, horizontal: Get.width * .04),
      child: TextField(
        controller: textEditingController,
        keyboardType: keybordType,
        strutStyle: const StrutStyle(fontSize: 15),
        style: const TextStyle(color: ColorConstants.black),
        decoration: InputDecoration(
          hintText: field,
          hintStyle: const TextStyle(color: ColorConstants.grey),
          filled: true,
          fillColor: ColorConstants.white,
          border: OutlineInputBorder(
              borderSide:
                  const BorderSide(width: 1.5, color: ColorConstants.white),
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

Widget _dialogButtonField(Function() onPressed) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: Get.height * .01, horizontal: Get.width * .04),
      child: Container(
        width: Get.width * .35,
        height: Get.height * .05,
        decoration: BoxDecoration(
            border:
                Border.all(width: .75, color: ColorConstants.backgrounColor),
            borderRadius: BorderRadius.circular(20),
            color: ColorConstants.goutWhite
            ),
        child: TextButton(
          onPressed: onPressed,
          child: const Text(
            "change",
            style: TextStyle(color: ColorConstants.black, fontSize: 16),
          ),
        ),
      ),
    );
  }