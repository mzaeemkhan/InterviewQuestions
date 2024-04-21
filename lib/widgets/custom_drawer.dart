import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interview_tutor/shared/utils/externel_url.dart';
import '../controller/data_controller.dart';
import '../module/bookmarked_screen.dart';
import '../shared/constants/app_color/app_color.dart';
import '../shared/constants/app_font_family/app_fontfamily.dart';
import '../shared/constants/string_assets/string_assets.dart';
import 'custom_icon.dart';
import 'custom_image.dart';
import 'custom_text.dart';

Widget customDrawer({required DataController dataController,required GlobalKey<ScaffoldState> globalKey}) {
  return Drawer(
    child: ListView(
      padding: const EdgeInsets.all(0),
      children: [
        DrawerHeader(
          decoration: const BoxDecoration(
            color: AppColors.secondaryColor,
          ),
          child: Center(
            child: Column(
              children: [
                customImage(image: "assets/logo/logo.png",width: 80, height: 80),
                customText(text: StringAssets.appTitle, color: AppColors.primaryColor, fontWeight: FontWeight.bold, size: 20, fontFamily: AppFontFamily.poppins),
              ],
            ),
          ),
        ),
        ListTile(
          leading: customIcon(iconData: Icons.bookmark, size: 30, color: AppColors.indigoBlackColor),
          title: customText(text: StringAssets.bookMarkQuestion, color: AppColors.leopardBlackColor, fontWeight: FontWeight.bold, size: 15, fontFamily: AppFontFamily.poppins),
          onTap: () {
            globalKey.currentState!.closeDrawer();
            Get.to(() => const BookMarkedScreen());
          },
        ),
        ListTile(
          leading: customIcon(iconData: Icons.share, size: 30, color: AppColors.leopardBlackColor),
          title: customText(text: StringAssets.shareApp, color: AppColors.leopardBlackColor, fontWeight: FontWeight.bold, size: 15, fontFamily: AppFontFamily.poppins),
          onTap: () async {
             await dataController.shareApp();
            globalKey.currentState!.closeDrawer();
          },
        ),
        ListTile(
          leading: customIcon(iconData: Icons.home, size: 30, color: AppColors.atruleLogoColor),
          title: customText(text: StringAssets.moreApp, color: AppColors.leopardBlackColor, fontWeight: FontWeight.bold, size: 15, fontFamily: AppFontFamily.poppins),
          onTap: () async {
            await dataController.launchURL(url: ExternalUrls.moreApp);
            globalKey.currentState!.closeDrawer();
          },
        ),
        ListTile(
          leading: customIcon(iconData: Icons.group, size: 30, color: AppColors.mauveBlackColor),
          title: customText(text: StringAssets.aboutUs, color: AppColors.leopardBlackColor, fontWeight: FontWeight.bold, size: 15, fontFamily: AppFontFamily.poppins),
          onTap: () async {
             await dataController.launchURL(url: ExternalUrls.aboutUs);
            globalKey.currentState!.closeDrawer();
          },
        ),
      ],
    ),
  );
}