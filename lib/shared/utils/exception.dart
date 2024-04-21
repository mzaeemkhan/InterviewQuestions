import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../widgets/custom_text.dart';
import '../constants/app_color/app_color.dart';
import '../constants/app_font_family/app_fontfamily.dart';

void showException({required String status,required String exception}) {
  Get.snackbar(
    '',
    '',
    duration: (const Duration(seconds: 3)),
    snackPosition: SnackPosition.BOTTOM,
    colorText: AppColors.secondaryColor,
    backgroundColor: AppColors.secondaryColor.withOpacity(0.6),
    margin: EdgeInsets.only(bottom: 30),
    maxWidth: Get.width * 0.8,
    titleText: customCenterText(
        text: status, size: 25, color: AppColors.redColor, fontWeight: FontWeight.normal, fontFamily: AppFontFamily.dancingScript),
    messageText: customCenterText(
        text: exception, size: 15, color: AppColors.primaryColor, fontWeight: FontWeight.bold, fontFamily: AppFontFamily.poppins),
  );
}