import 'package:clippy_flutter/label.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/parking_management/book_parking_date_and_slot_route_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/parking_management/booking_parking_details_screen_route_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/seat_booking_attendance/seat_booking_attendance.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/show_schedule/show_schedule.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/parking_model/parking_seat_booking/parking_seat_booking.dart';
import 'package:flutter_pkg_lockated_book_parking/features/providers/parking_management/booking_parking_detail_provider.dart';
import 'package:flutter_pkg_lockated_book_parking/utils/constants.dart';
import 'package:flutter_pkg_lockated_book_parking/utils/custom_logger.dart';
import 'package:flutter_pkg_lockated_book_parking/utils/space_management_utils.dart';
import 'package:flutter_pkg_lockated_book_parking/utils/utils.dart';
import 'package:flutter_pkg_lockated_book_parking/widgets/common/common_app_bar.dart';
import 'package:flutter_pkg_lockated_book_parking/widgets/common/toast_dialog.dart';

class BookingParkingDetailScreen extends StatefulWidget {
  final BookingParkingDetailsScreenRouteModel routeModel;

  const BookingParkingDetailScreen({Key? key, required this.routeModel})
      : super(key: key);

  @override
  State<BookingParkingDetailScreen> createState() =>
      _BookingParkingDetailScreenState();
}

