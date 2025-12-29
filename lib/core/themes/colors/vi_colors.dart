import 'package:flutter/material.dart';
import 'package:flutter_pkg_lockated_book_parking/core/themes/colors/company_colors.dart';

class ViColors extends CompanyColors {
  @override
  Color get primaryColor => const Color(0xFFEC2B3E);

  @override
  Color get secondaryColor => const Color(0xFFFCD605);

  @override
  Color get cardLinearGradientEndColor => const Color(0xFFFCD605);

  @override
  Color get cardLinearGradientStartColor => const Color(0xFFEC2B3E);

  @override
  Color get iconColor => const Color(0xFF262626);

  @override
  Color get fitnessDialogButtonColor => const Color(0xFFFFC600);

  @override
  Color get dividerColor => const Color(0xFFDDDDDD);

  @override
  Color get carouselIndicatorSelectedColor => const Color(0xFFEC2B3E);

  @override
  Color get carouselIndicatorUnSelectedColor => const Color(0xFFFFFFFF);

  @override
  Color get carouselIndicatorBorderSelectedColor => Colors.grey;

  @override
  Color get carouselIndicatorBorderUnSelectedColor => const Color(0xFFEC2B3E);

  @override
  Color get carouselSeekBarProgressColor => const Color(0xFFEC2B3E);

  @override
  Color get carouselSeekBarTrackColor => const Color(0xFFE6E6E6);

  @override
  Color get statsCardEndDateBgColor => const Color(0xFFFCD605);

  @override
  Color get statsCardStartDateBgColor => const Color(0xFFEC2B3E);

  @override
  Color get calendarSelectedDateColor => const Color(0xFFEC2B3E);

  @override
  Color get statsCardBgColor => const Color(0xFFFCFAFA);

  @override
  Color get bookingsBookableStatusColor => const Color(0xFFEC2B3E);

  @override
  Color get bookingsRequestStatusColor => const Color(0xFF6C246D);

  // @override
  // Color get bookingsCancelledStatusColor => const Color(0xFF6C246D);

  // @override
  // Color get bookingsConfirmedStatusColor => const Color(0xFFEC2B3E);

  @override
  Color get bookingsPendingStatusColor => const Color(0xFFFCD605);

  @override
  Color get dialogSuccessContainerBgColor => const Color(0xFFEC2B3E);

  @override
  Color get timeSlotSelectedColor =>  const Color(0xFFEC2B3E);
  
  @override
  Color get timeSlotUnSelectedColor => const Color(0xFFF3F3F3);
  
  @override
  Color get fabColor => primaryColor;
  
  @override
  Color get visitorsApprovedStatusColor => const Color(0xFF01C875);
  
  @override
  Color get visitorsPendingStatusColor => const Color(0xFFFCD605);
  
  @override
  Color get visitorsRejectedStatusColor => const Color(0xFFE2445B);
  
  @override
  Color get visitorDetailsInCardBgColor => const Color(0xFFF6A087);
  
  @override
  Color get visitorDetailsInCardTextColor => const Color(0xFF77216F);
  
  @override
  Color get visitorDetailsOutCardBgColor => const Color(0xFFC5DBF2);
  
  @override
  Color get visitorDetailsOutCardTextColor => const Color(0xFFE95420);

  @override
  Color get bookingsCancelledStatusColor => const Color(0xFFE2445B);

  // UPDATED: Matched with visitorsApprovedStatusColor (Green)
  @override
  Color get bookingsConfirmedStatusColor => const Color(0xFF01C875);


}
