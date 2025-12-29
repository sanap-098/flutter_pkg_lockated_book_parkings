import 'package:flutter/material.dart';

class DottedDividerWidget extends StatelessWidget {
  final double width;
  final double height;
  final Color color;

  const DottedDividerWidget(
      {super.key,
      required this.width,
      required this.height,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final boxWidth = constraints.constrainWidth();
      final dashWidth = width;
      final dashHeight = height;
      final dashCount = (boxWidth / (2 * dashWidth)).floor();
      return Flex(
          direction: Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }));
    });
  }
}
