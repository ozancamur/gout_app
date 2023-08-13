import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:gout_app/core/enum/firebase_enum.dart';
import 'package:gout_app/view/home/model/home_model.dart';

class HomeController extends GetxController {
  Future<void> getEvents(List<HomeModel> eventsList) async {
    try {
      QuerySnapshot events =
          await FirebaseCollectionsEnum.event.reference.get();

      eventsList.clear();

      for (final event in events.docs) {
        eventsList.add(HomeModel(
            eventTitle: event["eventTitle"],
            eventDescription: event["eventDescription"],
            location: event["location"],
            date: event["date"]));
      }
      update();
    } catch (e) {
      Get.snackbar("HomeControllerERROR: ", "$e");
    }
  }
}
