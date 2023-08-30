import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// ignore: unused_import
import 'package:get_storage/get_storage.dart';
import 'package:gout_app/core/constant/color/color_constants.dart';
import 'package:gout_app/core/widgets/appBar/gout_appbar.dart';
import 'package:gout_app/core/widgets/bottomNavigatorBar/gout_bottom.dart';
import 'package:gout_app/view/create/model/create_model.dart';
import 'package:gout_app/view/create/viewmodel/create_view_model.dart';

class CreateView extends StatelessWidget {
  CreateView({super.key});

  final controller = Get.put(CreateViewModel());
  final box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorConstants.black,
      appBar: goutAppBar("Create an Event"),
      bottomSheet: goutBottomAppBar(pageId: 2),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Get.width * .05),
        child: Column(
          children: [
            _titleField(),
            _descriptionField(),
            _dateAndTimeField(),
            _buttonField()
          ],
        ),
      ),
    ));
  }

  Widget _titleField() {
    return Padding(
      padding: EdgeInsets.only(top: Get.height * .05),
      child: TextField(
        controller: controller.tecEventTitle,
        cursorColor: ColorConstants.white,
        keyboardType: TextInputType.emailAddress,
        strutStyle: const StrutStyle(fontSize: 15),
        style: const TextStyle(color: ColorConstants.white),
        decoration: InputDecoration(
          hintText: "Enter event's title ",
          hintStyle: const TextStyle(color: ColorConstants.grey),
          filled: true,
          fillColor: ColorConstants.backgrounColor,
          labelText: "Event Title*",
          labelStyle: const TextStyle(color: ColorConstants.white),
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

  Widget _descriptionField() {
    return Padding(
      padding: EdgeInsets.only(top: Get.height * .03),
      child: TextField(
        controller: controller.tecEventDescription,
        cursorColor: ColorConstants.white,
        keyboardType: TextInputType.emailAddress,
        strutStyle: const StrutStyle(fontSize: 15),
        style: const TextStyle(color: ColorConstants.white),
        decoration: InputDecoration(
          hintText: "Enter event's description ",
          hintStyle: const TextStyle(color: ColorConstants.grey),
          filled: true,
          fillColor: ColorConstants.backgrounColor,
          labelText: "Event Description*",
          labelStyle: const TextStyle(color: ColorConstants.white),
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

  Widget _dateAndTimeField() {
    return Padding(
        padding: EdgeInsets.only(top: Get.height * .03),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                controller.pickDate();
              },
              child: Obx(() => Text(
                    "${controller.currentDate.value.day} / ${controller.currentDate.value.month} / ${controller.currentDate.value.year}",
                    style: const TextStyle(
                        color: ColorConstants.black,
                        fontWeight: FontWeight.bold),
                  )),
            ),
            ElevatedButton(
              onPressed: () {
                controller.pickTime();
              },
              child: Obx(() => Text(
                    "${controller.currentTime.value.hour} : ${controller.currentTime.value.minute}",
                    style: const TextStyle(
                        color: ColorConstants.black,
                        fontWeight: FontWeight.bold),
                  )),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Icon(
                Icons.location_on,
                color: ColorConstants.black,
              ),
            ),
          ],
        ));
  }

  Widget _buttonField() {
    var choosedDate = Timestamp.fromDate(DateTime(
        controller.currentDate.value.year, controller.currentDate.value.month, controller.currentDate.value.day, 
        controller.currentTime.value.hour, controller.currentTime.value.minute
        ));
    return Padding(
      padding:
          EdgeInsets.only(top: Get.height * .05, bottom: Get.height * .025),
      child: InkWell(
        onTap: () {
          controller.createEvent(
            CreateModel(
              arrivals: [],
              createdOnDate: Timestamp.fromDate(DateTime.now()),
              createrId: box.read("userUID"),
              date: choosedDate,
              eventDescription: controller.tecEventDescription.text,
              eventTitle: controller.tecEventTitle.text,
              invited: [], 
            ),
          );
        },
        child: Container(
          width: Get.width,
          height: Get.height * .075,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(colors: [
                ColorConstants.goutSecondColor,
                ColorConstants.goutThirdColor
              ], begin: Alignment.centerLeft, end: Alignment.centerRight)),
          child: const Center(
            child: Text(
              "Create an Event",
              style: TextStyle(color: ColorConstants.white, fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}
