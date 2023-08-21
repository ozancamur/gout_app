import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:gout_app/view/detail/controller/detail_controller.dart';
import 'package:gout_app/view/detail/model/detail_model.dart';

class DetailViewModel extends GetxController {
  static DetailViewModel get instance => Get.find();
  final controller = Get.put(DetailController());
  
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
    eventTitle: ""
    ).obs;

  void getEventInfo(String eventId) {
    controller.getEventsDetail(eventId, detailModel); 
  }

  




  

}