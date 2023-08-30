import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gout_app/core/firebase/firebase_firestore.dart';
import 'package:gout_app/core/widgets/error/snackbar/error_snackbar.dart';
import 'package:gout_app/view/create/model/create_model.dart';

class CreateViewModel extends GetxController {
    final firebaseFirestore = Get.put(FirebaseFirestoreController());


  TextEditingController tecEventTitle = TextEditingController();
  TextEditingController tecEventDescription = TextEditingController();

  var currentDate = DateTime.now().obs;
  var currentTime = TimeOfDay.now().obs;


  pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: Get.context!, 
      initialDate: currentDate.value, 
      firstDate: DateTime(2000), 
      lastDate: DateTime(2100),
      );
      if(pickedDate != null && pickedDate!=currentDate.value) {
        currentDate.value = pickedDate;
        update();
      }
  }

  pickTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: Get.context!, 
      initialTime: currentTime.value, 
      );
      if(pickedTime != null && pickedTime != currentTime.value) {
          currentTime.value = pickedTime;
      }
  }

  Future<void> createEvent(CreateModel model) async {
    try {
        firebaseFirestore.createAnEvent(model);
    } catch (e) {
      errorSnackbar("CreateViewModel, createEventERROR: ", "$e");
    }
  }




}