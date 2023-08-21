// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gout_app/core/constant/color/color_constants.dart';
import 'package:gout_app/view/detail/viewmodel/detail_view_model.dart';

class DetailView extends StatelessWidget {
  DetailView({super.key, required this.eventId});
  String eventId;

  final controller = Get.put(DetailViewModel());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailViewModel>(
      init: DetailViewModel(),
      initState: (_) {},
      builder: (controller) {
        controller.getEventInfo(eventId);
        return SafeArea(
          child: Scaffold(
            backgroundColor: ColorConstants.black,
            body: Column(
              children: [
                _customAppBarField(),
                _eventCardField(),
                _yourAnswerField()
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _customAppBarField() {
    return Padding(
      padding: EdgeInsets.only(bottom: Get.height * .02),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: ColorConstants.goutWhite,
              size: 30,
            ),
          ),
          SizedBox(
            width: Get.width * .15,
          ),
          Image.asset(
            "assets/icons/ic_app_logo.png",
            width: Get.width * .45,
            height: Get.height * .07,
            fit: BoxFit.fitWidth,
          ),
        ],
      ),
    );
  }

  Widget _eventCardField() {
    DateTime date = controller.detailModel.value.date.toDate();
    String month = controller.monthMap[date.month]!;
    String day;
    date.day < 10 ? day = "0${date.day}" : day = "${date.day}";

    // DateTime createdDate = controller.detailModel.value.createdOnDate.toDate();
    // String? createdMonth = controller.monthMap[date.month];
    // String createdDay;
    // createdDate.day < 10
    //     ? createdDay = "0${createdDate.day}"
    //     : createdDay = "${createdDate.day}";

    return Padding(
      padding: EdgeInsets.only(top: Get.height * .075),
      child: Container(
        height: Get.height * .5,
        width: Get.width * .9,
        decoration: BoxDecoration(
            image: const DecorationImage(
                image: AssetImage(
                  "assets/images/detail.png",
                ),
                opacity: 0.5),
            color: ColorConstants.goutPurple,
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: Get.height * .1,
                  width: Get.width * .25,
                  decoration: const BoxDecoration(
                      color: ColorConstants.red,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      )),
                  child: Padding(
                    padding: EdgeInsets.only(left: Get.width * .05),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          day,
                          style: const TextStyle(
                              color: ColorConstants.white, fontSize: 20),
                        ),
                        Text(
                          month,
                          style: const TextStyle(
                              color: ColorConstants.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * .07,
                  width: Get.width * .64,
                  child: Column(
                    children: [
                      Text(
                        controller.detailModel.value.eventTitle.length > 25 
                        ? "${controller.detailModel.value.eventTitle.substring(0,25)}..."
                        : controller.detailModel.value.eventTitle,  
                        style: const TextStyle(
                          color: ColorConstants.backgrounColor,
                          fontSize: 17,
                          fontWeight: FontWeight.bold
                        ),
                        ),
                      Text(
                        controller.detailModel.value.eventDescription.length > 50
                        ? "${controller.detailModel.value.eventDescription.substring(0,50)}..."
                        : controller.detailModel.value.eventDescription,
                        style: const TextStyle(
                          color: ColorConstants.backgrounColor,
                          fontSize: 14
                        ),
                        ),
                    ],
                  ),
                )
              
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _yourAnswerField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding:
              EdgeInsets.only(top: Get.height * .05, bottom: Get.height * .025),
          child: InkWell(
            onTap: () {},
            child: Container(
              width: Get.width * .4,
              height: Get.height * .075,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: ColorConstants.goutRed),
              child: const Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Cancel",
                      style:
                          TextStyle(color: ColorConstants.white, fontSize: 20),
                    ),
                    Icon(
                      Icons.cancel,
                      color: ColorConstants.white,
                      size: 25,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding:
              EdgeInsets.only(top: Get.height * .05, bottom: Get.height * .025),
          child: InkWell(
            onTap: () {},
            child: Container(
              width: Get.width * .4,
              height: Get.height * .075,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: ColorConstants.goutGreen),
              child: const Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Accept",
                      style:
                          TextStyle(color: ColorConstants.white, fontSize: 20),
                    ),
                    Icon(
                      Icons.check_circle,
                      color: ColorConstants.white,
                      size: 25,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
