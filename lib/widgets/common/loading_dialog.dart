import 'package:flutter/material.dart';
import 'package:ndialog/ndialog.dart';

CustomProgressDialog loadingDialog({
  required BuildContext context,
}) {
  final CustomProgressDialog progressDialog =
      CustomProgressDialog(context, blur: 10);

  ///You can set Loading Widget using this function
  progressDialog.setLoadingWidget(const CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(Colors.red)));

  return progressDialog;
}

CustomProgressDialog loadingPleaseWaitDialog({
  required BuildContext context,
}) {
  final CustomProgressDialog progressDialog = CustomProgressDialog(
    context,
    blur: 10,
    dismissable: false,
  );

  ///You can set Loading Widget using this function
  progressDialog.setLoadingWidget(const Card(
    child: Row(
      children: [
        Padding(
          padding: EdgeInsets.all(18.0),
          child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.black)),
        ),
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Please wait....'),
        ),
      ],
    ),
  ));

  return progressDialog;
}
