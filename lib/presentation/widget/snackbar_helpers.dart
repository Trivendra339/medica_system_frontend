import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helper/colors.dart';

class TAppSnackBarHelpers {
  static void hideSnackBar()=> ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar();
  static void successSnackBar({required title, message = '',duration = 3}){
    Get.snackbar(
      title,
      message,
      maxWidth: 600,
      margin: const EdgeInsets.all(18),
      isDismissible: true,
      shouldIconPulse: true,
      colorText: Colors.white,
      backgroundColor: TAppColors.primaryColor,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: duration),
      icon: const Icon(Icons.check, color: TAppColors.whiteColor,)
    );
  }

  static void warningSnackBar({required title, message = ''}){
    Get.snackbar(
        title,
        message,
        maxWidth: 600,
        margin: const EdgeInsets.all(20),
        isDismissible: true,
        shouldIconPulse: true,
        colorText: Colors.white,
        backgroundColor: TAppColors.primaryColor,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
        icon: const Icon(Icons.warning, color: TAppColors.whiteColor,)
    );
  }

  static void errorSnackBar({required title, message = ''}){
    Get.snackbar(
        title,
        message,
        maxWidth: 600,
        isDismissible: true,
        shouldIconPulse: true,
        margin: const EdgeInsets.all(20),
        colorText: Colors.white,
        backgroundColor: Colors.red.shade600,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
        icon: const Icon(Icons.error, color: TAppColors.whiteColor,)
    );
  }

}