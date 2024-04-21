import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../shared/constants/app_color/app_color.dart';


Widget customTextFormField({required TextEditingController controller, required String title}) {
  return TextFormField(
    inputFormatters: [
      FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z]+|\s"))
    ],
    controller: controller,
    decoration: InputDecoration(
        filled: true,
        hintText: title,
        focusColor: AppColors.primaryColor,
        fillColor: Colors.transparent,
        border: InputBorder.none
    ),
    keyboardType: TextInputType.name,
    validator: (value) {
      if (value == null) {
        return "Field can not be left empty";
      } else if (value.isEmpty) {
        return "Field can not be left empty";
      } else {
        return null;
      }
    },
  );
}