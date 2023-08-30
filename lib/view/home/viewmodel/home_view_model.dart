import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gout_app/core/enum/firebase_enum.dart';
import 'package:gout_app/core/widgets/error/snackbar/error_snackbar.dart';
import 'package:gout_app/view/home/model/home_model.dart';

class HomeViewModel extends GetxController {
  List<HomeModel> eventsList = <HomeModel>[].obs;
  List<String> nickname = <String>[].obs;
  List<String> name = <String>[].obs;
  final box = GetStorage();
  var imageURL = "https://firebasestorage.googleapis.com/v0/b/gout-app-1c271.appspot.com/o/userPhotos%2FZR2YjhmK4xUhtDCalVjVqK9MPnG2%2F1000000036.jpg%2Fimages?alt=media&token=ad58af3f-8cfe-49f7-9378-ea9af41734df".obs;
  

  var isLoading = false.obs;

  Future<void> getEvents() async {
    try {
      QuerySnapshot events = await FirebaseCollectionsEnum.event.col.get();
      eventsList.clear();

      for (final event in events.docs) {
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
        update();
      }
    } catch (e) {
      errorSnackbar("HomeViewModel_getEvents_ERROR: ", "$e");
    }
  }

  void getCreaterNickname(String id) async {
    isLoading.value = true;
    try {
      DocumentSnapshot creater =
          await FirebaseCollectionsEnum.user.col.doc(id).get();
      nickname.add(creater["nickname"]);
      name.add(creater["name"]);
    } catch (e) {
      errorSnackbar("HomeViewModel_getEvents_ERROR: ", "$e");
    }
    isLoading.value = true;
  }

  void getImage() {
    imageURL.value = box.read("imageURL");
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
