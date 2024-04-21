import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../shared/constants/app_color/app_color.dart';


Widget customLoader() {
  return const SpinKitDualRing(
    size: 50.0,
    color: AppColors.goldenYellowColor,
    lineWidth: 5,
  );
}
