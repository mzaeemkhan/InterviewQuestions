import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interview_tutor/model/data_model.dart';
import 'package:interview_tutor/module/question_screen.dart';
import 'package:interview_tutor/widgets/custom_icon.dart';
import 'package:interview_tutor/widgets/custom_text.dart';

import '../controller/data_controller.dart';
import '../shared/constants/app_color/app_color.dart';
import '../shared/constants/app_font_family/app_fontfamily.dart';
import '../shared/constants/string_assets/string_assets.dart';

class CategoryIntroScreen extends StatefulWidget {
  const CategoryIntroScreen({Key? key}) : super(key: key);

  @override
  State<CategoryIntroScreen> createState() => _CategoryIntroScreenState();
}

class _CategoryIntroScreenState extends State<CategoryIntroScreen> {
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
    return
      GetBuilder<DataController>(
        builder: (_) =>  Scaffold(
          backgroundColor: AppColors.secondaryColor,
          body:  SafeArea(
            child:
            Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      overlayColor: MaterialStateProperty.all(AppColors.transparentColor),
                      onTap: () {
                        Get.back();
                      },
                      child: Padding(
                          padding: EdgeInsets.only(top: 20,left: 20),
                          child: customIcon(iconData: Icons.arrow_back, size: 25, color: AppColors.secondaryColor)),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      height: Get.height * 0.3,
                      decoration:  BoxDecoration(
                          image: DecorationImage(
                              image:AssetImage(
                                dataController.selectedCategory[dataController.selectedCategoryIndex].icon.isNotEmpty ? dataController.selectedCategory[dataController.selectedCategoryIndex].icon :"assets/logo/logo.png" ,
                              ),
                              fit: BoxFit.contain
                          )
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                            color: AppColors.secondaryColor,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30)
                            )
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              customHeadingText(text: dataController.selectedCategory[dataController.selectedCategoryIndex].subCategoryName.trim(), color: AppColors.arsenicColor, fontWeight: FontWeight.normal, size: 16, fontFamily: AppFontFamily.mochiyPopOne),
                              const SizedBox(height: 10,),
                              customJustifyText(text: dataController.selectedCategory[dataController.selectedCategoryIndex].introduction.trim(), color: AppColors.primaryColor, fontWeight: FontWeight.normal, size: 16, fontFamily: AppFontFamily.poppins),
                              const SizedBox(height: 10,),
                              Center(
                                child: InkWell(
                                  overlayColor: MaterialStateProperty.all(AppColors.transparentColor),
                                  onTap: () async {
                                    await dataController.setQuestionList(input: dataController.selectedCategory[dataController.selectedCategoryIndex].juniorLevel);
                                  if(dataController.questionsList.isNotEmpty){
                                    Get.to(() => const QuestionScreen());
                                  }
                                  },
                                  child: Container(
                                    height: 50,
                                    margin: const EdgeInsets.symmetric(vertical: 30,horizontal: 5,),
                                    decoration: BoxDecoration(
                                        color: AppColors.arsenicColor,
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Center(
                                      child: customText(text: StringAssets.learnQuestion, color: AppColors.goldenYellowColor, fontWeight: FontWeight.normal, size: 16, fontFamily: AppFontFamily.mochiyPopOne),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
          ),
        )
      );
  }
}