class _BookingParkingDetailScreenState
    extends State<BookingParkingDetailScreen> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) =>
        Provider.of<BookingParkingDetailProvider>(context, listen: false)
            .init(context: context, seatId: widget.routeModel.seatBookingId));
    super.initState();
  }

  DateFormat sdfOriginal = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ");
  DateFormat sdfBookedOn = DateFormat(" ':' MMM dd, yyyy, 'at' HH:mma");
  DateFormat sdfBookingDateAndTime = DateFormat(" ':' MMM dd, yyyy");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: 'Booking Details',
        leadingCallback: () {
          if (widget.routeModel.isFromNoti) {
            // FIX: Using Named Route String
            Navigator.pushNamedAndRemoveUntil(
                context, 'home_screen', (route) => false);
          } else {
            Navigator.pop(context);
          }
        },
      ),
      body: Consumer<BookingParkingDetailProvider>(
        builder: (_, state, child) {
          if (state.seatBooking == null) {
            return Container();
          }
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (state.seatBooking != null)
                  _buildHeaderImage(
                    seatImageUrl: state.seatBooking!.parkingImageUrl,
                    categoryName: state.seatBooking!.categoryName,
                    bookingId: state.seatBooking!.id.toString(),
                    status: state.seatBooking!.status,
                  ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      if (state.seatBooking != null &&
                          state.seatBooking!.categoryName != null)
                        Text(
                          state.seatBooking!.categoryName!,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      const SizedBox(
                        height: 15,
                      ),
                      if (state.seatBooking != null &&
                          state.seatBooking!.createdAt != null)
                        _buildBookedOnWidget(
                            bookedOnDate: state.seatBooking!.createdAt!),
                      const SizedBox(
                        height: 8,
                      ),
                      if (state.seatBooking != null &&
                          state.seatBooking!.bookingDate != null)
                        _buildBookedDateWidget(
                            bookedDate: state.seatBooking!.bookingDate!),
                      const SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                ),
                if (state.seatBooking != null)
                  _buildLoactionWidget(
                      buildingName: state.seatBooking!.buildingName ?? '',
                      floorName: state.seatBooking!.floorName ?? ''),
                if (state.seatBooking != null)
                  _buildSeatSlotWidget(booking: state.seatBooking! as dynamic),
                const SizedBox(
                  height: 8,
                ),
                _buildLoginInfoList(state: state),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (Provider.of<BookingParkingDetailProvider>(context, listen: true)
                  .seatBooking !=
              null)
            Row(
              children: [
                _buildButton(
                  title: 'CANCEL',
                  color: '#FF0000',
                  textColor: '#FFFFFF',
                  onTap: () async {
                    if (Provider.of<BookingParkingDetailProvider>(context,
                                listen: false)
                            .seatBooking ==
                        null) {
                      showToastDialog(msg: 'Unable to Cancel!');
                      return;
                    }
                    Provider.of<BookingParkingDetailProvider>(context,
                            listen: false)
                        .onCancelClicked(
                            context: context,
                            booking: Provider.of<BookingParkingDetailProvider>(
                                    context,
                                    listen: false)
                                .seatBooking!);
                  },
                  booking: Provider.of<BookingParkingDetailProvider>(context,
                          listen: true)
                      .seatBooking! as dynamic,
                  buttonType: SpaceManagementButtonType.cancel,
                ),
                _buildButton(
                  title: 'RESCHEDULE',
                  color: newUiPrimaryBlue,
                  textColor: '#FFFFFF',
                  onTap: () {
                    // FIX: Using Named Route String
                    Navigator.pushNamed(
                      context,
                      'book_parking_date_and_slot',
                      arguments: BookParkingDateAndSlotRouteModel(
                        isForRescheduling: true,
                        // Cast to dynamic to bypass any lingering type mismatch
                        mSeatBooking: Provider.of<BookingParkingDetailProvider>(
                                context,
                                listen: false)
                            .seatBooking! as dynamic,
                      ),
                    );
                  },
                  booking: Provider.of<BookingParkingDetailProvider>(context,
                          listen: true)
                      .seatBooking! as dynamic,
                  buttonType: SpaceManagementButtonType.reschedule,
                )
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildHeaderImage({
    String? seatImageUrl,
    String? categoryName,
    String? bookingId,
    String? status,
  }) {
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
    return Stack(
      children: [
        Image.asset('assets/space_management/ic_space_detail_background.png'),
        FractionalTranslation(
          translation: const Offset(0.0, 0.2),
          child: Row(
            children: [
              seatImageUrl != null
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(
                        seatImageUrl,
                        fit: BoxFit.fill,
                        width: 100,
                        height: 100,
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        '$assetsImage$assetsName.png',
                        fit: BoxFit.fill,
                        width: 100,
                        height: 100,
                      ),
                    ),
              Text(
                'Booking ID: #$bookingId',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Label(
            triangleHeight: 18.0,
            edge: Edge.LEFT,
            child: Container(
              padding: const EdgeInsets.only(
                  left: 8.0, right: 18.0, top: 4.0, bottom: 4.0),
              color: HexColor(
                  SpaceManagementUtils.getStatusColor(status: status ?? '')),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
                child: Text(
                  status == null ? '' : status.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBookedOnWidget({
    required String bookedOnDate,
  }) {
    String date = '';
    try {
      DateTime dBookedOn = sdfOriginal.parse(bookedOnDate);
      date = sdfBookedOn.format(dBookedOn);
    } catch (e) {
      logError(msg: e);
    }
    return Row(
      children: [
        const Text(
          'Booked On: ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          date,
          style: const TextStyle(
            fontSize: 13,
          ),
        ),
      ],
    );
  }

  Widget _buildBookedDateWidget({
    required String bookedDate,
  }) {
    String date = '';
    try {
      DateFormat sdfYyyyMmDd = DateFormat("yyyy-MM-dd");
      DateTime dBookingDateOriginal = sdfYyyyMmDd.parse(bookedDate);
      date = sdfBookingDateAndTime.format(dBookingDateOriginal);
    } catch (e) {
      logError(msg: e);
    }
    return Row(
      children: [
        const Text(
          'Booking Date: ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          date,
          style: const TextStyle(
            fontSize: 13,
          ),
        ),
      ],
    );
  }

  Widget _buildLoactionWidget({
    required String buildingName,
    required String floorName,
  }) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 8, bottom: 8),
      child: Row(
        children: [
          const Text(
            'Location: ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '$buildingName/$floorName',
            style: const TextStyle(
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSeatSlotWidget({
    required ParkingSeatBooking booking,
  }) {
    List<ShowSchedule>? showSchedule =
        booking.showSchedule != null ? [booking.showSchedule!] : [];

    DateFormat sdfBookingDate = DateFormat("yyyy-MM-dd");
    String sBookingDate = booking.bookingDate!;
    DateTime? dBookingDate;
    try {
      dBookingDate = sdfBookingDate.parse(sBookingDate);
    } catch (e) {
      logError(msg: e);
    }

    if (dBookingDate != null &&
        showSchedule != null &&
        showSchedule.isNotEmpty) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.grey[200]!,
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 8, 30, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ..._buildSeatSlotsList(
                  showSchedule: showSchedule, booking: booking),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  List<Widget> _buildSeatSlotsList({
    required List<ShowSchedule> showSchedule,
    required ParkingSeatBooking booking,
  }) {
    List<Widget> list = [];

    for (var item in showSchedule) {
      String sSeatNumber = item.seat ?? '';
      String sBookingDateAndTime = item.slot ?? '';

      String sBookingDateAndTimeUpdated =
          sBookingDateAndTime.replaceAll("AM", "am").replaceAll("PM", "pm");

      list.add(Row(
        children: [
          if (Provider.of<BookingParkingDetailProvider>(context, listen: true)
              .isCancelPressed)
            Checkbox(
              value: item.isChecked,
              onChanged: (value) {
                if (value == null) {
                  showToastDialog(
                      msg: 'Something went wrong please try again later');
                  return;
                }
                Provider.of<BookingParkingDetailProvider>(context,
                        listen: false)
                    .onCancelSlotCheckBoxClicked(
                        showSchedule: item, value: value);
              },
            )
          else
            const SizedBox(
              width: 30,
            ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                sSeatNumber,
                style: const TextStyle(
                  // fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  const Text(
                    'Parking No.',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.pushNamed(
                        context, 'web_view_screen',
                        arguments: booking.floorPlanAttachment),
                    child: const Icon(
                      Icons.error_outline,
                      color: Colors.red,
                      size: 15,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                sBookingDateAndTimeUpdated,
                style: const TextStyle(
                  // fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'Booking Time',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ));
    }

    return list;
  }

  Widget _buildLoginInfoList({
    required BookingParkingDetailProvider state,
  }) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 8, 30, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Login Information',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          if (state.seatBooking != null &&
              state.seatBooking!.attendance != null &&
              state.seatBooking!.attendance!.isNotEmpty)
            ..._buildLoginInfoItems(attendance: state.seatBooking!.attendance!),
        ],
      ),
    );
  }

  List<Widget> _buildLoginInfoItems({
    required List<SeatBookingAttendance> attendance,
  }) {
    List<Widget> list = [];

    for (var item in attendance) {
      DateFormat sdfc = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ");
      DateFormat sdfHhMmA = DateFormat("HH:mm a");
      String sInData = "", sOutData = "", sSlot = "";
      try {
        if (item.punchedInAt != null) {
          DateTime dInData = sdfc.parse(item.punchedInAt!);
          sInData = sdfHhMmA.format(dInData);
        }

        if (item.punchedOutAt != null) {
          DateTime dOutData = sdfc.parse(item.punchedOutAt!);
          sOutData = sdfHhMmA.format(dOutData);
        }
      } catch (e) {
        logError(msg: e);
      }
      List<ShowSchedule>? showSchedule = item.showSchedule;
      if ((showSchedule != null) && (showSchedule.isNotEmpty)) {
        ShowSchedule schedule = showSchedule[0];
        sSlot = schedule.slot ?? '';
      }
      list.add(Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (sInData.isNotEmpty)
              Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(sSlot),
                      const Spacer(),
                      const Text(
                        'IN',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        sInData,
                      )
                    ],
                  ),
                ),
              ),
            if (sOutData.isNotEmpty)
              Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(sSlot),
                      const Spacer(),
                      const Text(
                        'OUT',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        sOutData,
                      )
                    ],
                  ),
                ),
              ),
          ],
        ),
      ));
    }

    return list;
  }

  Widget _buildButton({
    required String title,
    required String color,
    required VoidCallback onTap,
    required ParkingSeatBooking booking,
    required SpaceManagementButtonType buttonType,
    String? textColor,
  }) {
    bool showButton = false;

    DateTime now = DateFormat('yyyy-MM-dd').parse(DateTime.now().toString());
    DateTime tempDate = DateFormat('yyyy-MM-dd').parse(booking.bookingDate!);

    if (tempDate.toUtc().isBefore(now.toUtc())) {
      showButton = false;
    } else {
      SeatBookingAttendance? currentAttendance =
          SpaceManagementUtils.getParkingCurrentAttendance(booking);
      if (currentAttendance != null &&
          (currentAttendance.punchedInAt != null &&
              currentAttendance.punchedInAt!.isNotEmpty)) {
        if (buttonType == SpaceManagementButtonType.reschedule ||
            buttonType == SpaceManagementButtonType.checkIn ||
            buttonType == SpaceManagementButtonType.cancel) {
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
        if (booking.showSchedule != null) {
          String slot = booking.showSchedule!.slot ?? '';
          String sStartTimeWithoutDate = slot.split(" to ")[0];

          try {
            DateFormat sdf = DateFormat("yyyy-MM-dd HH:mm a");
            DateTime dStartTime =
                sdf.parse('${booking.bookingDate} ' + sStartTimeWithoutDate);
            DateTime dStartTimeNew = dStartTime;

            if (DateTime.now().isBefore(dStartTimeNew)) {
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

              if (buttonType == SpaceManagementButtonType.checkIn) {
                showButton = true;
              }

              if (buttonType == SpaceManagementButtonType.checkOut) {
                showButton = false;
              }

              if (buttonType == SpaceManagementButtonType.cancel) {
                showButton = true;
              }
            } else {
              if (buttonType == SpaceManagementButtonType.reschedule ||
                  buttonType == SpaceManagementButtonType.checkOut ||
                  buttonType == SpaceManagementButtonType.cancel) {
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

          if (buttonType == SpaceManagementButtonType.checkIn) {
            showButton = true;
          }

          if (buttonType == SpaceManagementButtonType.checkOut) {
            showButton = false;
          }

          if (buttonType == SpaceManagementButtonType.cancel) {
            showButton = false;
          }
        }
      }
      if (buttonType == SpaceManagementButtonType.checkIn) {
        if (!Utils.isToday(date: tempDate) && showButton) {
          showButton = false;
        }
      }
    }

    if (booking.status != null &&
        booking.status!.toLowerCase() == 'cancelled') {
      showButton = false;
    }

    int? iCurrentVisibleSlotId =
        SpaceManagementUtils.setParkingVisibilityOfCheckInCheckOut(
            showButton, booking);
    if (buttonType == SpaceManagementButtonType.checkIn) {
      if (iCurrentVisibleSlotId != null) {
        showButton = true;
      } else {
        showButton = false;
      }
    } else {
      if (iCurrentVisibleSlotId != null) {
        if (buttonType == SpaceManagementButtonType.cancel ||
            buttonType == SpaceManagementButtonType.reschedule) {
          showButton = false;
        }
      }
    }

    if (booking.status != null &&
        booking.status!.trim().toLowerCase() == 'waiting') {
      showButton = false;
    }

    if (showButton) {
      return Expanded(
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: HexColor(color),
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Center(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: textColor != null
                          ? HexColor(textColor)
                          : Colors.black,
                    ),
                  ),
                ),
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




// import 'package:clippy_flutter/label.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:flutter_pkg_lockated_book_parking/features/models/parking_management/book_parking_date_and_slot_route_model.dart';
// import 'package:flutter_pkg_lockated_book_parking/features/models/parking_management/booking_parking_details_screen_route_model.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter_pkg_lockated_book_parking/core/routes.dart';
// import 'package:flutter_pkg_lockated_book_parking/features/models/seat_booking_attendance/seat_booking_attendance.dart';
// import 'package:flutter_pkg_lockated_book_parking/features/models/show_schedule/show_schedule.dart';
// import 'package:flutter_pkg_lockated_book_parking/features/models/parking_model/parking_seat_booking/parking_seat_booking.dart';
// import 'package:flutter_pkg_lockated_book_parking/features/models/parking_management/book_parking_date_and_slot_route_model.dart';
// import 'package:flutter_pkg_lockated_book_parking/features/models/parking_management/booking_parking_details_screen_route_model.dart';
// import 'package:flutter_pkg_lockated_book_parking/features/providers/parking_management/booking_parking_detail_provider.dart';
// import 'package:flutter_pkg_lockated_book_parking/utils/constants.dart';
// import 'package:flutter_pkg_lockated_book_parking/utils/custom_logger.dart';
// import 'package:flutter_pkg_lockated_book_parking/utils/space_management_utils.dart';
// import 'package:flutter_pkg_lockated_book_parking/utils/utils.dart';
// import 'package:flutter_pkg_lockated_book_parking/widgets/common/common_app_bar.dart';
// import 'package:flutter_pkg_lockated_book_parking/widgets/common/toast_dialog.dart';


// class BookingParkingDetailScreen extends StatefulWidget {
//   final BookingParkingDetailsScreenRouteModel routeModel;

//   const BookingParkingDetailScreen({Key? key, required this.routeModel})
//       : super(key: key);

//   @override
//   State<BookingParkingDetailScreen> createState() =>
//       _BookingParkingDetailScreenState();
// }

// class _BookingParkingDetailScreenState
//     extends State<BookingParkingDetailScreen> {
//   @override
//   void initState() {
//     SchedulerBinding.instance.addPostFrameCallback((_) =>
//         Provider.of<BookingParkingDetailProvider>(context, listen: false)
//             .init(context: context, seatId: widget.routeModel.seatBookingId));
//     super.initState();
//   }

//   DateFormat sdfOriginal = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ");
//   DateFormat sdfBookedOn = DateFormat(" ':' MMM dd, yyyy, 'at' HH:mma");
//   DateFormat sdfBookingDateAndTime = DateFormat(" ':' MMM dd, yyyy");

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CommonAppBar(
//         title: 'Booking Details',
//         leadingCallback: () {
//           if (widget.routeModel.isFromNoti) {
//             Navigator.pushNamedAndRemoveUntil(
//                 context, Routes.homeScreen, (route) => false);
//           } else {
//             Navigator.pop(context);
//           }
//         },
//       ),
//       // appBar: AppBar(
//       //   leading: InkWell(
//       //     onTap: () {
//       //       if (widget.routeModel.isFromNoti) {
//       //         Navigator.pushNamedAndRemoveUntil(
//       //             context, Routes.homeScreen, (route) => false);
//       //       } else {
//       //         Navigator.pop(context);
//       //       }
//       //     },
//       //     child: const Icon(Icons.arrow_back),
//       //   ),
//       //   title: const Center(
//       //     child: Text(
//       //       'Booking Details',
//       //       style: TextStyle(
//       //         color: Colors.black,
//       //       ),
//       //     ),
//       //   ),
//       // ),
//       body: Consumer<BookingParkingDetailProvider>(
//         builder: (_, state, child) {
//           if (state.seatBooking == null) {
//             return Container();
//           }
//           return SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 if (state.seatBooking != null)
//                   _buildHeaderImage(
//                     seatImageUrl: state.seatBooking!.parkingImageUrl,
//                     categoryName: state.seatBooking!.categoryName,
//                     bookingId: state.seatBooking!.id.toString(),
//                     status: state.seatBooking!.status,
//                   ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 30, right: 30),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const SizedBox(
//                         height: 30,
//                       ),
//                       if (state.seatBooking != null &&
//                           state.seatBooking!.categoryName != null)
//                         Text(
//                           state.seatBooking!.categoryName!,
//                           style: const TextStyle(
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       const SizedBox(
//                         height: 15,
//                       ),
//                       if (state.seatBooking != null &&
//                           state.seatBooking!.createdAt != null)
//                         _buildBookedOnWidget(
//                             bookedOnDate: state.seatBooking!.createdAt!),
//                       const SizedBox(
//                         height: 8,
//                       ),
//                       if (state.seatBooking != null &&
//                           state.seatBooking!.bookingDate != null)
//                         _buildBookedDateWidget(
//                             bookedDate: state.seatBooking!.bookingDate!),
//                       const SizedBox(
//                         height: 8,
//                       ),
//                     ],
//                   ),
//                 ),
//                 if (state.seatBooking != null)
//                   _buildLoactionWidget(
//                       buildingName: state.seatBooking!.buildingName ?? '',
//                       floorName: state.seatBooking!.floorName ?? ''),
//                 if (state.seatBooking != null)
//                   _buildSeatSlotWidget(booking: state.seatBooking!),
//                 const SizedBox(
//                   height: 8,
//                 ),
//                 _buildLoginInfoList(state: state),
//                 // if (state.seatBooking != null &&
//                 //     state.seatBooking!.bookingDate != null)
//                 //   Row(
//                 //     children: [
//                 //       _buildButton(
//                 //         title: 'CHECK IN',
//                 //         color: spaceManagementCheckinButtonColor,
//                 //         onTap: () {
//                 //           int? slotId = SpaceManagementUtils
//                 //               .setParkingVisibilityOfCheckInCheckOut(
//                 //                   true, state.seatBooking!);
//                 //           if (slotId != null && state.seatBooking!.id != null) {
//                 //             state.onCheckInClick(
//                 //                 context: context,
//                 //                 slotId: slotId,
//                 //                 bookingId: state.seatBooking!.id!.toString());
//                 //           }
//                 //         },
//                 //         booking: state.seatBooking!,
//                 //         buttonType: SpaceManagementButtonType.checkIn,
//                 //       ),
//                 //     ],
//                 //   ),
//                 // if (state.seatBooking != null &&
//                 //     state.seatBooking!.bookingDate != null)
//                 //   Row(
//                 //     children: [
//                 //       _buildButton(
//                 //         title: 'CHECK Out',
//                 //         color: spaceManagementCheckoutButtonColor,
//                 //         onTap: () {
//                 //           int? slotId = SpaceManagementUtils
//                 //               .setVisibilityOfCheckInCheckOut(
//                 //                   true, state.seatBooking!);
//                 //           SeatBookingAttendance? currentAttendance =
//                 //               SpaceManagementUtils.getCurrentAttendance(
//                 //                   state.seatBooking!);
//                 //           if (slotId != null &&
//                 //               state.seatBooking!.id != null &&
//                 //               currentAttendance != null) {
//                 //             String attendanceId =
//                 //                 currentAttendance.id.toString();
//                 //             String workLog = '';
//                 //             state.onCheckOutClick(
//                 //                 context: context,
//                 //                 attendanceId: attendanceId,
//                 //                 workLog: workLog,
//                 //                 bookingId: slotId.toString());
//                 //           }
//                 //         },
//                 //         booking: state.seatBooking!,
//                 //         buttonType: SpaceManagementButtonType.checkOut,
//                 //       ),
//                 //     ],
//                 //   ),
//               ],
//             ),
//           );
//         },
//       ),
//       bottomNavigationBar: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           if (Provider.of<BookingParkingDetailProvider>(context, listen: true)
//                   .seatBooking !=
//               null)
//             Row(
//               children: [
//                 _buildButton(
//                   title: 'CANCEL',
//                   color: '#FF0000',
//                   textColor: '#FFFFFF',
//                   onTap: () async {
//                     if (Provider.of<BookingParkingDetailProvider>(context,
//                                 listen: false)
//                             .seatBooking ==
//                         null) {
//                       showToastDialog(msg: 'Unable to Cancel!');
//                       return;
//                     }
//                     Provider.of<BookingParkingDetailProvider>(context,
//                             listen: false)
//                         .onCancelClicked(
//                             context: context,
//                             booking: Provider.of<BookingParkingDetailProvider>(
//                                     context,
//                                     listen: false)
//                                 .seatBooking!);
//                   },
//                   booking: Provider.of<BookingParkingDetailProvider>(context,
//                           listen: true)
//                       .seatBooking!,
//                   buttonType: SpaceManagementButtonType.cancel,
//                 ),
//                 _buildButton(
//                   title: 'RESCHEDULE',
//                   color: newUiPrimaryBlue,
//                   textColor: '#FFFFFF',
//                   onTap: () {
//                     Navigator.pushNamed(
//                       context,
//                       Routes.bookParkingDateAndSlot,
//                       arguments: BookParkingDateAndSlotRouteModel(
//                         isForRescheduling: true,
//                         mSeatBooking: Provider.of<BookingParkingDetailProvider>(
//                                 context,
//                                 listen: false)
//                             .seatBooking!,
//                       ),
//                     );
//                   },
//                   booking: Provider.of<BookingParkingDetailProvider>(context,
//                           listen: true)
//                       .seatBooking!,
//                   buttonType: SpaceManagementButtonType.reschedule,
//                 )
//               ],
//             ),
//         ],
//       ),
//     );
//   }

//   Widget _buildHeaderImage({
//     String? seatImageUrl,
//     String? categoryName,
//     String? bookingId,
//     String? status,
//   }) {
//     String assetsImage = 'assets/space_management/seat_category_images/';
//     String assetsName = 'default_cabin_big';
//     switch (categoryName ?? '') {
//       case 'Cabin':
//         assetsName = 'static_cabin';
//         break;
//       case 'Fixed desk':
//         assetsName = 'static_fixed_desk';
//         break;
//       case 'Fixed':
//         assetsName = 'static_fixed_desk';
//         break;
//       case 'Flexi desk':
//         assetsName = 'static_flexi_desk';
//         break;
//       case 'hot desk':
//         assetsName = 'static_hot_desk';
//         break;
//       case 'Linear WS':
//         assetsName = 'static_linear_ws';
//         break;
//       case 'Linear':
//         assetsName = 'static_linear_ws';
//         break;
//       case 'Angular WS':
//         assetsName = 'static_angular_ws1';
//         break;
//       case 'Angular':
//         assetsName = 'static_angular';
//         break;
//       case 'Common':
//         assetsName = 'static_common1';
//         break;
//       default:
//     }
//     return Stack(
//       children: [
//         Image.asset('assets/space_management/ic_space_detail_background.png'),
//         FractionalTranslation(
//           translation: const Offset(0.0, 0.2),
//           child: Row(
//             children: [
//               seatImageUrl != null
//                   ? Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Image.network(
//                         seatImageUrl,
//                         fit: BoxFit.fill,
//                         width: 100,
//                         height: 100,
//                       ),
//                     )
//                   : Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Image.asset(
//                         '$assetsImage$assetsName.png',
//                         fit: BoxFit.fill,
//                         width: 100,
//                         height: 100,
//                       ),
//                     ),
//               Text(
//                 'Booking ID: #$bookingId',
//                 style: const TextStyle(
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         Positioned(
//           top: 0,
//           right: 0,
//           child: Label(
//             triangleHeight: 18.0,
//             edge: Edge.LEFT,
//             child: Container(
//               padding: const EdgeInsets.only(
//                   left: 8.0, right: 18.0, top: 4.0, bottom: 4.0),
//               color: HexColor(
//                   SpaceManagementUtils.getStatusColor(status: status ?? '')),
//               child: Padding(
//                 padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
//                 child: Text(
//                   status == null ? '' : status.toUpperCase(),
//                   style: const TextStyle(
//                     fontSize: 12,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildBookedOnWidget({
//     required String bookedOnDate,
//   }) {
//     String date = '';
//     try {
//       DateTime dBookedOn = sdfOriginal.parse(bookedOnDate);
//       date = sdfBookedOn.format(dBookedOn);
//     } catch (e) {
//       logError(msg: e);
//     }
//     return Row(
//       children: [
//         const Text(
//           'Booked On: ',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         Text(
//           date,
//           style: const TextStyle(
//             fontSize: 13,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildBookedDateWidget({
//     required String bookedDate,
//   }) {
//     String date = '';
//     try {
//       DateFormat sdfYyyyMmDd = DateFormat("yyyy-MM-dd");
//       DateTime dBookingDateOriginal = sdfYyyyMmDd.parse(bookedDate);
//       date = sdfBookingDateAndTime.format(dBookingDateOriginal);
//     } catch (e) {
//       logError(msg: e);
//     }
//     return Row(
//       children: [
//         const Text(
//           'Booking Date: ',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         Text(
//           date,
//           style: const TextStyle(
//             fontSize: 13,
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildLoactionWidget({
//     required String buildingName,
//     required String floorName,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 30, right: 30, top: 8, bottom: 8),
//       child: Row(
//         children: [
//           const Text(
//             'Location: ',
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           Text(
//             '$buildingName/$floorName',
//             style: const TextStyle(
//               fontSize: 13,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSeatSlotWidget({
//     required ParkingSeatBooking booking,
//   }) {
//     List<ShowSchedule>? showSchedule =
//         booking.showSchedule != null ? [booking.showSchedule!] : [];

//     DateFormat sdfBookingDate = DateFormat("yyyy-MM-dd");
//     String sBookingDate = booking.bookingDate!;
//     DateTime? dBookingDate;
//     try {
//       dBookingDate = sdfBookingDate.parse(sBookingDate);
//     } catch (e) {
//       logError(msg: e);
//     }

//     if (dBookingDate != null &&
//         showSchedule != null &&
//         showSchedule.isNotEmpty) {
//       return Container(
//         decoration: BoxDecoration(
//           color: Colors.grey[200]!,
//         ),
//         child: Padding(
//           padding: const EdgeInsets.fromLTRB(0, 8, 30, 8),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               ..._buildSeatSlotsList(
//                   showSchedule: showSchedule, booking: booking),
//             ],
//           ),
//         ),
//       );
//     } else {
//       return Container();
//     }
//   }

//   List<Widget> _buildSeatSlotsList({
//     required List<ShowSchedule> showSchedule,
//     required ParkingSeatBooking booking,
//   }) {
//     List<Widget> list = [];

//     for (var item in showSchedule) {
//       String sSeatNumber = item.seat ?? '';
//       String sBookingDateAndTime = item.slot ?? '';
// //        String sTowerFloor=booking.getBuildingName()+"/"+booking.getFloorName();

//       String sBookingDateAndTimeUpdated =
//           sBookingDateAndTime.replaceAll("AM", "am").replaceAll("PM", "pm");

//       list.add(Row(
//         children: [
//           if (Provider.of<BookingParkingDetailProvider>(context, listen: true)
//               .isCancelPressed)
//             Checkbox(
//               value: item.isChecked,
//               onChanged: (value) {
//                 if (value == null) {
//                   showToastDialog(
//                       msg: 'Something went wrong please try again later');
//                   return;
//                 }
//                 Provider.of<BookingParkingDetailProvider>(context,
//                         listen: false)
//                     .onCancelSlotCheckBoxClicked(
//                         showSchedule: item, value: value);
//               },
//             )
//           else
//             const SizedBox(
//               width: 30,
//             ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 sSeatNumber,
//                 style: const TextStyle(
//                   // fontSize: 10,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               Row(
//                 children: [
//                   const Text(
//                     'Parking No.',
//                     style: TextStyle(
//                       color: Colors.grey,
//                     ),
//                   ),
//                   InkWell(
//                     onTap: () => Navigator.pushNamed(
//                         context, Routes.webViewScreen,
//                         arguments: booking.floorPlanAttachment),
//                     child: const Icon(
//                       Icons.error_outline,
//                       color: Colors.red,
//                       size: 15,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           const SizedBox(
//             width: 10,
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 sBookingDateAndTimeUpdated,
//                 style: const TextStyle(
//                   // fontSize: 10,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const Text(
//                 'Booking Time',
//                 style: TextStyle(
//                   color: Colors.grey,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ));
//     }

//     return list;
//   }

//   Widget _buildLoginInfoList({
//     required BookingParkingDetailProvider state,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(30, 8, 30, 8),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Text(
//             'Login Information',
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           if (state.seatBooking != null &&
//               state.seatBooking!.attendance != null &&
//               state.seatBooking!.attendance!.isNotEmpty)
//             ..._buildLoginInfoItems(attendance: state.seatBooking!.attendance!),
//         ],
//       ),
//     );
//   }

//   List<Widget> _buildLoginInfoItems({
//     required List<SeatBookingAttendance> attendance,
//   }) {
//     List<Widget> list = [];

//     for (var item in attendance) {
//       DateFormat sdfc = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ");
//       DateFormat sdfHhMmA = DateFormat("HH:mm a");
//       String sInData = "", sOutData = "", sSlot = "";
//       try {
//         if (item.punchedInAt != null) {
//           DateTime dInData = sdfc.parse(item.punchedInAt!);
//           sInData = sdfHhMmA.format(dInData);
//         }

//         if (item.punchedOutAt != null) {
//           DateTime dOutData = sdfc.parse(item.punchedOutAt!);
//           sOutData = sdfHhMmA.format(dOutData);
//         }
//       } catch (e) {
//         logError(msg: e);
//       }
//       List<ShowSchedule>? showSchedule = item.showSchedule;
//       if ((showSchedule != null) && (showSchedule.isNotEmpty)) {
//         ShowSchedule schedule = showSchedule[0];
//         sSlot = schedule.slot ?? '';
//       }
//       list.add(Padding(
//         padding: const EdgeInsets.only(top: 8),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             if (sInData.isNotEmpty)
//               Container(
//                 decoration: BoxDecoration(
//                   border: Border.all(),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Row(
//                     children: [
//                       Text(sSlot),
//                       const Spacer(),
//                       const Text(
//                         'IN',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Text(
//                         sInData,
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             if (sOutData.isNotEmpty)
//               Container(
//                 decoration: BoxDecoration(
//                   border: Border.all(),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Row(
//                     children: [
//                       Text(sSlot),
//                       const Spacer(),
//                       const Text(
//                         'OUT',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Text(
//                         sOutData,
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ));
//     }

//     return list;
//   }

//   Widget _buildButton({
//     required String title,
//     required String color,
//     required VoidCallback onTap,
//     required ParkingSeatBooking booking,
//     required SpaceManagementButtonType buttonType,
//     String? textColor,
//   }) {
//     bool showButton = false;

//     DateTime now = DateFormat('yyyy-MM-dd').parse(DateTime.now().toString());
//     DateTime tempDate = DateFormat('yyyy-MM-dd').parse(booking.bookingDate!);

//     if (tempDate.toUtc().isBefore(now.toUtc())) {
//       //if  date is before today, hide reschedule, check-in and checkout buttons
//       showButton = false;
//     } else {
//       SeatBookingAttendance? currentAttendance =
//           SpaceManagementUtils.getParkingCurrentAttendance(booking);
//       if (currentAttendance != null &&
//           (currentAttendance.punchedInAt != null &&
//               currentAttendance.punchedInAt!.isNotEmpty)) {
//         //else if checkin detail is present in seatbooking object, hide only reschedule and check-in buttons and display checkout button
//         if (buttonType == SpaceManagementButtonType.reschedule ||
//             buttonType == SpaceManagementButtonType.checkIn ||
//             buttonType == SpaceManagementButtonType.cancel) {
//           showButton = false;
//         } else {
//           showButton = true;
//         }
//         bool isCheckOutDetailsPresent =
//             (currentAttendance.punchedOutAt != null &&
//                 currentAttendance.punchedOutAt!.isNotEmpty);
//         if (buttonType == SpaceManagementButtonType.checkOut &&
//             isCheckOutDetailsPresent) {
//           showButton = false;
//         }
//       } else {
//         //else if above condition fails,
//         if (booking.showSchedule != null) {
//           String slot = booking.showSchedule!.slot ?? '';
//           String sStartTimeWithoutDate = slot.split(" to ")[0];

//           try {
//             DateFormat sdf = DateFormat("yyyy-MM-dd HH:mm a");
//             DateTime dStartTime =
//                 sdf.parse('${booking.bookingDate} ' + sStartTimeWithoutDate);
//             DateTime dStartTimeNew = dStartTime;

// //            if (new Date().before(dStartTime)) {
//             if (DateTime.now().isBefore(dStartTimeNew)) {
//               //  check if current time is before start time. if yes, show reschedule and checkin buttons. Hide checkout button
//               //Reschedule Button
//               if (buttonType == SpaceManagementButtonType.reschedule) {
//                 if (booking.status != null) {
//                   if (booking.status!.trim().toLowerCase() == 'confirmed') {
//                     showButton = true;
//                   } else {
//                     showButton = false;
//                   }
//                 } else {
//                   showButton = false;
//                 }
//               }

//               //CheckIN Button
//               if (buttonType == SpaceManagementButtonType.checkIn) {
//                 showButton = true;
//               }

//               //CheckOut Button
//               if (buttonType == SpaceManagementButtonType.checkOut) {
//                 showButton = false;
//               }

//               //Cancel Button
//               if (buttonType == SpaceManagementButtonType.cancel) {
//                 showButton = true;
//               }
//             } else {
//               // else show only checkin button and hide reschedule and checkout buttons

//               if (buttonType == SpaceManagementButtonType.reschedule ||
//                   buttonType == SpaceManagementButtonType.checkOut ||
//                   buttonType == SpaceManagementButtonType.cancel) {
//                 showButton = false;
//               }
//               if (buttonType == SpaceManagementButtonType.checkIn) {
//                 showButton = true;
//               }
//             }
//           } catch (e) {
//             logError(msg: e);
//           }
//         } else {
//           //Reschedule Button
//           if (buttonType == SpaceManagementButtonType.reschedule) {
//             if (booking.status != null) {
//               if (booking.status!.trim().toLowerCase() == 'confirmed') {
//                 showButton = true;
//               } else {
//                 showButton = false;
//               }
//             } else {
//               showButton = false;
//             }
//           }

//           //CheckIN Button
//           if (buttonType == SpaceManagementButtonType.checkIn) {
//             showButton = true;
//           }

//           //CheckOut Button
//           if (buttonType == SpaceManagementButtonType.checkOut) {
//             showButton = false;
//           }

//           //Cancel Button
//           if (buttonType == SpaceManagementButtonType.cancel) {
//             showButton = false;
//           }
//         }
//       }
//       if (buttonType == SpaceManagementButtonType.checkIn) {
//         if (!Utils.isToday(date: tempDate) && showButton) {
//           showButton = false;
//         }
//       }
//     }

//     if (booking.status != null &&
//         booking.status!.toLowerCase() == 'cancelled') {
//       showButton = false;
//     }

//     //CheckIn Button
//     int? iCurrentVisibleSlotId =
//         SpaceManagementUtils.setParkingVisibilityOfCheckInCheckOut(
//             showButton, booking);
//     if (buttonType == SpaceManagementButtonType.checkIn) {
//       if (iCurrentVisibleSlotId != null) {
//         showButton = true;
//       } else {
//         showButton = false;
//       }
//     } else {
//       if (iCurrentVisibleSlotId != null) {
//         //New Logic to set Cancel and Resuchedule button false
//         if (buttonType == SpaceManagementButtonType.cancel ||
//             buttonType == SpaceManagementButtonType.reschedule) {
//           showButton = false;
//         }
//       }
//     }

//     if (booking.status != null &&
//         booking.status!.trim().toLowerCase() == 'waiting') {
//       showButton = false;
//     }

//     if (showButton) {
//       return Expanded(
//         child: InkWell(
//           onTap: onTap,
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Container(
//               color: HexColor(color),
//               child: Padding(
//                 padding: const EdgeInsets.all(6.0),
//                 child: Center(
//                   child: Text(
//                     title,
//                     style: TextStyle(
//                       color: textColor != null
//                           ? HexColor(textColor)
//                           : Colors.black,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       );
//     } else {
//       return Container();
//     }
//   }
// }
