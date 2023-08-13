// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gout_app/core/widgets/bottomNavigatorBar/event_card.dart';
import 'package:gout_app/core/widgets/bottomNavigatorBar/gout_bottom.dart';
import 'package:gout_app/core/constant/color_constants.dart';
import 'package:gout_app/view/home/controller/home_controller.dart';
import 'package:gout_app/view/home/viewmodel/home_view_model.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  HomeViewModel homeViewModel =
      Get.put(HomeViewModel(homeController: HomeController()));

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (homeController) {
        homeViewModel.getEvents();
        return Scaffold(
            backgroundColor: ColorConstants.black,
            bottomSheet: goutBottomAppBar(pageId: 0,),
            body: SizedBox(
              height: Get.height,
              width: Get.width,
              child: Stack(
                children: [
                  _eventBox(),
                  _customAppBar(),
                ],
              ),
            ),
          );
      },
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "you are",
                    style: TextStyle(
                        color: ColorConstants.goutDarkBlue, fontSize: 16),
                  ),
                  Obx(
                    () => DropdownButton<String>(
                      underline: const SizedBox(),
                      borderRadius: BorderRadius.circular(30),
                      padding:
                          EdgeInsets.symmetric(vertical: Get.height * .002),
                      isDense: true,
                      dropdownColor: ColorConstants.backgrounColor,
                      iconDisabledColor: ColorConstants.white,
                      iconEnabledColor: ColorConstants.white,
                      iconSize: 0,
                      style: const TextStyle(
                          color: ColorConstants.white, fontSize: 25),
                      value: homeViewModel.menuValue.value,
                      icon: const Icon(Icons.arrow_downward_outlined),
                      onChanged: (newValue) {
                        homeViewModel.setSelected(newValue!);
                      },
                      items: homeViewModel.homeList
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  //Text("Volkswagen Arena", style: TextStyle(color: ColorConstants.white, fontSize: 20),),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: Get.height * .06),
              child: const CircleAvatar(
                backgroundColor: ColorConstants.goutBlue,
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

  Widget _eventBox() {
    return Positioned(
      top: 100,
      left: 25,
      child: SizedBox(
      height: Get.height,
      width: Get.width * .87,
      child: Obx(
        () => ListView.builder(
          itemCount: homeViewModel.eventList.length,
          itemBuilder: (context, index) {
            DateTime date = homeViewModel.eventList[index].date.toDate();
            String? month = homeViewModel.monthMap[date.month];
            String day;
            date.day < 10 ? day = "0${date.day}" : day = "${date.day}";
            return EventCard(
              day: day, 
              month: month!, 
              eventTitle: homeViewModel.eventList[index].eventTitle,
              nickname: "ozancamur",
              );
          },
        ),
      ),
    )
    );
  }
}