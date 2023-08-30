import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gout_app/core/enum/firebase_enum.dart';
import 'package:gout_app/core/widgets/error/snackbar/error_snackbar.dart';
import 'package:gout_app/view/create/model/create_model.dart';

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
      CreateModel model) async {
        String id = event.doc().id;
    try {
      Map<String, dynamic> eventInfo = {
        "arrivals" : model.arrivals,
        "createdOnDate": model.createdOnDate,
        "createrId": model.createrId,
        "date": model.date,
        "eventDescription": model.eventDescription,
        "eventTitle": model.eventTitle,
        "invited": model.invited
      };
      await event.doc(id).set(eventInfo);
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

  void acceptFriendRequest(String id)  {
    user.doc(box.read("userUID")).update({
        "friendRequest": FieldValue.arrayRemove([id.trim()]),
        "followers": FieldValue.arrayUnion([id.trim()])
    });

    user.doc(id).update({
      "followers": FieldValue.arrayUnion([box.read("userUID")]) 
    });
  }

  void cancelFriendRequest(String id) {
      user.doc(box.read("userUID")).update(
        {
          "friendRequest": FieldValue.arrayRemove([id.trim()])
        },
      );
  }

  Future<void> changeEmail(String email) async {
    try {
      await user.doc(box.read("userUID")).update({"email": email});
    } catch (e) {
      errorSnackbar("title", "message");
    }
  }

  Future<void> changePassword(String password) async {
    try {
      await user.doc(box.read("userUID")).update({"password": password});
    } catch (e) {
      errorSnackbar("title", "message");
    }
  }

  Future<void> acceptEventRequest(String id) async {
    await event.doc(id).update({
      "arrivals": FieldValue.arrayUnion([box.read("userUID")]),
      "invited": FieldValue.arrayRemove([box.read("userUID")])
    });
  }

  Future<void> cancelEventRequest(String id) async {
    await event.doc(id).update({
      "invited": FieldValue.arrayRemove(["userUID"])
    });
  }

  Future<void> cantComeEvent(String id) async {
    await event.doc(id).update({
      "arrivals": FieldValue.arrayRemove([box.read("userUID")])
    });
  }

  Future<void> eventIsFavorite(String id) async {
    await user.doc(box.read("userUID")).update({
      "favoriteEvents": FieldValue.arrayUnion([id])
    });
  }

  Future<void> eventIsNotFavorite(String id) async {
    await user.doc(box.read("userUID")).update({
      "favoriteEvents": FieldValue.arrayRemove([id])
    });
  }

  Future<void> createAMomentWithImage(String eventID, String momentImagePath, String comment) async {

    Map<String, dynamic> momentInfo = {
      "createrId": box.read("userUID"),
      "createdOnDate": DateTime.now(),
      "momentImageUrl": momentImagePath,
      "comment": comment,
    };
    
    await event.doc(eventID).collection("moment").add(momentInfo);
  }

  Future<void> createAMomentOnlyText(String eventID,String comment) async {

    Map<String, dynamic> momentInfo = {
      "createrId": box.read("userUID"),
      "createdOnDate": DateTime.now(),
      "momentImageUrl": null,
      "comment": comment,
    };
    
    await event.doc(eventID).collection("moment").add(momentInfo);
  }

  Future<void> uploadUserProfilePhoto(String imagePath) async {
    user.doc(box.read("userUID")).update({
      "photoURL": imagePath
    });

  }
}
