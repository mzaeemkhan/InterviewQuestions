import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interview_tutor/widgets/custom_text.dart';
import '../../shared/constants/app_color/app_color.dart';
import '../../shared/constants/app_font_family/app_fontfamily.dart';
import '../../shared/constants/assets_path/logo_path.dart';
import '../../shared/constants/string_assets/string_assets.dart';
import '../../shared/shared_preferences/my_shared_preference.dart';
import '../../shared/utils/exception.dart';
import '../../widgets/custom_image.dart';
import '../home_screen.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {

  bool isCheck = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10,),
              Center(child: customCenterText(text: "Terms and Services", size: 25, color: AppColors.blackColor, fontWeight: FontWeight.bold, fontFamily: AppFontFamily.poppins)),
              Center(child: customImage(image: LogoPath.appLogo, height: 250, width: Get.width * 0.5)),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 15),
                  child: customCenterText(text: StringAssets.privacyPolicy, size: 15, color: AppColors.blackColor, fontWeight: FontWeight.normal, fontFamily: AppFontFamily.poppins)),
              Checkbox(
                activeColor:AppColors.secondaryColor ,
                overlayColor:MaterialStateProperty.all(AppColors.transparentColor) ,
                value: isCheck,
                onChanged: (value) {
                  setState(() {
                    isCheck = value!;
                  });
                },
              ),
              Center(child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  customCenterText(text: "By Continuing you agree with", size: 15, color: AppColors.blackColor, fontWeight: FontWeight.bold, fontFamily: AppFontFamily.poppins),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      customUnderlineText(text: "Term And Condition", size: 10, color: AppColors.secondaryColor, fontWeight: FontWeight.bold, fontFamily: AppFontFamily.poppins),
                      customCenterText(text: " and  ", size: 10, color: AppColors.blackColor, fontWeight: FontWeight.bold, fontFamily: AppFontFamily.dancingScript),
                      customUnderlineText(text: "Privacy Policy", size: 10, color: AppColors.secondaryColor, fontWeight: FontWeight.bold, fontFamily: AppFontFamily.poppins),
                    ],
                  ),
                  const SizedBox(height: 5,),
                  InkWell(
                    overlayColor: MaterialStateProperty.all(AppColors.transparentColor),
                    onTap: () async {
                      if(isCheck) {
                        await  SharedPreferencesServices().savedBoolValue(value:isCheck , key: "agree");
                        Get.off(() => const HomeScreen());
                      }
                      else{
                        showException(status: "Accept",exception:"Term And Condition to Continue");
                      }
                    },
                    child: Container(
                      height: 40,
                      decoration: const BoxDecoration(
                        color: AppColors.secondaryColor,
                      ),
                      child: Center(
                        child:   customCenterText(text: " Accept And Continue", size: 15, color: AppColors.blackColor, fontWeight: FontWeight.bold, fontFamily: AppFontFamily.poppins),
                      ),
                    ),
                  )
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
