import 'package:intl/intl.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/seat_booking.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/seat_booking_attendance/seat_booking_attendance.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/show_schedule/show_schedule.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/parking_model/parking_seat_booking/parking_seat_booking.dart';
import 'package:flutter_pkg_lockated_book_parking/utils/constants.dart';
import 'package:flutter_pkg_lockated_book_parking/utils/custom_logger.dart';
class SpaceManagementUtils {
  static int? setVisibilityOfCheckInCheckOut(bool tv, SeatBooking booking) {
    int? iSlotId;
    if (tv) {
      List<ShowSchedule> showSchedule = booking.showSchedule ?? [];
      for (int i = 0; i < showSchedule.length; i++) {
        ShowSchedule schedule = showSchedule[i];
        if (isWithinRange(
            DateTime.now(), booking.bookingDate ?? '', schedule.slot ?? '')) {
          logInfo(msg: 'Is with inrage: true');
          iSlotId = schedule.slotId;
          return iSlotId;
        } else {
          logInfo(msg: 'Is With in range: false');
        }
      }
    }
    return iSlotId;
  }

  static bool isWithinRange(
      DateTime testDate, String sBookingDate, String sSlotTime) {
//        2021-05-29 02:00 PM

    List<String> slotTime = sSlotTime.split(" to ");

    String sStartDate = (sBookingDate + " " + slotTime[0])
        .replaceAll('PM', 'pm')
        .replaceAll('AM', 'am');
    String sEndDate = (sBookingDate + " " + slotTime[1])
        .replaceAll('PM', 'pm')
        .replaceAll('AM', 'am');
    DateFormat sdf = DateFormat("yyyy-MM-dd HH:mm");

    DateTime? startDate;
    DateTime? endDate;

    try {
      startDate = sdf.parse(sStartDate);
      // startDate = DateFormat('yyyy-MM-dd HH:mm a').parse(sStartDate);
      endDate = sdf.parse(sEndDate);

      String sTempStartDate = sdf.format(startDate);
      String sTempEndDate = sdf.format(endDate);

      if ((sStartDate.toLowerCase().contains("pm")) &&
          (!sTempStartDate.contains("pm")) &&
          !slotTime[0].contains('12')) {
        //add 12 hours
        // Calendar calendar=Calendar.getInstance();
        // calendar.set(Calendar.HOUR_OF_DAY,24);
        // calendar.setTime(startDate);
        // calendar.add(Calendar.HOUR,12);

        startDate = startDate.add(const Duration(hours: 12));
      }

      if ((sEndDate.toLowerCase().contains("pm")) &&
          (!sTempEndDate.contains("pm")) &&
          !slotTime[1].contains('12')) {
        //add 12 hours
        // Calendar calendar=Calendar.getInstance();
        // calendar.set(Calendar.HOUR_OF_DAY,24);
        // calendar.setTime(endDate);
        // calendar.add(Calendar.HOUR,12);
        endDate = endDate.add(const Duration(hours: 12));
      }

      // logInfo(
      //     msg:
      //         'testDate: $testDate\n startDate: $startDate \n EndDate: $endDate');

      if (testDate.compareTo(startDate) >= 0) {
        if (testDate.compareTo(endDate) <= 0) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (e) {
      logError(msg: 'Space Management Utils WithIn Range Error: $e');
    }

    return false;
  }

  static ShowSchedule? getCurrentShowSchedule(SeatBooking booking) {
    List<ShowSchedule> showSchedule = booking.showSchedule ?? [];
    for (int i = 0; i < showSchedule.length; i++) {
      ShowSchedule schedule = showSchedule[i];
      if (booking.bookingDate != null && schedule.slot != null) {
        if (isWithinRange(
            DateTime.now(), booking.bookingDate!, schedule.slot!)) {
          return schedule;
        }
      }
    }
    return null;
  }

  static SeatBookingAttendance? getCurrentAttendance(SeatBooking booking) {
    List<SeatBookingAttendance> lAttendance = booking.attendance ?? [];
    if (lAttendance.isEmpty) {
      return null;
    } else {
      ShowSchedule? currentShowSchedule = getCurrentShowSchedule(booking);
      if (currentShowSchedule != null) {
        String? slot = currentShowSchedule.slot;
        if (slot != null) {
          for (int i = 0; i < lAttendance.length; i++) {
            SeatBookingAttendance attendance = lAttendance[i];

            if (attendance.showSchedule != null &&
                attendance.showSchedule!.isNotEmpty) {
              ShowSchedule? showSchedule = attendance.showSchedule![0];
              if (showSchedule != null) {
                String? tempSlot = showSchedule.slot;
                if (slot.trim() == tempSlot) {
                  return attendance;
                }
              }
            }
          }
        }
      }
    }

    return null;
  }

  static SeatBookingAttendance? getParkingCurrentAttendance(
      ParkingSeatBooking booking) {
    List<SeatBookingAttendance> lAttendance = booking.attendance ?? [];
    if (lAttendance.isEmpty) {
      return null;
    } else {
      ShowSchedule? currentShowSchedule =
          getParkingCurrentShowSchedule(booking);
      if (currentShowSchedule != null) {
        String? slot = currentShowSchedule.slot;
        if (slot != null) {
          for (int i = 0; i < lAttendance.length; i++) {
            SeatBookingAttendance attendance = lAttendance[i];

            if (attendance.showSchedule != null &&
                attendance.showSchedule!.isNotEmpty) {
              ShowSchedule? showSchedule = attendance.showSchedule![0];
              if (showSchedule != null) {
                String? tempSlot = showSchedule.slot;
                if (slot.trim() == tempSlot) {
                  return attendance;
                }
              }
            }
          }
        }
      }
    }

    return null;
  }

  static int? setParkingVisibilityOfCheckInCheckOut(
      bool tv, ParkingSeatBooking booking) {
    int? iSlotId;
    if (tv) {
      List<ShowSchedule> showSchedule =
          booking.showSchedule != null ? [booking.showSchedule!] : [];
      for (int i = 0; i < showSchedule.length; i++) {
        ShowSchedule schedule = showSchedule[i];
        if (isWithinRange(
            DateTime.now(), booking.bookingDate ?? '', schedule.slot ?? '')) {
          logInfo(msg: 'Is with inrage: true');
          iSlotId = schedule.slotId;
          return iSlotId;
        } else {
          logInfo(msg: 'Is With in range: false');
        }
      }
    }
    return iSlotId;
  }

  static ShowSchedule? getParkingCurrentShowSchedule(
      ParkingSeatBooking booking) {
    List<ShowSchedule> showSchedule =
        booking.showSchedule != null ? [booking.showSchedule!] : [];
    for (int i = 0; i < showSchedule.length; i++) {
      ShowSchedule schedule = showSchedule[i];
      if (booking.bookingDate != null && schedule.slot != null) {
        if (isWithinRange(
            DateTime.now(), booking.bookingDate!, schedule.slot!)) {
          return schedule;
        }
      }
    }
    return null;
  }

  static String getStatusColor({required String status}) {
    String tempStatus = status.trim().toLowerCase();
    String color = newUiPrimaryBlue;
    if (tempStatus == 'approved' ||
        tempStatus == 'confirmed' ||
        tempStatus == 'paid') {
      color = lightGreenStatusColor;
    }

    if (tempStatus == 'rejected' ||
        tempStatus == 'cancelled' ||
        tempStatus == 'unpaid') {
      color = lightRedStatusColor;
    }

    if (tempStatus == 'pending' ||
        tempStatus == 'waiting' ||
        tempStatus == 'partially paid') {
      color = lightYellowStatusColor;
    }

    if (tempStatus == 'completed') {
      color = green;   
    }

    if (tempStatus == 'rescheduled') {
      color = newUiPrimaryBlue;
    }
    return color;
  }
}
