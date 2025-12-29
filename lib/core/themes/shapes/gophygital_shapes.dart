import 'package:flutter/material.dart';
import 'package:flutter_pkg_lockated_book_parking/core/themes/shapes/company_shapes.dart';

class GoPhygitalShapes extends CompanyShapes {
  @override
  ShapeBorder get dialogBorderShape =>
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(10));

  @override
  ShapeBorder get fitnessCardBorderShape =>
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(17));

  @override
  ShapeBorder get commonCardBorderShape =>
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(16));

  @override
  ShapeBorder get commonCardContainerBorderShape =>
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(10));

  @override
  BorderRadius get textFeildBorderRadius => BorderRadius.circular(20);
}
