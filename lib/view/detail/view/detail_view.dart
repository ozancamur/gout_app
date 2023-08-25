// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gout_app/core/constant/color/color_constants.dart';
import 'package:gout_app/core/widgets/appBar/gout_appbar.dart';
import 'package:gout_app/view/detail/viewmodel/detail_view_model.dart';

class DetailView extends StatelessWidget {
  DetailView({super.key, required this.eventId, required this.createrName});
  String eventId;
  String createrName;

  final controller = Get.put(DetailViewModel());

  @override
  Widget build(BuildContext context) {
    print("Profiel id $eventId");
    return GetBuilder<DetailViewModel>(
      init: DetailViewModel(),
      initState: (_) {},
      builder: (controller) {
        controller.getEventsDetail(eventId);
        return SafeArea(
          child: Scaffold(
            appBar: goutAppBar("Event"),
            backgroundColor: ColorConstants.black,
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * .05),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _eventCardField(),
                  _yourAnswerField(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _eventCardField() {
    DateTime date = controller.detailModel.value.date.toDate();
    String day;
    String month = controller.monthMap[date.month]!;
    String year = date.year.toString();
    String hour;
    String minute;
    date.day < 10 ? day = "0${date.day}" : day = "${date.day}";
    date.hour < 10 ? hour = "0${date.hour}" : hour = "${date.hour}";
    date.minute < 10 ? minute = "0${date.minute}" : minute = "${date.minute}";

    // DateTime createdDate = controller.detailModel.value.createdOnDate.toDate();
    // String? createdMonth = controller.monthMap[date.month];
    // String createdDay;
    // createdDate.day < 10
    //     ? createdDay = "0${createdDate.day}"
    //     : createdDay = "${createdDate.day}";

    return Container(
      height: Get.height * .675,
      width: Get.width * .9,
      decoration: BoxDecoration(
          color: ColorConstants.backgrounColor,
          borderRadius: BorderRadius.circular(30)),
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: Get.height * .04, horizontal: Get.width * .065),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ! EVENT TITLE & DESCRIPTION
            Padding(
              padding: EdgeInsets.only(bottom: Get.height * .06),
              child: Container(
                height: Get.height * .15,
                width: Get.width,
                decoration: const BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                            color: ColorConstants.grey, width: 0.65))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      controller.detailModel.value.eventTitle.toUpperCase(),
                      style: const TextStyle(
                          color: ColorConstants.white, fontSize: 27),
                    ),
                    Text(
                        controller.detailModel.value.eventDescription
                            .toLowerCase(),
                        style: const TextStyle(
                            color: ColorConstants.goutWhite, fontSize: 16)),
                  ],
                ),
              ),
            ),

            //! LOCATION
            _eventProperty("Madrid, Spain", "place"),

            //! ABOUT EVENT
            Padding(
              padding: EdgeInsets.symmetric(vertical: Get.height * .02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //! date and organizator
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _eventProperty("$day/$month/${date.year}", "date"),
                      _eventProperty(createrName, "organizator"),
                    ],
                  ),
                  //! time and arrivals
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _eventProperty("$hour:$minute", "time"),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            controller.detailModel.value.arrivals.length.toString(),
                            style: const TextStyle(
                                color: ColorConstants.white, fontSize: 20),
                          ),
                          GestureDetector(
                            onTap: () {
                             
                            },
                            child: Text("arrivals".toLowerCase(),
                                style: const TextStyle(
                                    color: ColorConstants.grey, fontSize: 14)),
                          ),
                          SizedBox(
                            height: Get.height * .03,
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),

            //! BUTTONFİELD OF ADD A NEW MOMENT
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    print("object");
                  },
                  child: Container(
                    height: Get.height * .08,
                    width: Get.width * .4,
                    decoration: BoxDecoration(
                      color: ColorConstants.goutWhite,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: TextButton.icon(
                      onPressed: () {
                        print("2");
                      },
                      icon: const Icon(
                        Icons.add,
                        color: ColorConstants.black,
                        size: 30,
                      ),
                      label: const Text(
                        "Add a New Moment",
                        style: TextStyle(
                            color: ColorConstants.black,
                            fontSize: 17,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _eventProperty(String location, String field) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          location,
          style: const TextStyle(color: ColorConstants.white, fontSize: 20),
        ),
        Text(field.toLowerCase(),
            style: const TextStyle(color: ColorConstants.grey, fontSize: 14)),
        SizedBox(
          height: Get.height * .03,
        )
      ],
    );
  }

  Widget _yourAnswerField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
          onTap: () {
            print("object");
          },
          child: Container(
            width: Get.width * .4,
            height: Get.height * .075,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: ColorConstants.goutRed),
            child: const Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Cancel",
                    style: TextStyle(color: ColorConstants.white, fontSize: 20),
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
        InkWell(
          onTap: () {},
          child: Container(
            width: Get.width * .4,
            height: Get.height * .07,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: ColorConstants.goutGreen),
            child: const Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Accept",
                    style: TextStyle(color: ColorConstants.white, fontSize: 20),
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
      ],
    );
  }
}
