import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToastDialog({
  BuildContext? context,
  required String msg,
  int? duration,
  Color? textColor,
  Color? backGroundColor,
  Toast? toastLength,
  ToastGravity? toastGravity,
}) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: toastLength ?? Toast.LENGTH_LONG,
    gravity: toastGravity ?? ToastGravity.BOTTOM,
    textColor: textColor ?? Colors.black,
    backgroundColor: backGroundColor ?? Colors.grey[200],
    timeInSecForIosWeb: duration ?? 3,
  );
}
