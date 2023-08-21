// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gout_app/core/constant/color/color_constants.dart';
import 'package:gout_app/core/firebase/firebase_firestore.dart';
import 'package:gout_app/view/search/viewmodel/serach_view_model.dart';

class AddFriendCard extends StatelessWidget {
  AddFriendCard({super.key, required this.controller, required this.index, required this.id});

  final firestore = Get.put(FirebaseFirestoreController());
  int index;
  String id;
  final SearchViewModel controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * .03),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Get.width * .03, vertical: Get.height * .01),
                child: const CircleAvatar(
                  backgroundColor: ColorConstants.goutMainColor,
                  minRadius: 13,
                  maxRadius: 15,
                  child: CircleAvatar(
                    foregroundImage: AssetImage("assets/images/me.png"),
                    minRadius: 12.5,
                    maxRadius: 14.5,
                  ),
                ),
              ),
              Text(
                controller.userList[index].nickname!,
                style: const TextStyle(color: ColorConstants.goutWhite),
              )
            ],
          ),
          IconButton(
            onPressed: () {
              firestore.followTheUser(id);
            },
            icon: const Icon(
              Icons.person_add,
              color: ColorConstants.goutMainColor,
            ),
          ),
        ],
      ),
    );
  }
}
