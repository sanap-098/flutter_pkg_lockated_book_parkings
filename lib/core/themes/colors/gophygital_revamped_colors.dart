import 'package:flutter/material.dart';
import 'package:flutter_pkg_lockated_book_parking/core/themes/colors/company_colors.dart';

class GoPhygitalRevampedColors extends CompanyColors {
  @override
  Color get primaryColor => const Color(0xFFE95420);

  @override
  Color get secondaryColor => const Color(0xFF77216F);

  @override
  Color get cardLinearGradientEndColor => const Color(0xFFE95420);

  @override
  Color get cardLinearGradientStartColor => const Color(0xFF77216F);

  @override
  Color get iconColor => const Color(0xFF262626);

  @override
  Color get fitnessDialogButtonColor => const Color(0xFFFFC600);

  @override
  Color get dividerColor => const Color(0xFFDDDDDD);

  @override
  Color get carouselIndicatorSelectedColor => const Color(0xFFFFC600);

  @override
  Color get carouselIndicatorUnSelectedColor => const Color(0xFFFFFFFF);

  @override
  Color get carouselIndicatorBorderSelectedColor => Colors.grey;

  @override
  Color get carouselIndicatorBorderUnSelectedColor => const Color(0xFFFFC600);

  @override
  Color get carouselSeekBarProgressColor => Colors.transparent;

  @override
  Color get carouselSeekBarTrackColor => const Color(0xFFE6E6E6);

  @override
  Color get statsCardEndDateBgColor => Colors.red;

  @override
  Color get statsCardStartDateBgColor => Colors.green;

  @override
  Color get calendarSelectedDateColor => const Color(0xFF77216F);

  @override
  Color get statsCardBgColor => const Color(0xFFEFEFEF);

  @override
  Color get bookingsBookableStatusColor => const Color(0xFFEF7175);

  @override
  Color get bookingsRequestStatusColor => const Color(0xFFEF7175);

  @override
  Color get bookingsCancelledStatusColor => const Color(0xFFe2445b);

  @override
  Color get bookingsConfirmedStatusColor => const Color(0xFF01c875);

  @override
  Color get bookingsPendingStatusColor => const Color(0xFFfdab3d);

  @override
  Color get dialogSuccessContainerBgColor => const Color(0xFF01C875);

  @override
  Color get timeSlotSelectedColor => const Color(0xFFE95420);

  @override
  Color get timeSlotUnSelectedColor => const Color(0xFFF3F3F3);

  @override
  Color get fabColor => primaryColor;

  @override
  Color get visitorsApprovedStatusColor => const Color(0xFF01c875);

  @override
  Color get visitorsPendingStatusColor => const Color(0xFFfdab3d);

  @override
  Color get visitorsRejectedStatusColor => const Color(0xFFe2445b);

  @override
  Color get visitorDetailsInCardBgColor => const Color(0xFFF6EFF4);

  @override
  Color get visitorDetailsInCardTextColor => const Color(0xFF77216F);

  @override
  Color get visitorDetailsOutCardBgColor => const Color(0xFFFCEFEB);

  @override
  Color get visitorDetailsOutCardTextColor => primaryColor;
}
