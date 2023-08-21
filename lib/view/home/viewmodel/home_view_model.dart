import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:gout_app/core/enum/firebase_enum.dart';
import 'package:gout_app/core/widgets/error/snackbar/error_snackbar.dart';
import 'package:gout_app/view/home/model/home_model.dart';

class HomeViewModel extends GetxController {
  static HomeViewModel get instance => Get.find();
  List<HomeModel> eventsList = <HomeModel>[].obs;

  var isLoading = false.obs;

  Future<void> getEvents() async {
    isLoading.value = true;
    try {
      QuerySnapshot events = await FirebaseCollectionsEnum.event.col.get();
      for (final event in events.docs) {
        eventsList.clear();
        eventsList.add(
          HomeModel(
            createdOnDate: event["createdOnDate"],
            createrId: event["createrId"],
            date: event["date"],
            eventDescription: event["eventDescription"],
            eventTitle: event["eventTitle"],
            id: event.id,
          ),
        );
      }
    } catch (e) {
      errorSnackbar("HomeViewModel_getEvents_ERROR: ", "$e");
    }
    isLoading.value = false;
  }

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
}
