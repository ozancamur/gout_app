import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gout_app/core/binding/bindings.dart';
import 'package:gout_app/view/login/view/login_view.dart';

void main() {
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
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: "Rubik"
      ),
      home: LoginView()
    );
  }
}

