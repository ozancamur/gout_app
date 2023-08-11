// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gout_app/core/appbar/gout_appbar.dart';
import 'package:gout_app/core/constant/color_constants.dart';
import 'package:gout_app/core/constant/string_constants.dart';
import 'package:gout_app/view/login/controller/login_controller.dart';
import 'package:gout_app/view/login/view/register_view.dart';
import 'package:gout_app/view/login/viewmodel/login_view_model.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  LoginViewModel loginViewModel = LoginViewModel(LoginController());

  
  @override
  Widget build(BuildContext context) {
  
    return SafeArea(
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: goutAppBar(StringConstants.logIn),
          backgroundColor: ColorConstants.black,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * .06),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _textField(),
                _logInOptions(),
                _mailField(),
                _passwordField(),
                _buttonField(),
                _signUpField(),
              ],
            ),
          )),
    );
  }

  Widget _textField() {
    return Padding(
      padding: EdgeInsets.only(top: Get.height * .05, bottom: Get.height * .01),
      child: const Text(
        "Log in with one of the following.",
        style: TextStyle(
          color: ColorConstants.grey,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _logInOptions() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Get.height * .02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 70,
            width: 170,
            decoration: BoxDecoration(
                color: ColorConstants.buttonBackgrounColor,
                borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: Get.height * .025),
              child: InkWell(
                onTap: () {
                  print("GOOGLE INKWELL");
                },
                child: Image.asset(
                  "assets/icons/google.png",
                  width: 10,
                  height: 10,
                ),
              ),
            ),
          ),
          Container(
            height: 70,
            width: 170,
            decoration: BoxDecoration(
                color: ColorConstants.buttonBackgrounColor,
                borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: Get.height * .022),
              child: InkWell(
                onTap: () {
                  print("APPLE INKWELL");
                },
                child: Image.asset(
                  "assets/icons/apple.png",
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _mailField() {
    return Padding(
      padding: EdgeInsets.only(top: Get.height * .07),
      child: TextField(
        cursorColor: ColorConstants.white,
        keyboardType: TextInputType.emailAddress,
        strutStyle: const StrutStyle(fontSize: 15),
        style: const TextStyle(color: ColorConstants.white),
        decoration: InputDecoration(
          hintText: "Enter your mail",
          hintStyle: const TextStyle(color: ColorConstants.grey),
          filled: true,
          fillColor: ColorConstants.buttonBackgrounColor,
          labelText: "Email*",
          labelStyle: const TextStyle(color: ColorConstants.white),
          border: OutlineInputBorder(
              borderSide:
                  const BorderSide(width: 1.5, color: ColorConstants.grey),
              borderRadius: BorderRadius.circular(20)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 1.5,
                color: ColorConstants.textFieldBorderColor,
              ),
              borderRadius: BorderRadius.circular(20)),
        ),
      ),
    );
  }

  Widget _passwordField() {
    return Padding(
      padding: EdgeInsets.only(top: Get.height * .03),
      child: TextField(
        cursorColor: ColorConstants.white,
        keyboardType: TextInputType.visiblePassword,
        strutStyle: const StrutStyle(fontSize: 15),
        style: const TextStyle(color: ColorConstants.white),
        decoration: InputDecoration(
          hintText: "Enter your password",
          hintStyle: const TextStyle(color: ColorConstants.grey),
          filled: true,
          fillColor: ColorConstants.buttonBackgrounColor,
          labelText: "Password*",
          labelStyle: const TextStyle(color: ColorConstants.white),
          border: OutlineInputBorder(
              borderSide:
                  const BorderSide(width: 1.5, color: ColorConstants.grey),
              borderRadius: BorderRadius.circular(20)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 1.5,
                color: ColorConstants.textFieldBorderColor,
              ),
              borderRadius: BorderRadius.circular(20)),
          errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 1.5,
                color: ColorConstants.red,
              ),
              borderRadius: BorderRadius.circular(20)),
        ),
      ),
    );
  }

  Widget _buttonField() {
    return Padding(
      padding:
          EdgeInsets.only(top: Get.height * .05, bottom: Get.height * .025),
      child: InkWell(
        onTap: () => print("object"),
        child: Container(
          width: Get.width,
          height: Get.height * .075,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(colors: [
                ColorConstants.buttonFirstColor,
                ColorConstants.buttonSecondColor
              ], begin: Alignment.centerLeft, end: Alignment.centerRight)),
          child: const Center(
            child: Text(
              StringConstants.logIn,
              style: TextStyle(color: ColorConstants.white, fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }

  Widget _signUpField() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have an account?",
          style: TextStyle(color: ColorConstants.grey),
        ),
        TextButton(
          onPressed: () {
            Get.to(RegisterView());
          },
          child: const Text(
            "Sign up",
            style: TextStyle(color: ColorConstants.white),
          ),
        )
      ],
    );
  }
}
