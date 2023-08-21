import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:gout_app/core/enum/firebase_enum.dart';
import 'package:gout_app/core/widgets/error/snackbar/error_snackbar.dart';
import 'package:gout_app/view/detail/model/detail_model.dart';

class DetailController extends GetxController {
  static DetailController get instance => Get.find();

  Future<void> getEventsDetail(
      String eventId, Rx<DetailModel> detailModel) async {
    try {
      DocumentSnapshot event =
          await FirebaseCollectionsEnum.event.col.doc(eventId).get();

      detailModel.update(
        (val) {
          val!.createrId = event["createrId"];
          val.createdOnDate = event["createdOnDate"];
          val.date = event["date"];
          val.eventTitle = event["eventTitle"];
          val.eventDescription = event["eventDescription"];
        },
      );
      update();
    } catch (e) {
      errorSnackbar("DetailControllerERROR: ", "$e");
    }
  }
}
