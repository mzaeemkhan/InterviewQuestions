import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:interview_tutor/widgets/custom_icon.dart';
import 'package:interview_tutor/widgets/custom_text.dart';

import '../controller/data_controller.dart';
import '../shared/constants/app_color/app_color.dart';
import '../shared/constants/app_font_family/app_fontfamily.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({Key? key}) : super(key: key);

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
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
       title: customHeadingText(text: dataController.selectedCategory[dataController.selectedCategoryIndex].subCategoryName.trim(), color: AppColors.primaryColor, fontWeight: FontWeight.normal, size: 16, fontFamily: AppFontFamily.mochiyPopOne),
        centerTitle: true,
        elevation: 0,
      ),
      body:
      AnimationLimiter(
          child: ListView.builder(
                 shrinkWrap: true,
                 itemCount: dataController.questionsList.length,
              itemBuilder: (BuildContext context , int index) {
                return  AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 500),
                  child: ScaleAnimation(
                    child: ExpansionTile(
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
                          child: customJustifyText(text:  dataController.questionsList[index].q.trim(), color: AppColors.leopardBlackColor, fontWeight: FontWeight.bold, size: 14, fontFamily: AppFontFamily.poppins)),
                      children: <Widget>[
                        ListTile(
                          leading: customText(text: "Ans", color: AppColors.secondaryColor, fontWeight: FontWeight.bold, size: 20, fontFamily: AppFontFamily.dancingScript),
                          title:  customJustifyText(text: dataController.questionsList[index].a.trim(), color: AppColors.mauveBlackColor, fontWeight: FontWeight.normal, size: 14, fontFamily: AppFontFamily.poppins),
                          trailing:
                           dataController.checkBookMarked(q: dataController.questionsList[index].q.trim()) ?
                              InkWell(
                                  overlayColor: MaterialStateProperty.all(AppColors.transparentColor),
                                  onTap: () {
                                    dataController.removeFromBookMark(q:dataController.questionsList[index].q.trim()  );
                                  },
                                  child: customIcon(iconData: Icons.book, size: 20, color: AppColors.goldenYellowColor)):
                          InkWell(
                            overlayColor: MaterialStateProperty.all(AppColors.transparentColor),
                              onTap: () {
                                dataController.addToBookMark(q:dataController.questionsList[index].q.trim() , a:dataController.questionsList[index].a.trim() );
                              },
                              child: customIcon(iconData: Icons.bookmark_add_outlined, size: 20, color: AppColors.goldenYellowColor))
                        ),
                      ],
                    ),
                  ),
                );
          }),
        ),
    ) );
  }
}
