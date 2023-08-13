import 'package:get/get.dart';
import 'package:gout_app/view/home/controller/home_controller.dart';
import 'package:gout_app/view/home/model/home_model.dart';

class HomeViewModel extends GetxController {
  HomeController homeController = Get.put(HomeController());
  HomeViewModel({required this.homeController});

// ! HOMECONTROLLER
  final Map<int, String> monthMap = {
    01: "Jan",
    02: "Feb",
    03: "Mar",
    04: "Apr",
    05: "May",
    06: "June",
    07: "July",
    08: "Aug",
    09: "Sep",
    10: "Oct",
    11: "Nov",
    12: "Dec",
  };
  List<HomeModel> eventList = <HomeModel>[].obs;
  Future<void> getEvents() async {
    homeController.getEvents(eventList);
    update();
  }
  // ! HOMECONTROLLER

  // ! DROPDROWNBUTTON
  final List<String> homeList = ["Offline", "Online", "on Event "];
  final menuValue = "Online".obs;
  void setSelected(String selected) {
    menuValue.value = selected;
    update();
  }
  // ! DROPDROWNBUTTON
}
