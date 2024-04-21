import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:interview_tutor/module/privacy_policy/privacy_policy_screen.dart';
import 'package:interview_tutor/widgets/custom_image.dart';
import '../shared/constants/app_color/app_color.dart';
import '../shared/constants/app_font_family/app_fontfamily.dart';
import '../shared/constants/assets_path/image_path.dart';
import '../shared/constants/assets_path/logo_path.dart';
import '../shared/shared_preferences/my_shared_preference.dart';
import '../widgets/custom_text.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isAgree = false;
  @override
  void initState() {
    checkIsAgree();
    Future.delayed(const Duration(seconds: 3), () {
      if(isAgree) {
        Get.off(() => const HomeScreen());
      }
      else {
        Get.off(() => const PrivacyPolicyScreen());
      }
    });
    super.initState();
  }

  Future checkIsAgree() async {
    bool data= await  SharedPreferencesServices().getBoolValue("agree");
    if(data){
      setState(()  {
        isAgree = data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.primaryColor,
        body:  Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(ImagePath.background),
                  fit: BoxFit.fill,
                )),
            child: Center(
              child: AnimationLimiter(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: AnimationConfiguration.toStaggeredList(
                    duration: const Duration(seconds: 2),
                    childAnimationBuilder: (widget) => SlideAnimation(
                      horizontalOffset: 50.0,
                      verticalOffset: -10.0,
                      child: ScaleAnimation(
                        child: widget,
                      ),
                    ),
                    children: [
                      Padding(
                          padding: EdgeInsets.only(top: Get.height * 0.25),
                          child: Column(
                            children: [
                              customCenterText(text: "Interview Tutor", color: AppColors.goldenYellowColor, fontWeight: FontWeight.bold, size: 30, fontFamily: AppFontFamily.dancingScript),
                              customImage(image: LogoPath.appLogo, height: Get.height * 0.4, width: Get.width * 0.7),
                            ],
                          )),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          customImage(image: LogoPath.atruleLogo, height: 70, width: 60),
                          customText(
                              text: "POWERED BY ATRULE TECHNOLOGIES",
                              size: 15,
                              color: AppColors.atruleLogoColor,
                              fontWeight: FontWeight.normal,
                              fontFamily: AppFontFamily.poppins),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
  }
}
