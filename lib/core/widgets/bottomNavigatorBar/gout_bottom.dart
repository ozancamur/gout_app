import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gout_app/core/constant/color_constants.dart';
import 'package:gout_app/view/home/view/home_view.dart';
import 'package:gout_app/view/proile/view/profile_view.dart';

class goutBottomAppBar extends StatefulWidget {
  goutBottomAppBar({
    required this.pageId,
    super.key,
  });

  int pageId;

  @override
  State<goutBottomAppBar> createState() => _goutBottomAppBarState();
}

class _goutBottomAppBarState extends State<goutBottomAppBar> {
  Icon home = Icon(
    Icons.home_outlined,
    color: ColorConstants.grey,
    size: 25,
  );

  Icon search = Icon(
    Icons.search_outlined,
    color: ColorConstants.grey,
    size: 25,
  );

  Icon add = Icon(
    Icons.add_circle_outline,
    color: ColorConstants.grey,
    size: 25,
  );

  Icon person = Icon(
    Icons.person_2_outlined,
    color: ColorConstants.grey,
    size: 25,
  );

  Icon settings = Icon(
    Icons.settings_outlined,
    color: ColorConstants.grey,
    size: 25,
  );

  @override
  Widget build(BuildContext context) {
    if (widget.pageId == 0) {
      Icon(
        Icons.home,
        color: ColorConstants.goutBlue,
        size: 25,
      );
    } else if ( widget.pageId == 1 ) {

    } else if ( widget.pageId == 2 ) {
      
    } else if ( widget.pageId == 3 ) {
      
    } else if ( widget.pageId == 4 ) {
      
    }

    return BottomAppBar(
        padding: EdgeInsets.zero,
        color: ColorConstants.backgrounColor,
        height: Get.height * .075,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {
                Get.to(HomeView());
              },
              icon: home,
            ),
            IconButton(
              onPressed: () {},
              icon: search,
            ),
            IconButton(
              onPressed: () {},
              icon: add,
            ),
            IconButton(
              onPressed: () {
                Get.to(ProfileView());
              },
              icon: person,
            ),
            IconButton(onPressed: () {}, icon: settings),
          ],
        ));
  }
}
