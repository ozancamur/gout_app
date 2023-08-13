import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gout_app/core/constant/color_constants.dart';
import 'package:gout_app/core/widgets/bottomNavigatorBar/gout_bottom.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorConstants.black,
      bottomSheet: goutBottomAppBar(pageId: 3,),
      body: Column(
        children: [
          _userCard()
          ],
      ),
    );
  }

  Widget _userCard() {
    return Container(
      height: Get.height * .37,
      width: Get.width,
      decoration: const BoxDecoration(
        color: ColorConstants.backgrounColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: Get.height * .075),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * .05),
                  child: Container(
                    height: Get.height * .15,
                    width: Get.width * .3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: ColorConstants.backgrounColor),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        "assets/images/me.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: Get.height * .06),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Ozan Camur",
                        style: TextStyle(
                          color: ColorConstants.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "@ozancamur",
                        style: TextStyle(
                          color: ColorConstants.grey,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: Get.height*.02
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text("84", style: TextStyle(color: ColorConstants.white),),
                      Text("Posts", style: TextStyle(color: ColorConstants.white),),
                    ],
                  ),
              Column(
                children: [
                  Text("1.5M", style: TextStyle(color: ColorConstants.white),),
                  Text("Followers", style: TextStyle(color: ColorConstants.white),),
                ],
              ),
              Column(
                children: [
                  Text("257", style: TextStyle(color: ColorConstants.white),),
                  Text("Following", style: TextStyle(color: ColorConstants.white),),
                ],
              )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
