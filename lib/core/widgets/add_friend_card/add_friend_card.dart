// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gout_app/core/constant/color/color_constants.dart';
import 'package:gout_app/core/firebase/firebase_firestore.dart';
import 'package:gout_app/view/friend/profile/view/friend_profile_view.dart';

class FriendCard extends StatelessWidget {
  FriendCard({super.key, required this.nickname, required this.name, required this.id, required this.imageURL});
  
  final firestore = Get.put(FirebaseFirestoreController());
  String nickname;
  String name;
  String id;
  String imageURL;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * .03),
      child: GestureDetector(
        onTap: () => Get.to(() => FriendProfileView(id: id,)),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Get.width * .03, vertical: Get.height * .01),
              child: CircleAvatar(
                backgroundColor: ColorConstants.goutMainColor,
                minRadius: 25,
                maxRadius: 25,
                child: CircleAvatar(
                  backgroundImage: const AssetImage("assets/images/no_profile_photo.png"),
                  foregroundImage: imageURL.isEmpty ? null : NetworkImage(imageURL),
                  minRadius: 24,
                  maxRadius: 24,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nickname,
                  style: const TextStyle(color: ColorConstants.white, fontSize: 16),
                ),
                Text(
                  name,
                  style: const TextStyle(color: ColorConstants.goutWhite, fontSize: 12),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
