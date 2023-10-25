// ignore_for_file: camel_case_types, must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gout_app/core/constant/color/color_constants.dart';
import 'package:gout_app/view/create/view/create_view.dart';
import 'package:gout_app/view/home/view/home_view.dart';
import 'package:gout_app/view/proile/view/profile_view.dart';
import 'package:gout_app/view/search/view/search_view.dart';
import 'package:gout_app/view/settings/view/settings_view.dart';

class goutBottomAppBar extends StatelessWidget {
  goutBottomAppBar({super.key, required this.pageId});
  final box = GetStorage();

  int pageId;

// ! ICONS
// * HOME ICON
  Icon home = const Icon(
    Icons.home_outlined,
    color: ColorConstants.grey,
    size: 25,
  );
// * SEARCH ICON
  Icon search = const Icon(
    Icons.search_outlined,
    color: ColorConstants.grey,
    size: 25,
  );
// * ADD ICON
  Icon add = const Icon(
    Icons.add_circle_outline,
    color: ColorConstants.grey,
    size: 25,
  );
// * PERSON ICON
  Icon person = const Icon(
    Icons.person_2_outlined,
    color: ColorConstants.grey,
    size: 25,
  );
// * SETTINGS ICON
  Icon settings = const Icon(
    Icons.settings_outlined,
    color: ColorConstants.grey,
    size: 25,
  );


  @override
  Widget build(BuildContext context) {
    //!   QUERIES
    // * HOME ICON
    if (pageId == 0) {
      home = const Icon(
        Icons.home,
        color: ColorConstants.goutMainColor,
        size: 25,
      );
    }
    // * SEARCH ICON
    else if (pageId == 1) {
      search = const Icon(
        Icons.search,
        color: ColorConstants.goutMainColor,
        size: 27,
      );
    }
    // * ADD ICON
    else if (pageId == 2) {
      add = const Icon(
        Icons.add_circle,
        color: ColorConstants.goutMainColor,
        size: 25,
      );
    }
    // * PERSON ICON
    else if (pageId == 3) {
      person = const Icon(
        Icons.person_2,
        color: ColorConstants.goutMainColor,
        size: 25,
      );
    }
    // * SETTINGS ICON
    else if (pageId == 4) {
      settings = const Icon(
        Icons.settings,
        color: ColorConstants.goutMainColor,
        size: 25,
      );
    } else {
      return const SizedBox();
    }

    return BottomAppBar(
        padding: EdgeInsets.zero,
        color: ColorConstants.backgrounColor,
        height: Get.height * .075,
        child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // ! WIDGETS
              // * HOME ICON
              IconButton(
                onPressed: () {
                  Get.off(()=>HomeView());
                },
                icon: home,
              ),
              // * SEARCH ICON
              IconButton(
                onPressed: () {
                  Get.off(()=>SearchView());
                },
                icon: search,
              ),
              // * ADD ICON
              IconButton(
                onPressed: () {
                  Get.to(() => CreateView());
                },
                icon: add,
              ),
              // * PROFILE ICON
              IconButton(
                onPressed: () {
                  Get.off(() => ProfileView());
                },
                icon: person,
              ),
              // * SETTINGS ICON
              IconButton(
                  onPressed: () {
                    Get.off(() => SettingsView());
                  },
                  icon: settings),
            ]));
  }
}
