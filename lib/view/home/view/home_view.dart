// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gout_app/core/constant/color/color_constants.dart';
import 'package:gout_app/core/widgets/eventCard/event_card.dart';
import 'package:gout_app/core/widgets/bottomNavigatorBar/gout_bottom.dart';
import 'package:gout_app/core/widgets/loading/loading.dart';
import 'package:gout_app/view/home/viewmodel/home_view_model.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final controller = Get.put(HomeViewModel.instance);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeViewModel>(
      init: HomeViewModel(),
      initState: (_) {},
      builder: (controller) {
        controller.getEvents();
        return SafeArea(
          child: Scaffold(
              backgroundColor: ColorConstants.black,
              bottomSheet: goutBottomAppBar(
                pageId: 0,
              ),
              body: _bodyField()),
        );
      },
    );
  }

  Widget _bodyField() {
    return SizedBox(
      height: Get.height,
      width: Get.width,
      child: Column(
        children: [
          _customAppBar(),
          _eventList(),
        ],
      ),
    );
  }

  Widget _customAppBar() {
    return Container(
      width: Get.width,
      height: Get.height * .17,
      decoration: const BoxDecoration(
          color: ColorConstants.backgrounColor,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30))),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Get.width * .07),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(top: Get.height * .08),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "you are",
                    style: TextStyle(
                        color: ColorConstants.goutThirdColor, fontSize: 16),
                  ),
                  Text("Online",
                      style:
                          TextStyle(color: ColorConstants.white, fontSize: 25)),
                  //Text("Volkswagen Arena", style: TextStyle(color: ColorConstants.white, fontSize: 20),),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: Get.height * .06),
              child: const CircleAvatar(
                backgroundColor: ColorConstants.goutMainColor,
                minRadius: 21.75,
                maxRadius: 28.75,
                child: CircleAvatar(
                  foregroundImage: AssetImage("assets/images/me.png"),
                  minRadius: 20,
                  maxRadius: 27,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _eventList() {
    return Positioned(
      top: 100,
      left: 25,
      child: SizedBox(
        height: Get.height * .751,
        width: Get.width * .87,
        child: Obx(
          () => ListView.builder(
            itemCount: controller.eventsList.length,
            itemBuilder: (context, index) {
              DateTime date = controller.eventsList[index].date.toDate();
              String? month = controller.monthMap[date.month];
              String day;
              date.day < 10 ? day = "0${date.day}" : day = "${date.day}";
              return controller.isLoading.value
                  ? const LoadingWidget()
                  : EventCard(
                      day: day,
                      month: month!,
                      eventTitle: controller.eventsList[index].eventTitle,
                      nickname: "ozancamur",
                      eventId: controller.eventsList[index].id,
                    );
            },
          ),
        ),
      ),
    );
  }
}
