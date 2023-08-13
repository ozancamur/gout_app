import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gout_app/core/constant/color_constants.dart';

class EventCard extends StatelessWidget {
  const EventCard({
    super.key,
    required this.month,
    required this.day,
    required this.eventTitle,
    required this.nickname,
  });

  final String month;
  final String day;
  final String eventTitle;
  final String nickname;


  @override
  Widget build(BuildContext context) {

    var title;
    if(eventTitle.length > 38) {
      title = "${eventTitle.substring(0,30)}...";
    } else {
      title = eventTitle;
    }

    return Padding(
      padding: EdgeInsets.only(top: Get.height * .02),
      child: InkWell(
        onTap: () {
          //detail
        },
        child: Container(
          height: Get.height * .1,
          decoration: BoxDecoration(
            color: ColorConstants.white,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: Get.height,
                width: Get.width * .25,
                decoration: const BoxDecoration(
                    color: ColorConstants.red,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      bottomLeft: Radius.circular(25),
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
              Padding(
                padding: EdgeInsets.only(left: Get.width*.047),
                child: SizedBox(
                  height: Get.height,
                  width: Get.width*.45,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        title.toString().toUpperCase(),
                        style: const TextStyle(
                            color: ColorConstants.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15
                            ),
                      ),
                      Text(
                        nickname.toLowerCase(),
                        style: const TextStyle(
                          color: ColorConstants.black,
                          fontSize: 12
                        ),
                      )
                    ],
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.info_outline,
                  color: ColorConstants.backgrounColor,
                  size: 17,
                ),
                onPressed: () { 
                  
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
