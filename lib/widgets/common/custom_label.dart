import 'package:clippy_flutter/label.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CustomLabel extends StatelessWidget {
  final String text;
  final Color? textColor;
  final double? labelHeight;
  final String? containerColor;
  final EdgeInsetsGeometry? containerPadding;
  final EdgeInsetsGeometry? textPAdding;

  const CustomLabel(
      {Key? key,
      required this.text,
      this.textColor,
      this.labelHeight,
      this.containerColor,
      this.containerPadding,
      this.textPAdding})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Label(
      triangleHeight: labelHeight ?? 18.0,
      edge: Edge.LEFT,
      child: Container(
        decoration: BoxDecoration(
          // borderRadius:
          //     BorderRadius.only(topRight: Radius.circular(12)),
          color: HexColor(containerColor ?? '#FFF3C5'),
        ),
        padding: containerPadding ??
            const EdgeInsets.only(
                left: 8.0, right: 18.0, top: 4.0, bottom: 4.0),
        child: Padding(
          padding: textPAdding ?? const EdgeInsets.fromLTRB(50, 0, 40, 0),
          child: Text(
            text,
            style: TextStyle(
              color: textColor ?? Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
