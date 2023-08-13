import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gout_app/core/binding/bindings.dart';
import 'package:gout_app/core/initialize/app_initialize.dart';
import 'package:gout_app/view/home/view/home_view.dart';
import 'package:gout_app/view/login/view/login_view.dart';
import 'package:gout_app/view/proile/view/profile_view.dart';

import 'view/settings/view/settings_view.dart';

Future<void> main() async {
  await ApplicationStart.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialBinding: DataControllerBindings(),
        title: 'gOut App',
        theme: ThemeData(useMaterial3: true, fontFamily: "Poppins"),
        home: LoginView());
  }
}
