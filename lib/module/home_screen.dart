import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:interview_tutor/widgets/custom_icon.dart';
import 'package:interview_tutor/widgets/custom_loader.dart';
import '../controller/data_controller.dart';
import '../shared/constants/app_color/app_color.dart';
import '../shared/constants/app_font_family/app_fontfamily.dart';
import '../shared/constants/string_assets/string_assets.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/custom_image.dart';
import '../widgets/custom_text.dart';
import 'category_intro_screen.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late DataController dataController;
  final GlobalKey<ScaffoldState> globalKey = GlobalKey();
  bool isData = true;

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
        builder: (_) => Scaffold(
      key: globalKey,
      backgroundColor: AppColors.secondaryColor,
      appBar: AppBar(
        title: customText(text: StringAssets.appTitle, color: AppColors.primaryColor, fontWeight: FontWeight.bold, size: 16, fontFamily: AppFontFamily.poppins),
    centerTitle: true,
        backgroundColor: AppColors.secondaryColor,
        elevation: 2,
        leading: InkWell(
          overlayColor:  MaterialStateProperty.all(AppColors.transparentColor),
            onTap: () {
            globalKey.currentState!.openDrawer();
            },
            child: customIcon(iconData: Icons.menu, size: 20, color: AppColors.primaryColor)),
      ),
        drawer: customDrawer(dataController: dataController,globalKey: globalKey),
        body:
        RefreshIndicator(
          onRefresh: () async{
         await  dataController.readJsonData();
          },
          child:
              !dataController.isLoading ?
              dataController.devDataModel.category.isNotEmpty ?
          SingleChildScrollView(
            child: AnimationLimiter(
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: dataController.devDataModel.category.length,
                  itemBuilder: (BuildContext context ,int categoryIndex) {
                    return     AnimationConfiguration.staggeredList(
                      position: categoryIndex,
                      duration: const Duration(seconds: 1),
                      child: FlipAnimation(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            color: AppColors.primaryColor,
                            elevation: 5,
                            borderOnForeground: true,
                            shadowColor: AppColors.primaryColor.withOpacity(0.3),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                customHeadingText(text: dataController.devDataModel.category[categoryIndex].categoryName, color: AppColors.arsenicColor, fontWeight: FontWeight.bold, size: 16, fontFamily: AppFontFamily.poppins),
                                SizedBox(
                                  height: Get.height * 0.27,
                                  child: ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    itemCount:  dataController.devDataModel.category[categoryIndex].subCategory.length,
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemBuilder: (BuildContext context,int subCategoryIndex) {
                                      return   InkWell(
                                        overlayColor: MaterialStateProperty.all(AppColors.transparentColor),
                                        onTap: () {
                                          dataController.selectCategory(selected: dataController.devDataModel.category[categoryIndex].subCategory,index:subCategoryIndex );
                                          if(dataController.selectedCategory.isNotEmpty){
                                            Get.to(() => CategoryIntroScreen());
                                          }
                                        },
                                        child:
                                        Container(
                                          width: Get.width * 0.35,
                                          margin:   const EdgeInsets.all(5),
                                          decoration:  BoxDecoration(
                                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                                              border: Border.all(color: AppColors.goldenYellowColor),
                                              gradient: LinearGradient(
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomCenter,
                                                  colors: [
                                                    AppColors.blackColor.withOpacity(0.2),
                                                    AppColors.primaryColor.withOpacity(0.4),
                                                    AppColors.primaryColor.withOpacity(0.6),
                                                    AppColors.blackGreenColor.withOpacity(0.8),
                                                  ],
                                                  stops: const [
                                                    0.1,
                                                    0.3,
                                                    0.9,
                                                    1.0
                                                  ])),
                                          child: Center(
                                            child:  Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Expanded(child: Center(child: customHeadingText(text:  dataController.devDataModel.category[categoryIndex].subCategory[subCategoryIndex].subCategoryName, color: AppColors.mauveBlackColor, fontWeight: FontWeight.bold, size: 14, fontFamily: AppFontFamily.poppins))),
                                                  Expanded(child: customImage(image:   dataController.devDataModel.category[categoryIndex]. subCategory[subCategoryIndex].icon.isNotEmpty ?  dataController.devDataModel.category[categoryIndex]. subCategory[subCategoryIndex].icon :"assets/logo/logo.png" , height: Get.width * 0.18, width: Get.width * 0.18)),
                                               Expanded(
                                                 child: Center(
                                                   child: customRichText(text1: "Questions  ",color1: AppColors.redColor,fontWeight1:FontWeight.bold ,size1:16 ,fontFamily1:AppFontFamily.dancingScript ,
                                                            text2: "${dataController.devDataModel.category[categoryIndex].subCategory[subCategoryIndex].juniorLevel.length+dataController.devDataModel.category[categoryIndex].subCategory[subCategoryIndex].middleLevel.length+dataController.devDataModel.category[categoryIndex].subCategory[subCategoryIndex].seniorLevel.length}",color2:AppColors.arsenicColor ,fontWeight2:FontWeight.bold ,size2:16 ,fontFamily2:AppFontFamily.dancingScript ),
                                                 ),
                                               ),
                                                ],
                                              ),

                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ) ;
                  }
              ),
            ),
          ):Center(
                child: customCenterText(text: "No Data Available", color: AppColors.primaryColor, fontWeight: FontWeight.bold, size: 30, fontFamily: AppFontFamily.dancingScript),
              ) : customLoader(),
        ) ));
  }
}