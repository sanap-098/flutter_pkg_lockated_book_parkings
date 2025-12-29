import 'package:flutter/material.dart';

abstract class CompanyColors {
  Color get primaryColor;
  Color get secondaryColor;

  // Card BG
  Color get cardLinearGradientStartColor;
  Color get cardLinearGradientEndColor;

  // Icon Blac
  Color get iconColor;

  // Fitness Dialog
  Color get fitnessDialogButtonColor;

  // Divider
  Color get dividerColor;

  // Carousel Indicator
  Color get carouselIndicatorSelectedColor;
  Color get carouselIndicatorUnSelectedColor;

  Color get carouselIndicatorBorderSelectedColor;
  Color get carouselIndicatorBorderUnSelectedColor;

  Color get carouselSeekBarProgressColor;
  Color get carouselSeekBarTrackColor;

  //
  Color get statsCardStartDateBgColor;
  Color get statsCardEndDateBgColor;

  // Calendar
  Color get calendarSelectedDateColor;

  //
  Color get statsCardBgColor;

  // Label Colors - Bookings
  Color get bookingsBookableStatusColor;
  Color get bookingsRequestStatusColor;

  Color get bookingsConfirmedStatusColor;
  Color get bookingsCancelledStatusColor;
  Color get bookingsPendingStatusColor;

  // Dialog
  Color get dialogSuccessContainerBgColor;

  // Slots
  Color get timeSlotSelectedColor;
  Color get timeSlotUnSelectedColor;

  // FAB
  Color get fabColor;

  // Visitors
  Color get visitorsPendingStatusColor;
  Color get visitorsRejectedStatusColor;
  Color get visitorsApprovedStatusColor;

  Color get visitorDetailsInCardBgColor;
  Color get visitorDetailsInCardTextColor;

  Color get visitorDetailsOutCardBgColor;
  Color get visitorDetailsOutCardTextColor;

}
