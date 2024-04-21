import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:interview_tutor/model/data_model.dart';
import 'package:interview_tutor/shared/shared_preferences/my_shared_preference.dart';
import 'package:interview_tutor/widgets/custom_text.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_extend/share_extend.dart';
import 'package:url_launcher/url_launcher.dart';

import '../shared/constants/app_color/app_color.dart';
import '../shared/constants/app_font_family/app_fontfamily.dart';
import '../shared/constants/assets_path/logo_path.dart';
import '../shared/constants/string_assets/string_assets.dart';
import '../shared/utils/externel_url.dart';

import 'package:flutter/material.dart';

class DataController extends GetxController {

  DevDataModel devDataModel = DevDataModel(category: []);
  late bool isLoading= true;
  int selectedCategoryIndex=0;
   List<JuniorLevel> questionsList = List<JuniorLevel>.empty(growable: true) ;
   List<JuniorLevel> bookMarkQuestionsList = List<JuniorLevel>.empty(growable: true) ;
   List<SubCategory> selectedCategory = List<SubCategory>.empty(growable: true) ;
  @override
  void onInit() {
    super.onInit();
    readJsonData();
  }

   Future readJsonData() async {
     isLoading = true;
     update();
    final String response = await rootBundle.loadString("json/dev_interview.json");
     devDataModel = DevDataModel.fromJson(json.decode(response));
    await getBookMarked();
     isLoading = false;
     update();
  }

 Future selectCategory({required List<SubCategory> selected,required int index}) async{
   selectedCategory.clear();
   selectedCategoryIndex = index;
   selectedCategory.addAll(selected);
   update();
 }

  Future setQuestionList({required List<JuniorLevel> input}) async{
    questionsList.clear();
    questionsList = List<JuniorLevel>.from(input);
    update();
  }

  //region bookMark
    Future addToBookMark({required String q, required String a}) async {
      bookMarkQuestionsList.add(JuniorLevel(q: q,a: a));
     await  SharedPreferencesServices().storeDataList(key: "bookMarkQuestionsList",data: bookMarkQuestionsList);
     update();
    }
    Future removeFromBookMark({required String q}) async {
    bookMarkQuestionsList.removeWhere((element) => element.q == q);
    await  SharedPreferencesServices().storeDataList(key: "bookMarkQuestionsList",data: bookMarkQuestionsList);
    update();
  }
    Future getBookMarked() async {
      var data =  await  SharedPreferencesServices().getDataList(key:"bookMarkQuestionsList");
      if (data != null) {
        bookMarkQuestionsList.clear();
        bookMarkQuestionsList = List<JuniorLevel>.from(jsonDecode(data).map((i) => JuniorLevel.fromJson(i))).toList();
      }
      update();
    }
    bool checkBookMarked({required String q})  {
    return bookMarkQuestionsList.any((element) => element.q == q);
    }

    //endregion

  Future launchURL({required String url}) async {
    try{
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication,);
    } catch (exception) {
      print("exception $exception");
    }
  }

  //region shareApp
  Future shareApp() async{
    PermissionStatus permissionStatus = await Permission.storage.request();
    if (permissionStatus == PermissionStatus.granted) {
      Directory documentDirectory = await getTemporaryDirectory();
      final ByteData bytes = await rootBundle.load(LogoPath.appLogo);
      final Uint8List image = bytes.buffer.asUint8List();
      File file = await File('${documentDirectory.path}/history.jpg').create();
      file.writeAsBytesSync(image);
      ShareExtend.share(
          file.path, StringAssets.appTitle, extraText: ExternalUrls.appLink);
    }
    else if (permissionStatus == PermissionStatus.permanentlyDenied ||
        permissionStatus == PermissionStatus.denied ||
        permissionStatus == PermissionStatus.restricted ||
        permissionStatus == PermissionStatus.limited) {
      Get.defaultDialog(
          barrierDismissible: false,
          title: "Alert Message",
          titleStyle: TextStyle(color: AppColors.secondaryColor, fontSize: 20, fontFamily: AppFontFamily.poppins, fontWeight: FontWeight.bold),
          middleText: "This feature requires storage permission and you have denied it. Press 'Open' to open the setting and allow permission!",
          middleTextStyle: TextStyle(
            color: AppColors.blackColor,
            fontSize: 15,
            fontFamily: AppFontFamily.poppins,
            fontWeight: FontWeight.bold,
          ),
          backgroundColor: AppColors.primaryColor,
          radius: 10,
          confirm: InkWell(
            overlayColor: MaterialStateProperty.all(AppColors.transparentColor),
            onTap: () async {
              Get.back();
              await openAppSettings();
            },
            child: Container(
              height: 30,
              width: 70,
              decoration: BoxDecoration(color: AppColors.atruleLogoColor, borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: customCenterText(
                    text: "Open", size: 15, color: AppColors.primaryColor, fontWeight: FontWeight.bold, fontFamily: AppFontFamily.poppins),
              ),
            ),
          ),
          cancel: InkWell(
            overlayColor: MaterialStateProperty.all(AppColors.transparentColor),
            onTap: () {
              Get.back();
            },
            child: Container(
              height: 30,
              width: 70,
              decoration: BoxDecoration(color: AppColors.goldenYellowColor, borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: customCenterText(
                    text: "Cancel", size: 15, color: AppColors.primaryColor, fontWeight: FontWeight.bold, fontFamily: AppFontFamily.poppins),
              ),
            ),
          ));
    } else {
      Get.defaultDialog(
          barrierDismissible: false,
          title: "Alert Message",
          titleStyle: TextStyle(color: AppColors.secondaryColor, fontSize: 20, fontFamily: AppFontFamily.poppins, fontWeight: FontWeight.bold),
          middleText: "Couldn't complete your request, please try again!",
          middleTextStyle: TextStyle(
            color: AppColors.blackColor,
            fontSize: 15,
            fontFamily: AppFontFamily.poppins,
            fontWeight: FontWeight.bold,
          ),
          backgroundColor: AppColors.primaryColor,
          radius: 10,
          cancel: InkWell(
            overlayColor: MaterialStateProperty.all(AppColors.transparentColor),
            onTap: () {
              Get.back();
            },
            child: Container(
              height: 30,
              width: 70,
              decoration: BoxDecoration(color: AppColors.secondaryColor, borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: customCenterText(
                    text: "OK", size: 15, color: AppColors.primaryColor, fontWeight: FontWeight.bold, fontFamily: AppFontFamily.poppins),
              ),
            ),
          ));
    }
  }
  //endregion

}