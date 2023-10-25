// ignore_for_file: unrelated_type_equality_checks
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gout_app/core/constant/color/color_constants.dart';
import 'package:gout_app/core/widgets/add_friend_card/add_friend_card.dart';
import 'package:gout_app/core/widgets/bottomNavigatorBar/gout_bottom.dart';
import 'package:gout_app/core/widgets/eventCard/event_card.dart';
import 'package:gout_app/core/widgets/loading/loading.dart';
import 'package:gout_app/view/search/viewmodel/search_view_model.dart';

class SearchView extends StatelessWidget {
  SearchView({super.key});

  final controller = Get.put(SearchViewModel());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchViewModel>(
      init: (SearchViewModel()),
      initState: (_) {},
      builder: (controller) {
        return DefaultTabController(
          animationDuration: const Duration(milliseconds: 600),
          length: 2,
          child: SafeArea(
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: ColorConstants.black,
                bottom: TabBar(
                  unselectedLabelColor: ColorConstants.goutMainColor,
                  padding: const EdgeInsets.all(12),
                  labelStyle: const TextStyle(
                      color: ColorConstants.backgrounColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                  labelColor: ColorConstants.black,
                  dividerColor: ColorConstants.black,
                  indicator: BoxDecoration(
                    color: ColorConstants.goutMainColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  tabs: [
                    tabField(Icons.person, "User"),
                    tabField(Icons.event, "Event"),
                  ],
                ),
              ),
              resizeToAvoidBottomInset: false,
              backgroundColor: ColorConstants.black,
              bottomSheet: goutBottomAppBar(pageId: 1),
              body: TabBarView(
                children: [_userBuilderField(), _eventBuilderField()],
              ),
            ),
          ),
        );
      },
    );
  }

  Tab tabField(IconData icon, String tabText) {
    return Tab(
      child: SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon),
            SizedBox(
              width: Get.width * .04,
            ),
            Text(tabText)
          ],
        ),
      ),
    );
  }

  



  Widget _eventBuilderField() {
    return controller.isLoading.value
        ? const LoadingWidget()
        : Column(
          children: [
            searchBar("event",(search) =>  controller.getEventSearch(search)),
            SizedBox(
                height: Get.height * .675,
                width: Get.width * .87,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.eventList.length,
                  prototypeItem: const EventCard(
                      month: "June",
                      day: "10",
                      eventTitle: "birthday",
                      nickname: "ozancamur",
                      eventId: "eventid",
                      createrName: "Ozan Camur",
                      createrId: "createrId",
                      arrivals: [],
                      friends: [],),
                  itemBuilder: (context, index) {
                    if (controller.eventList != 0) {
                      controller.getCreaterNickname(
                          controller.eventList[index].createrId);
                    }
                    DateTime date = controller.eventList[index].date.toDate();
                    String month = controller.monthMap[date.month]!;
                    String day;
                    date.day < 10 ? day = "0${date.day}" : day = "${date.day}";
                    return controller.createrList.isEmpty
                        ? EventCard(
                            month: month,
                            day: day,
                            eventTitle: controller.eventList[index].eventTitle,
                            nickname: "",
                            eventId: controller.eventList[index].id,
                            createrName: "",
                            createrId: "",
                            arrivals: const [],
                            friends: const [],
                          )
                        : EventCard(
                            month: month,
                            day: day,
                            eventTitle: controller.eventList[index].eventTitle,
                            nickname: controller.createrList[index].nickname,
                            eventId: controller.eventList[index].id,
                            createrName: controller.createrList[index].name,
                            createrId: controller.eventList[index].createrId,
                            arrivals: controller.eventList[index].arrivals,
                            friends: controller.createrFriends,
                          );
                  },
                ),
              ),
          ],
        );
  }

  Widget _userBuilderField() {
    return controller.isLoading.value
        ? const LoadingWidget()
        : Column(
          children: [
            searchBar("user",(search) =>  controller.getUserSearch(search)),
            SizedBox(
                height: Get.height * .675,
                width: Get.width * .87,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.userList.length,
                  prototypeItem: FriendCard(
                      nickname: "ozancamur",
                      name: "Ozan Camur",
                      id: "id",
                      photoURL: ""),
                  itemBuilder: (context, index) {
                    return FriendCard(
                      nickname: controller.userList[index].nickname!,
                      name: controller.userList[index].name!,
                      id: controller.userList[index].id!,
                      photoURL: controller.userList[index].imageURL!,
                    );
                  },
                ),
              ),
          ],
        );
  }

  Widget searchBar(String searchText, Function(String search) onChanged) {
    return Padding(
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
                onChanged: onChanged,
                hintText: "search $searchText",
                hintStyle: const MaterialStatePropertyAll<TextStyle>(
                    TextStyle(color: ColorConstants.backgrounColor)),
              ),
            );
  }
}
