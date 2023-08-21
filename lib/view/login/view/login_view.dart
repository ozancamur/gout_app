// ignore_for_file: camel_case_types, must_be_immutable
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gout_app/core/constant/color/color_constants.dart';
import 'package:gout_app/core/widgets/appbar/gout_appbar.dart';
import 'package:gout_app/core/constant/string/string_constants.dart';
import 'package:gout_app/view/login/viewmodel/login_view_model.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final controller = Get.put(LoginViewModel());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginViewModel>(
      init: LoginViewModel(),
      initState: (_) {},
      builder: (controller) {
        return SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: ColorConstants.black,
            appBar: goutAppBar(StringConstants.logIn),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * .05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _textField(),
                  _logInOptions(),
                  _mailField(),
                  _passwordField(),
                  _buttonField(),
                  _signUpField()
                ],
              ),
            ),
          ),
        );
      },
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
      padding: EdgeInsets.symmetric(vertical: Get.height * .015),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 70,
            width: 170,
            decoration: BoxDecoration(
                color: ColorConstants.backgrounColor,
                borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: Get.height * .025),
              child: InkWell(
                onTap: () {
                  //GOOGLE
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
                color: ColorConstants.backgrounColor,
                borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: Get.height * .022),
              child: InkWell(
                onTap: () {
                  //APPLE
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
      padding: EdgeInsets.only(top: Get.height * .05),
      child: TextField(
        controller: controller.tecMail,
        cursorColor: ColorConstants.white,
        keyboardType: TextInputType.emailAddress,
        strutStyle: const StrutStyle(fontSize: 15),
        style: const TextStyle(color: ColorConstants.white),
        decoration: InputDecoration(
          hintText: "Enter your mail",
          hintStyle: const TextStyle(color: ColorConstants.grey),
          filled: true,
          fillColor: ColorConstants.backgrounColor,
          labelText: "Email*",
          labelStyle: const TextStyle(color: ColorConstants.white),
          border: OutlineInputBorder(
              borderSide:
                  const BorderSide(width: 1.5, color: ColorConstants.grey),
              borderRadius: BorderRadius.circular(20)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 1.5,
                color: ColorConstants.goutMainColor,
              ),
              borderRadius: BorderRadius.circular(20)),
        ),
      ),
    );
  }

  Widget _passwordField() {
    return Padding(
      padding: EdgeInsets.only(top: Get.height * .03),
      child: Obx(() => TextField(
        controller: controller.tecPassword,
        cursorColor: ColorConstants.white,
        keyboardType: TextInputType.text,
        strutStyle: const StrutStyle(fontSize: 15),
        style: const TextStyle(color: ColorConstants.white),
        decoration: InputDecoration(
          hintText: "Enter your password",
          hintStyle: const TextStyle(color: ColorConstants.grey),
          filled: true,
          fillColor: ColorConstants.backgrounColor,
          labelText: "Password*",
          labelStyle: const TextStyle(color: ColorConstants.white),
          border: OutlineInputBorder(
            borderSide:
                const BorderSide(width: 1.5, color: ColorConstants.grey),
            borderRadius: BorderRadius.circular(20),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 1.5,
              color: ColorConstants.goutMainColor,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              width: 1.5,
              color: ColorConstants.red,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          suffixIcon: IconButton(
            onPressed: () {
             controller.passwordVisible.value = !controller.passwordVisible.value;
            }, 
            icon: controller.passwordVisible.value
            ? const Icon(Icons.visibility, size: 20, color: ColorConstants.grey,)
            : const Icon(Icons.visibility_off, size: 20, color: ColorConstants.grey),
            ),
        ),
        obscureText: !controller.passwordVisible.value,
      ),
    ),
    );
  }

  Widget _buttonField() {
    return Padding(
      padding:
          EdgeInsets.only(top: Get.height * .05, bottom: Get.height * .025),
      child: InkWell(
        onTap: () {
          controller.login(controller.tecMail.text.trim(),
              controller.tecPassword.text.trim());
        },
        child: Container(
          width: Get.width,
          height: Get.height * .075,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(colors: [
                ColorConstants.goutSecondColor,
                ColorConstants.goutMainColor,
                ColorConstants.goutThirdColor
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
            controller.goToRegisterView();
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
