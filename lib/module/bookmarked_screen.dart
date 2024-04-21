import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interview_tutor/shared/constants/string_assets/string_assets.dart';

import '../controller/data_controller.dart';
import '../shared/constants/app_color/app_color.dart';
import '../shared/constants/app_font_family/app_fontfamily.dart';
import '../widgets/custom_icon.dart';
import '../widgets/custom_text.dart';

class BookMarkedScreen extends StatefulWidget {
  const BookMarkedScreen({Key? key}) : super(key: key);

  @override
  State<BookMarkedScreen> createState() => _BookMarkedScreenState();
}

class _BookMarkedScreenState extends State<BookMarkedScreen> {
  late DataController dataController;
  @override
  initState() {
    super.initState();
    try{
      dataController = Get.find();
    }
    catch (exception) {
      dataController = Get.put(DataController());
    }
  }
  @override
  Widget build(BuildContext context) {
    return  GetBuilder<DataController>(
        builder: (_) =>
            Scaffold(
                backgroundColor: AppColors.primaryColor,
                appBar: AppBar(
                  backgroundColor: AppColors.secondaryColor,
                  foregroundColor: AppColors.primaryColor,
                  title: customHeadingText(text: "Your ${StringAssets.bookMarkQuestion}", color: AppColors.primaryColor, fontWeight: FontWeight.bold, size: 16, fontFamily: AppFontFamily.mochiyPopOne),
                  centerTitle: true,
                  elevation: 0,
                ),
                body:
                dataController.bookMarkQuestionsList.isNotEmpty ?
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: dataController.bookMarkQuestionsList.length,
                    itemBuilder: (BuildContext context , int index) {
                      return  ExpansionTile(
                        leading: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              color: AppColors.secondaryColor,
                              borderRadius: BorderRadius.circular(5)
                          ),
                          child: Center(
                            child: customText(text: "${index+1}", color: AppColors.primaryColor, fontWeight: FontWeight.bold, size: 16, fontFamily: AppFontFamily.dancingScript),
                          ),
                        ),
                        title: Padding(padding: const EdgeInsets.all(3),
                            child: customJustifyText(text:  dataController.bookMarkQuestionsList[index].q.trim(), color: AppColors.leopardBlackColor, fontWeight: FontWeight.bold, size: 14, fontFamily: AppFontFamily.poppins)),
                        children: <Widget>[
                          ListTile(
                              leading: customText(text: "Ans", color: AppColors.secondaryColor, fontWeight: FontWeight.bold, size: 20, fontFamily: AppFontFamily.dancingScript),
                              title:  customJustifyText(text: dataController.bookMarkQuestionsList[index].a.trim(), color: AppColors.mauveBlackColor, fontWeight: FontWeight.normal, size: 14, fontFamily: AppFontFamily.poppins),
                              trailing:
                              InkWell(
                                  overlayColor: MaterialStateProperty.all(AppColors.transparentColor),
                                  onTap: () {
                                    dataController.removeFromBookMark(q:dataController.bookMarkQuestionsList[index].q.trim()  );
                                  },
                                  child: customIcon(iconData: Icons.book, size: 20, color: AppColors.goldenYellowColor))
                          ),
                        ],
                      );
                    }) : Center(
                  child: customCenterText(text: "No Question in bookMark", color: AppColors.goldenYellowColor, fontWeight: FontWeight.bold, size: 16, fontFamily: AppFontFamily.dancingScript),
                )
            ) );
  }
}
