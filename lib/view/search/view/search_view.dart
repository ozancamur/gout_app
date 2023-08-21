// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gout_app/core/constant/color/color_constants.dart';
import 'package:gout_app/core/widgets/add_friend_card/add_friend_card.dart';
import 'package:gout_app/core/widgets/bottomNavigatorBar/gout_bottom.dart';
import 'package:gout_app/view/search/viewmodel/serach_view_model.dart';

class SearchView extends StatelessWidget {
  SearchView({super.key});

  final controller = Get.put(SearchViewModel());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchViewModel>(
      init: (SearchViewModel()),
      initState: (_) {},
      builder: (controller) {
        return SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: ColorConstants.black,
            bottomSheet: goutBottomAppBar(pageId: 1),
            body: Column(
              children: [
                _chooseSearchCategoryField(),
                _searchBarField(),
                _searchListField()
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _chooseSearchCategoryField() {
    return Padding(
      padding: EdgeInsets.only(top: Get.height * .03),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Obx(() => InkWell(
                onTap: () {
                  controller.buttonId.value = 1;
                  controller.eventList.clear();
                },
                child: Container(
                  width: Get.width * .45,
                  height: Get.height * .04,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20)),
                      gradient: LinearGradient(
                          colors: controller.buttonId.value == 1
                              ? controller.userActiveColor
                              : controller.unactiveColor,
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight)),
                  child: const Center(
                    child: Text(
                      "user",
                      style:
                          TextStyle(color: ColorConstants.white, fontSize: 20),
                    ),
                  ),
                ),
              )),
          Obx(() => InkWell(
                onTap: () {
                  controller.buttonId.value = 2;
                  controller.userList.clear();
                },
                child: Container(
                  width: Get.width * .45,
                  height: Get.height * .04,
                  decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                      gradient: LinearGradient(
                          colors: controller.buttonId.value == 2
                              ? controller.eventActiveColor
                              : controller.unactiveColor,
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight)),
                  child: const Center(
                    child: Text(
                      "event",
                      style:
                          TextStyle(color: ColorConstants.white, fontSize: 20),
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Widget _searchBarField() {
    return Obx(
      () => controller.buttonId.value == 1
          ? Padding(
              padding: EdgeInsets.symmetric(
                  vertical: Get.height * .02, horizontal: Get.width * .05),
              child: SearchBar(
                padding: MaterialStatePropertyAll<EdgeInsets>(
                    EdgeInsets.symmetric(horizontal: Get.width * .05)),
                backgroundColor: const MaterialStatePropertyAll<Color>(
                    ColorConstants.goutWhite),
                leading: const Icon(
                  Icons.search,
                  color: ColorConstants.backgrounColor,
                ),
                onChanged: (search) {
                  controller.getUserSearch(search);
                },
                hintText: "search user",
                hintStyle: const MaterialStatePropertyAll<TextStyle>(
                    TextStyle(color: ColorConstants.backgrounColor)),
              ),
            )
          : Padding(
              padding: EdgeInsets.symmetric(
                  vertical: Get.height * .02, horizontal: Get.width * .05),
              child: SearchBar(
                padding: MaterialStatePropertyAll<EdgeInsets>(
                    EdgeInsets.symmetric(horizontal: Get.width * .05)),
                backgroundColor: const MaterialStatePropertyAll<Color>(
                    ColorConstants.goutWhite),
                leading: const Icon(
                  Icons.search,
                  color: ColorConstants.backgrounColor,
                ),
                onChanged: (search) {
                  controller.getEventSearch(search);
                },
                hintText: "search event",
                hintStyle: const MaterialStatePropertyAll<TextStyle>(
                    TextStyle(color: ColorConstants.backgrounColor)),
              ),
            ),
    );
  }

  Widget _searchListField() {
    return Obx(() => controller.buttonId.value == 1
        ? _userBuilderField()
        : _eventBuilderField());
  }

  Widget _eventBuilderField() {
    return Obx(() => controller.isLoading.value
        ? _loadingField()
        : ListView.builder(
            shrinkWrap: true,
            itemCount: controller.eventList.length,
            itemBuilder: (context, index) {
              return Text(
                controller.eventList[index].eventTitle!,
                style: const TextStyle(color: ColorConstants.goutWhite),
              );
            }));
  }

  Widget _userBuilderField() {
    return Obx(() => controller.isLoading.value
        ? _loadingField()
        : ListView.builder(
            shrinkWrap: true,
            itemCount: controller.userList.length,
            itemBuilder: (context, index) {
              return AddFriendCard(controller: controller, index: index, id: controller.userList[index].id!);
            },
          ));
  }

  Widget _loadingField() {
    return const Center(
      child: CircularProgressIndicator.adaptive(
        valueColor: AlwaysStoppedAnimation<Color>(ColorConstants.goutPurple),
        backgroundColor: Colors.white,
      ),
    );
  }
}
