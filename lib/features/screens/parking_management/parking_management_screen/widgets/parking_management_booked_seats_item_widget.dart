import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_pkg_lockated_book_parking/utils/constants.dart';
import 'package:flutter_pkg_lockated_book_parking/utils/custom_logger.dart';
import 'package:flutter_pkg_lockated_book_parking/utils/space_management_utils.dart';
import 'package:flutter_pkg_lockated_book_parking/utils/utils.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/seat_booking_attendance/seat_booking_attendance.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/show_schedule/show_schedule.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/parking_model/parking_seat_booking/parking_seat_booking.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/parking_management/book_parking_date_and_slot_route_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/parking_management/booking_parking_details_screen_route_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/providers/parking_management/parking_management_bookings_tab_provider.dart';
import 'package:flutter_pkg_lockated_book_parking/features/providers/parking_management/parking_management_fragment_provider.dart';
import 'package:flutter_pkg_lockated_book_parking/features/providers/parking_management/parking_management_provider.dart';
import 'package:flutter_pkg_lockated_book_parking/widgets/common/common_card.dart';



class ParkingManagementBookedSeatsItemWidget extends StatelessWidget {
  final ParkingSeatBooking item;
  final bool isFromList;
  final BuildContext parentContext;
  final bool isForRescheduling;

