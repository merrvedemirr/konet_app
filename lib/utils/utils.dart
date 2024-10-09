import 'package:flutter/material.dart';
import 'package:konet_app/constantsVariable/constance_variable.dart';

TextStyle? textStyle(BuildContext context) => Theme.of(context).textTheme.headlineSmall;
ButtonStyle buttonStyle(double vertical, double horizontal) {
  return ElevatedButton.styleFrom(
      backgroundColor: ConstanceVariable.buttonColor,
      padding: EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)));
}
