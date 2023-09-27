// ignore_for_file: unnecessary_null_comparison

import 'dart:io';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gout_app/core/services/firebase/firebase_firestore.dart';
import 'package:gout_app/core/widgets/error/snackbar/error_snackbar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class FirebaseStorageController extends GetxController {
  final box = GetStorage();
  final FirebaseStorage firebaseStorage =
      FirebaseStorage.instanceFor(bucket: "gs://gout-app-1c271.appspot.com");
  final firestore = Get.put(FirebaseFirestoreController());
  File? photo;
  ImagePicker imagePicker = ImagePicker();
  var imageUrl = "".obs;

  final storagePath = "gs://gout-app-1c271.appspot.com/";

  Future<void> imageFromGallery() async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      photo = File(pickedFile.path);
      update();
    } else {
      Get.showSnackbar(
        const GetSnackBar(
          message: "no image selected",
          snackPosition: SnackPosition.TOP,
        ),
      );
    }
  }

  Future<void> imageFromCamera() async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      photo = File(pickedFile.path);
      update();
    } else {
      Get.showSnackbar(
        const GetSnackBar(
          message: "no image selected",
          snackPosition: SnackPosition.TOP,
        ),
      );
    }
  }

  Future<void> uploadFile(String eventID, String comment) async {
    if (photo == null) {
      firestore.createAMomentOnlyText(eventID, comment);
    } else if (photo != null) {
      final fileName = basename(photo!.path);
      final destination = 'momentImages/$eventID/$fileName';
      try {
        final ref = firebaseStorage.ref(destination).child('images/');
        await ref.putFile(photo!);
        var url = await ref.getDownloadURL();
        firestore.createAMomentWithImage(eventID, url, comment);
      } catch (e) {
        errorSnackbar("FirebaseStorageController, uploadFile ERROR", "$e");
      }
    }
  }

  Future<void> uploadProfileImage() async {
    if (photo == null) return;
    final fileName = basename(photo!.path);
    final destination = 'userPhotos/${box.read("userUID")}/$fileName';
    try {
      final ref = firebaseStorage.ref(destination).child('images/');
      await ref.putFile(photo!);
      var url = await ref.getDownloadURL();
      firestore.uploadUserProfilePhoto(url);
      box.write("imageURL",url);
    } catch (e) {
      errorSnackbar("FirebaseStorageController, uploadFile ERROR", "$e");
    }
  }

}

// userPhotos/ZR2YjhmK4xUhtDCalVjVqK9MPnG2/1000000037.jpg