  const ParkingManagementBookedSeatsItemWidget(
      {Key? key,
      required this.item,
      this.isFromList = false,
      required this.parentContext,
      this.isForRescheduling = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonCard(
      labelColor: HexColor(
          SpaceManagementUtils.getStatusColor(status: item.status ?? '')),
      labelText: item.status ?? '',
      onTap: () {
        if (isForRescheduling) {
          Navigator.pushNamed(
            context,
            'booking_parking_detail_screen',
            arguments: BookingParkingDetailsScreenRouteModel(
                seatBookingId: item.id.toString()),
            // Routes.bookingParkingDetailScreen,
            // arguments: BookingParkingDetailsScreenRouteModel(
            //     seatBookingId: item.id.toString()),
          ).then((value) {
            if (!isFromList) {
              Provider.of<ParkingManagementFragmentProvider>(parentContext,
                      listen: false)
                  .init(
                      context: parentContext,
                      selectDate:
                          Provider.of<ParkingManagementFragmentProvider>(
                                  parentContext,
                                  listen: false)
                              .selectedDay);
            } else {
              Provider.of<ParkingManagementBookingsTabProvider>(context,
                      listen: false)
                  .init(context: parentContext);
            }
          });
        } else {
          Navigator.pushNamed(
            context,
            'booking_parking_detail_screen',
            arguments: BookingParkingDetailsScreenRouteModel(
                seatBookingId: item.id.toString()),
            // Routes.bookingParkingDetailScreen,
            // arguments: BookingParkingDetailsScreenRouteModel(
            //     seatBookingId: item.id.toString()),
          ).then((value) {
            if (!isFromList) {
              Provider.of<ParkingManagementProvider>(parentContext,
                      listen: false)
                  .init(
                      context: parentContext,
                      selectDate: Provider.of<ParkingManagementProvider>(
                              parentContext,
                              listen: false)
                          .selectedDay);
            } else {
              Provider.of<ParkingManagementBookingsTabProvider>(context,
                      listen: false)
                  .init(context: parentContext);
            }
          });
        }
      },
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildImageWidget(
                  imgUrl: item.parkingImageUrl,
                  categoryName: item.categoryName),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(4, 8, 8, 4),
                      child: Text(
                        item.categoryName ?? '',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(4, 4, 8, 4),
                      child: Row(
                        children: [
                          Text(
                            'Booking ID : ',
                            style: TextStyle(
                              fontSize: 12,
                              color: HexColor(appBlue),
                            ),
                          ),
                          Text(
                            '#${item.id}',
                            style: TextStyle(
                              fontSize: 12,
                              color: HexColor(appBlue),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(4, 4, 8, 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isFromList
                                ? 'Booking Date & Time :'
                                : 'Time Slot : ',
                            style: TextStyle(
                              fontSize: isFromList ? 10 : 12,
                            ),
                          ),
                          if (!isFromList && item.showSchedule != null)
                            _buildtimeSlots(timeSlots: item.showSchedule!),
                          if (isFromList && item.showSchedule != null)
                            _buildFromListtimeSlots(
                                timeSlots: item.showSchedule!, booking: item),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (!isForRescheduling)
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: _buildButton(
                    title: 'RESCHEDULE',
                    color: spaceManagementRescheduleButtonColor,
                    onTap: () {
                      if (!isFromList) {
                        Navigator.pushNamed(
                          context,
                          'book_parking_date_and_slot',
                          arguments: BookParkingDateAndSlotRouteModel(
                            isForRescheduling: true,
                            mSeatBooking: item,
                          ),
                          // Routes.bookParkingDateAndSlot,
                          // arguments: BookParkingDateAndSlotRouteModel(
                          //   isForRescheduling: true,
                          //   mSeatBooking: item,
                          // ),
                        ).then((value) {
                          Provider.of<ParkingManagementProvider>(parentContext,
                                  listen: false)
                              .init(
                            context: parentContext,
                            selectDate: Provider.of<ParkingManagementProvider>(
                                    parentContext,
                                    listen: false)
                                .selectedDay,
                          );
                        });
                      } else {
                        Navigator.pushNamed(
                          context,
                          'book_parking_date_and_slot',
                          arguments: BookParkingDateAndSlotRouteModel(
                            isForRescheduling: true,
                            mSeatBooking: item,
                          ),
                          // Routes.bookParkingDateAndSlot,
                          // arguments: BookParkingDateAndSlotRouteModel(
                          //   isForRescheduling: true,
                          //   mSeatBooking: item,
                          // ),
                        ).then((value) {
                          Provider.of<ParkingManagementBookingsTabProvider>(
                                  parentContext,
                                  listen: false)
                              .init(
                            context: parentContext,
                          );
                        });
                      }
                    },
                    date: Provider.of<ParkingManagementProvider>(context,
                            listen: true)
                        .selectedDay,
                    booking: item,
                    buttonType: SpaceManagementButtonType.reschedule,
                  ),
                ),
                // Expanded(
                //   child: _buildButton(
                //     title: 'CHECK IN',
                //     color: spaceManagementCheckinButtonColor,
                //     onTap: () {
                //       int? slotId = SpaceManagementUtils
                //           .setVisibilityOfCheckInCheckOut(true, item);
                //       if (slotId != null) {
                //         if (!isFromList) {
                //           Provider.of<ParkingManagementProvider>(context,
                //                   listen: false)
                //               .sendPunchInDetails(
                //                   context: context, slotId: slotId);
                //         } else {
                //           Provider.of<ParkingManagementBookingsTabProvider>(
                //                   context,
                //                   listen: false)
                //               .sendPunchInDetails(
                //                   context: context, slotId: slotId);
                //         }
                //       } else {
                //         showToastDialog(msg: 'Unable to Update Data');
                //       }
                //     },
                //     date: Provider.of<ParkingManagementProvider>(context,
                //             listen: true)
                //         .selectedDay,
                //     booking: item,
                //     buttonType: SpaceManagementButtonType.checkIn,
                //   ),
                // ),
              ],
            ),
          // if (!isForRescheduling)
          //   _buildButton(
          //     title: 'CHECK OUT',
          //     color: spaceManagementCheckoutButtonColor,
          //     onTap: () {
          //       SeatBookingAttendance? attendance =
          //           SpaceManagementUtils.getCurrentAttendance(item);
          //       if (attendance != null && attendance.id != null) {
          //         if (!isFromList) {
          //           Provider.of<ParkingManagementProvider>(context,
          //                   listen: false)
          //               .sendPunchOutDetails(
          //             context: context,
          //             attendanceId: attendance.id.toString(),
          //             workLog: '',
          //           );
          //         } else {
          //           Provider.of<ParkingManagementBookingsTabProvider>(
          //                   context,
          //                   listen: false)
          //               .sendPunchOutDetails(
          //             context: context,
          //             attendanceId: attendance.id.toString(),
          //             workLog: '',
          //           );
          //         }
          //       } else {
          //         showToastDialog(msg: 'Unable to Update Data');
          //       }
          //     },
          //     date: Provider.of<ParkingManagementProvider>(context,
          //             listen: true)
          //         .selectedDay,
          //     booking: item,
          //     buttonType: SpaceManagementButtonType.checkOut,
          //   ),
        ],
      ),
    );
  }

  Widget _buildImageWidget({String? imgUrl, String? categoryName}) {
    if (imgUrl != null) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.network(
          imgUrl,
          fit: BoxFit.fill,
          width: 100,
          height: 100,
        ),
      );
    } else {
      String assetsImage = 'assets/space_management/seat_category_images/';
      String assetsName = 'default_cabin_big';
      switch (categoryName ?? '') {
        case 'Cabin':
          assetsName = 'static_cabin';
          break;
        case 'Fixed desk':
          assetsName = 'static_fixed_desk';
          break;
        case 'Fixed':
          assetsName = 'static_fixed_desk';
          break;
        case 'Flexi desk':
          assetsName = 'static_flexi_desk';
          break;
        case 'hot desk':
          assetsName = 'static_hot_desk';
          break;
        case 'Linear WS':
          assetsName = 'static_linear_ws';
          break;
        case 'Linear':
          assetsName = 'static_linear_ws';
          break;
        case 'Angular WS':
          assetsName = 'static_angular_ws1';
          break;
        case 'Angular':
          assetsName = 'static_angular';
          break;
        case 'Common':
          assetsName = 'static_common1';
          break;
        default:
      }
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          '$assetsImage$assetsName.png',
          fit: BoxFit.fill,
          width: 100,
          height: 100,
        ),
      );
    }
  }

  Widget _buildtimeSlots({required ShowSchedule timeSlots}) {
    List<Widget> list = [];

    // for (var item in timeSlots) {
    list.add(
      Text(
        timeSlots.slot == null
            ? ''
            : timeSlots.slot!.replaceAll('AM', 'am').replaceAll('PM', 'pm'),
        style: const TextStyle(
          fontSize: 12,
        ),
      ),
    );
    // }

    return Column(
      children: [
        ...list,
      ],
    );
  }

  Widget _buildFromListtimeSlots(
      {required ShowSchedule timeSlots, required ParkingSeatBooking booking}) {
    String sBookedOnOriginalDate = booking.bookingDate ?? '';

    String sBookedOnTemp = '';

    if (sBookedOnOriginalDate.isNotEmpty) {
      DateFormat format = DateFormat("yyyy-MM-dd");
      DateTime date;
      try {
        date = format.parse(sBookedOnOriginalDate);

        String sBookedOnOriginalDate1 =
            DateFormat("MMM dd, yyyy, ").format(date);

        sBookedOnTemp = sBookedOnOriginalDate1;
      } catch (e) {
        logError(msg: e);
      }
    }

    List<Widget> list = [];

    // for (var item in timeSlots) {
    list.add(
      Text(
        timeSlots.slot == null
            ? ''
            : sBookedOnTemp +
                timeSlots.slot!.replaceAll('AM', 'am').replaceAll('PM', 'pm'),
        style: const TextStyle(
          fontSize: 10,
        ),
      ),
    );
    // }

    return Expanded(
      child: Column(
        children: [
          ...list,
        ],
      ),
    );
  }

  Widget _buildButton({
    required String title,
    required String color,
    required VoidCallback onTap,
    required DateTime date,
    required ParkingSeatBooking booking,
    required SpaceManagementButtonType buttonType,
  }) {
    // logError(msg: title);
    bool showButton = false;

    DateTime now = DateFormat('yyyy-MM-dd').parse(DateTime.now().toString());
    DateTime tempDate = DateFormat('yyyy-MM-dd').parse(date.toString());

    if (tempDate.toUtc().isBefore(now.toUtc())) {
      //if  date is before today, hide reschedule, check-in and checkout buttons
      // logInfo(
      //     msg:
      //         'if  date is before today, hide reschedule, check-in and checkout buttons');
      showButton = false;
    } else {
      SeatBookingAttendance? currentAttendance =
          SpaceManagementUtils.getParkingCurrentAttendance(booking);
      if (currentAttendance != null &&
          (currentAttendance.punchedInAt != null &&
              currentAttendance.punchedInAt!.isNotEmpty)) {
        //else if checkin detail is present in seatbooking object, hide only reschedule and check-in buttons and display checkout button
        // logInfo(
        //     msg:
        //         'else if checkin detail is present in seatbooking object, hide only reschedule and check-in buttons and display checkout button');
        if (buttonType == SpaceManagementButtonType.reschedule ||
            buttonType == SpaceManagementButtonType.checkIn) {
          showButton = false;
        } else {
          showButton = true;
        }
        bool isCheckOutDetailsPresent =
            (currentAttendance.punchedOutAt != null &&
                currentAttendance.punchedOutAt!.isNotEmpty);
        if (buttonType == SpaceManagementButtonType.checkOut &&
            isCheckOutDetailsPresent) {
          showButton = false;
        }
      } else {
        //else if above condition fails,
        // logInfo(msg: 'else if above condition fails,');
        if (booking.showSchedule != null) {
          String slot = booking.showSchedule!.slot ?? '';
          String sStartTimeWithoutDate = slot.split(" to ")[0];

          try {
            DateFormat sdf = DateFormat("yyyy-MM-dd HH:mm a");
            DateTime dStartTime =
                sdf.parse('${booking.bookingDate} ' + sStartTimeWithoutDate);

            // Calendar c=Calendar.getInstance();
            // c.set(Calendar.HOUR_OF_DAY,24);
            // c.setTime(dStartTime);
            // if(sStartTimeWithoutDate.toLowerCase().contains("pm")){
            //   c.add(Calendar.HOUR,12);
            // }
            // if (sStartTimeWithoutDate.toLowerCase().contains("pm")) {
            //   dStartTime.add(const Duration(hours: 12));
            // }
            DateTime dStartTimeNew = dStartTime;
            // logInfo(msg: 'dStartTimeNew: $dStartTimeNew');

//            if (new Date().before(dStartTime)) {
            if (DateTime.now().isBefore(dStartTimeNew)) {
              //  check if current time is before start time. if yes, show reschedule and checkin buttons. Hide checkout button
              // logInfo(
              //     msg:
              //         'check if current time is before start time. if yes, show reschedule and checkin buttons. Hide checkout button');
              //Reschedule Button
              if (buttonType == SpaceManagementButtonType.reschedule) {
                if (booking.status != null) {
                  if (booking.status!.trim().toLowerCase() == 'confirmed') {
                    showButton = true;
                  } else {
                    showButton = false;
                  }
                } else {
                  showButton = false;
                }
              }

              //CheckIN Button
              if (buttonType == SpaceManagementButtonType.checkIn) {
                showButton = true;
              }

              //CheckOut Buttone
              if (buttonType == SpaceManagementButtonType.checkOut) {
                showButton = false;
              }
            } else {
              // else show only checkin button and hide reschedule and checkout buttons
              // logInfo(
              //     msg:
              //         'else show only checkin button and hide reschedule and checkout buttons');
              if (buttonType == SpaceManagementButtonType.reschedule ||
                  buttonType == SpaceManagementButtonType.checkOut) {
                showButton = false;
              }
              if (buttonType == SpaceManagementButtonType.checkIn) {
                showButton = true;
              }
            }
          } catch (e) {
            logError(msg: e);
          }
        } else {
          // logInfo(msg: 'else_1');
          //Reschedule Button
          if (buttonType == SpaceManagementButtonType.reschedule) {
            if (booking.status != null) {
              if (booking.status!.trim().toLowerCase() == 'confirmed') {
                showButton = true;
              } else {
                showButton = false;
              }
            } else {
              showButton = false;
            }
          }

          //CheckIN Button
          if (buttonType == SpaceManagementButtonType.checkIn) {
            showButton = true;
          }

          //CheckOut Buttone
          if (buttonType == SpaceManagementButtonType.checkOut) {
            showButton = false;
          }
        }
      }
      if (buttonType == SpaceManagementButtonType.checkIn) {
        // logInfo(msg: 'if_1');
        if (!Utils.isToday(date: tempDate) && showButton) {
          showButton = false;
        }
      }
    }

    if (booking.status != null &&
        booking.status!.toLowerCase() == 'cancelled') {
      // logInfo(msg: 'cancelled');
      showButton = false;
    }

    //CheckIn Button
    int? iCurrentVisibleSlotId =
        SpaceManagementUtils.setParkingVisibilityOfCheckInCheckOut(
            showButton, booking);
    if (buttonType == SpaceManagementButtonType.checkIn) {
      if (iCurrentVisibleSlotId != null) {
        // logInfo(msg: 'iCurrentVisible != null');
        showButton = true;
      } else {
        // logInfo(msg: 'iCurrentVisible == null');
        showButton = false;
      }
    } else {
      if (iCurrentVisibleSlotId != null) {
        //New Logic to set Cancel and Resuchedule button false
        if (buttonType == SpaceManagementButtonType.cancel ||
            buttonType == SpaceManagementButtonType.reschedule) {
          showButton = false;
        }
      }
    }

    if (booking.status != null &&
        booking.status!.trim().toLowerCase() == 'waiting') {
      // logInfo(msg: 'waiting');
      showButton = false;
    }

    // logError(msg: '---- End -----');

    if (showButton) {
      return InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            color: HexColor(color),
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Center(
                child: Text(title),
              ),
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
