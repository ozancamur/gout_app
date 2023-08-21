import 'package:get/get.dart';
import 'package:gout_app/core/constant/color/color_constants.dart';

SnackbarController errorSnackbar(String title, String message) {
  return Get.snackbar(
    title,
    message,
    colorText: ColorConstants.white,
    backgroundColor: ColorConstants.red,
  );
}
