import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:gout_app/core/enum/firebase_enum.dart';
import 'package:gout_app/core/widgets/error/snackbar/error_snackbar.dart';
import 'package:gout_app/view/detail/model/detail_model.dart';

class DetailViewModel extends GetxController {
  
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

  Rx<DetailModel> detailModel = DetailModel(
    createdOnDate: Timestamp(0, 0), 
    createrId: "", 
    date: Timestamp(0, 0),
    eventDescription: "", 
    eventTitle: "",
    arrivals: [],
    ).obs;

  Future<void> getEventsDetail(
      String eventId) async {
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
          val.arrivals = event["arrivals"];
        },
      );
      update();
    } catch (e) {
      errorSnackbar("DetailControllerERROR: ", "$e");
    }
  }

  




  

}