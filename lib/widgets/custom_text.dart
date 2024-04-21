
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:interview_tutor/shared/constants/string_assets/string_extention.dart';

Widget customText({required String text, required Color color, required FontWeight fontWeight, required double size, required String  fontFamily}) {
  return Text(
    text,
    style: TextStyle(
        color: color,
        fontSize: size.sp,
        fontWeight: fontWeight,
        fontFamily: fontFamily),
  );
}
Widget customRichText({required String text1, required double size1, required Color color1, required FontWeight fontWeight1, required String fontFamily1,
      required String text2,
      required double size2,
      required Color color2,
      required FontWeight fontWeight2,
      required String fontFamily2}) {
  return RichText(
    text: TextSpan(
      children: <TextSpan>[
        TextSpan(
          text: text1,
          style: TextStyle(fontSize: size1.sp, color: color1, fontWeight: fontWeight1, fontFamily: fontFamily1),
        ),
        TextSpan(
          text: text2,
          style: TextStyle(fontSize: size2.sp, color: color2, fontWeight: fontWeight2, fontFamily: fontFamily2),
        ),
      ],
    ),
  );
}
Widget customHeadingText({required String text, required Color color, required FontWeight fontWeight, required double size, required String  fontFamily}) {
  return Text(
    text.inCaps,
    maxLines: 2,
    softWrap: false,
    overflow: TextOverflow.ellipsis,
    textAlign: TextAlign.center,
    style: TextStyle(
        color: color,
        fontSize: size.sp,
        fontWeight: fontWeight,
        fontFamily: fontFamily),
  );
}
Widget customCenterText({required String text, required Color color, required FontWeight fontWeight, required double size, required String  fontFamily}) {
  return Text(
    text.inCaps,
    textAlign: TextAlign.center,
    style: TextStyle(
        color: color,
        fontSize: size.sp,
        fontWeight: fontWeight,
        fontFamily: fontFamily),
  );
}
Widget customJustifyText({required String text, required Color color, required FontWeight fontWeight, required double size, required String  fontFamily}) {
  return Text(
    text.inCaps,
    textAlign: TextAlign.justify,
    style: TextStyle(
        color: color,
        fontSize: size.sp,
        fontWeight: fontWeight,
        fontFamily: fontFamily),
  );
}
Widget customUnderlineText({required String text, required Color color, required FontWeight fontWeight, required double size, required String  fontFamily}) {
  return Text(
    text.inCaps,
    textAlign: TextAlign.justify,
    style: TextStyle(
        color: color,
        fontSize: size.sp,
        fontWeight: fontWeight,
        fontFamily: fontFamily,
      decoration: TextDecoration.underline,
    ),
  );
}