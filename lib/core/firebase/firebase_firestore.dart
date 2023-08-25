import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gout_app/core/enum/firebase_enum.dart';
import 'package:gout_app/core/widgets/error/snackbar/error_snackbar.dart';



class FirebaseFirestoreController extends GetxController {

  CollectionReference user = FirebaseCollectionsEnum.user.col;
  CollectionReference event = FirebaseCollectionsEnum.event.col;
  final box = GetStorage();


  Future<void> createAnUser(
      String name, String email, String password, String nickname) async {
    try {
      Map<String, dynamic> userInfo = {
        "name": name,
        "nickname": nickname,
        "email": email,
        "password": password,
        "uuid": box.read("userUID"),
        "friends": [],
        "friendRequest": [],
      };
      await user.doc(box.read("userUID")).set(userInfo);
    } catch (e) {
      errorSnackbar("FirebaseFirestoreController, createAnUserERROR: ", "$e");
    }
  }

  Future<void> createAnEvent(
      String eventTitle, String eventDescription, Timestamp date) async {
    try {
      Map<String, dynamic> eventInfo = {
        "createrId": box.read("userUID"),
        "createdOnDate": DateTime.now(),
        "eventTitle": eventTitle,
        "eventDescription": eventDescription,
        "date": date,
      };
      await user.doc(box.read("userUID")).collection("event").add(eventInfo);
      await event.add(eventInfo);
    } catch (e) {
      errorSnackbar("FirebaseFirestoreController, createAnEventERROR: ", "$e");
    }
  }

  Future<void> changeNickName(String nickname) async {
    try {
      await user.doc(box.read("userUID")).update({"nickname": nickname});
      Get.showSnackbar(const GetSnackBar(
        message: "Changes Saved!",
        snackPosition: SnackPosition.TOP,
      ));
    } catch (e) {
      errorSnackbar("FirebaseFirestoreController, editNickNameERROR: ", "$e");
    }
  }

  Future<void> followTheUser(String id) async {
    try {
      await user.doc(id).update({
        "friendRequest": FieldValue.arrayUnion([box.read("userUID")])
      });
    } catch (e) {
      errorSnackbar("FirebaseFireStoreController, followTheUser ERROR:", "$e");
    }
  }

  Future<void> unfollowTheUser(String id) async {
    try {
      await user.doc(id).update({
        "friends": FieldValue.arrayRemove([box.read("userUID")])
      });
      await user.doc(box.read("userUID")).update({
        "friends": FieldValue.arrayRemove([id])
      });
    } catch (e) {
      errorSnackbar("FirebaseFireStoreController, followTheUser ERROR:", "$e");
    }
  }

  Future<void> acceptFriendRequest(String id) async {
    try {
      user.doc(id).update({
        "friends": FieldValue.arrayUnion([box.read("userUID")])
      });
      user.doc(box.read("userUID")).update({
        "friendRequest": FieldValue.arrayRemove([id])
      });
    } catch (e) {
      errorSnackbar(
          "FirebaseFireStoreController, acceptFriendRequest ERROR:", "$e");
    }
  }

  Future<void> cancelFriendRequest(String id) async {
    try {
      await user.doc(box.read("userUID")).update(
        {
          "friendRequest": FieldValue.arrayRemove([id])
        },
      );
    } catch (e) {
      errorSnackbar(
          "FirebaseFireStoreController, cancelFriendRequest ERROR:", "$e");
    }
  }

  Future<void> changeEmail(String email) async {
    try {
      await user.doc(box.read("userUID")).update({
        "email": email
      });
    } catch(e) {
      errorSnackbar("title", "message");
    }
  }

  Future<void> changePassword(String password) async {
    try {
      await user.doc(box.read("userUID")).update({
        "password": password
      });
    } catch(e) {
      errorSnackbar("title", "message");
    }
  }
}
