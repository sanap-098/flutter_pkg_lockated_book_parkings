import 'package:flutter/material.dart';
import 'package:flutter_pkg_lockated_book_parking/features/screens/parking/book_parking_summary_screen/widgets/dialogs/book_parking_summary_time_slot_grid_widget.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

// Utils
import 'package:flutter_pkg_lockated_book_parking/utils/prefs.dart';

// Widgets
import 'package:flutter_pkg_lockated_book_parking/widgets/common/common_app_bar.dart';
import 'package:flutter_pkg_lockated_book_parking/widgets/common/common_button.dart';

// Providers
import 'package:flutter_pkg_lockated_book_parking/features/providers/parking_booking/parking_booking_create_provider.dart';

// Screens
import 'package:flutter_pkg_lockated_book_parking/features/screens/parking/book_parking_successful_reservation_screen/book_parking_successful_reservation_screen.dart';


class BookParkingSummaryScreen extends StatelessWidget {
  const BookParkingSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(
        title: 'Booking Summary',
      ),
      // appBar: AppBar(
      //   backgroundColor: Colors.white,

      //   leading: InkWell(
      //     onTap: () {
      //       // showDialog(
      //       //   context: context,
      //       //   builder: (context) {
      //       //     return const ParkingCancelDialog();
      //       //   },
      //       // ).then((value) {
      //       //   if (value as bool == true) {
      //       //     Navigator.pop(context);
      //       //   }
      //       // });
      //       // if (widget.isFromNoti) {
      //       //   Navigator.pushNamedAndRemoveUntil(
      //       //       context, Routes.homeScreen, (route) => false);
      //       // } else {
      //       Navigator.pop(context);
      //       // }
      //     },
      //     child: const Icon(Icons.arrow_back_ios),
      //   ),

      //   title: const Center(
      //     child: Text(
      //       'Booking Summary',
      //       style: TextStyle(
      //         color: Colors.black,
      //       ),
      //     ),
      //   ),
      //   centerTitle: true,
      //   // actions: [
      //   //   // InkWell(
      //   //   //   onTap: () {
      //   //   //     Navigator.popAndPushNamed(
      //   //   //         context, Routes.parkingManagementBookingsAndRequestScreen);
      //   //   //   },
      //   //   //   child: const Icon(Icons.list),
      //   //   // ),
      //   // ],
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Image.asset('assets/transport/parking_car.png',
            package: 'flutter_pkg_lockated_book_parking',),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: const BorderSide(color: Color(0xffC72030))),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildKVPair(
                          key: 'Parking Allocated',
                          value:
                              '${context.read<ParkingBookingCreateProvider>().selectedBuilding?.name ?? 'NA'} - ${context.read<ParkingBookingCreateProvider>().selectedFloor?.name ?? 'NA'}'),
                      // _buildKVPair(key: 'Parking Slot', value: '15'),
                      _buildKVPair(
                          key: 'Vehicle type',
                          value: context
                                  .read<ParkingBookingCreateProvider>()
                                  .selectedParkingCategory
                                  ?.name ??
                              'NA'),
                      // const Text(
                      //   "TIme Slots",
                      //   style: TextStyle(
                      //       fontWeight: FontWeight.bold, fontSize: 14),
                      // ),
                      const BookParkingSummaryTimeSlotGridWidget(),
                      if (context
                              .watch<ParkingBookingCreateProvider>()
                              .currentRangeValues !=
                          null)
                        _buildKVPair(
                            key: 'Time Range',
                            value:
                                '${context.read<ParkingBookingCreateProvider>().currentRangeValues!.start.toInt()}:00 hrs - ${context.read<ParkingBookingCreateProvider>().currentRangeValues!.end.toInt()}:00 hrs'),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 100,
            )
          ],
        ),
      ),
      bottomSheet: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              CommonButton(
                title: 'Book Parking',
                backgroundColor: HexColor('#EC2B3E'),
                customColor: HexColor('#EC2B3E'),
                useCustomColor: true,
                shouldShowArrow: true, 
                borderRadius: BorderRadius.circular(5),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: const BorderSide(color: Colors.white, width: 2),
                  ),
                ),
                onTap: () async {
                  final response = await context
                      .read<ParkingBookingCreateProvider>()
                      .bookParking(parentContext: context);
                  if (response != null) {
                    await Prefs.setParkingAutoCheckInDate('');
                    await Prefs.setParkingAutoCheckedIn(false);
                    await Prefs.setParkingAutoCheckedOut(false);
                    if (context.mounted) {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return BookParkingSuccessfulReservationScreen(
                            parkingDetails: response,
                          );
                        },
                      )).then((value) {
                        Navigator.pop(context, true);
                      });
                    }
                  }

                  // Navigator.push(context, MaterialPageRoute(
                  //   builder: (context) {
                  // return const BookParkingSuccessfulReservationScreen();
                  //   },
                  // ));
                  // await showDialog(context: context, builder:(context) {
                  //   return BookParkingLoadingDialog();
                  // },);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildKVPair({required String key, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    key,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Text(
                    ' : ',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                  // fontWeight: FontWeight.bold
                  fontSize: 14),
            ),
          )
        ],
      ),
    );
  }
}
