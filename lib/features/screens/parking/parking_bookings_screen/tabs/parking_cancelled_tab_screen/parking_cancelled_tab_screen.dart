import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../providers/parking_booking/parking_booking_provider.dart';
import '../parking_my_bookings_tab_screen/widgets/parking_my_bookings_list/parking_my_bookings_list_widget.dart';

class ParkingCancelledTabScreen extends StatelessWidget {
  const ParkingCancelledTabScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // return Column(
    //   children: [parkingListItem()],
    // );
    // logInfo(msg: msg)
    return Consumer<ParkingBookingProvider>(
      builder: (context, state, child) {
        return Column(
          children: [
            state.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : state.cancelledBookings.isNotEmpty
                    ? Expanded(
                        child: ParkingMyBookingsListWidget(
                          myBookings: state.cancelledBookings,
                          isExpired: true,
                        ),
                      )
                    : const Expanded(
                        child: Center(
                          child: Text('No Data Available'),
                        ),
                      )
          ],
        );
      },
    );
  }

  // Widget parkingListItem({bool isExpired = false, bool isBikeIcon = false}) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 7.5, horizontal: 20),
  //     child: Stack(
  //       children: [
  //         Card(
  //           margin: EdgeInsets.zero,
  //           color: Colors.white,
  //           shape: RoundedRectangleBorder(
  //               side: BorderSide(color: HexColor(ticketTabColor)),
  //               borderRadius: BorderRadius.circular(5)),
  //           child: Stack(
  //             children: [
  //               Positioned(
  //                 top: 40,
  //                 left: 40,
  //                 right: 0,
  //                 child: Transform.rotate(
  //                   angle: -0.3,
  //                   child: Text(
  //                     'Parking Cancelled',
  //                     style: TextStyle(
  //                         color: HexColor('#EE2737').withOpacity(0.2),
  //                         fontSize: 35,
  //                         fontWeight: FontWeight.bold),
  //                   ),
  //                 ),
  //               ),
  //               Padding(
  //                 padding: const EdgeInsets.all(15.0),
  //                 child: Column(
  //                   children: [
  //                     Row(
  //                       children: [
  //                         Image.asset(
  //                           isBikeIcon
  //                               ? 'assets/transport/parking_scooter_mini_icon.png'
  //                               : 'assets/transport/parking_car_icon.png',
  //                           height: 20,
  //                         ),
  //                         Expanded(
  //                           child: Center(
  //                             child: Text(
  //                               'Parking Level B3',
  //                               style: TextStyle(
  //                                   fontSize: 14,
  //                                   fontWeight: FontWeight.bold,
  //                                   color:
  //                                       isExpired ? HexColor('#9FA5AD') : null),
  //                             ),
  //                           ),
  //                         ),
  //                         Text(
  //                           'Slot No 15',
  //                           style: TextStyle(
  //                               fontSize: 14,
  //                               fontWeight: FontWeight.bold,
  //                               color: isExpired ? HexColor('#9FA5AD') : null),
  //                         )
  //                       ],
  //                     ),
  //                     const SizedBox(
  //                       height: 20,
  //                     ),
  //                     Padding(
  //                       padding: const EdgeInsets.symmetric(horizontal: 10),
  //                       child: Row(
  //                         children: [
  //                           Text(
  //                             'June 13, 2023\n09:00 am',
  //                             style: TextStyle(
  //                                 fontSize: 12,
  //                                 color:
  //                                     isExpired ? HexColor('#9FA5AD') : null),
  //                           ),
  //                           Expanded(
  //                             child: Image.asset(
  //                               isExpired
  //                                   ? 'assets/transport/parking_arrow_disable_icon.png'
  //                                   : 'assets/transport/parking_arrow_icon.png',
  //                               // height: ,
  //                             ),
  //                           ),
  //                           Text(
  //                             'June 13, 2023\n07:00 pm',
  //                             style: TextStyle(
  //                                 fontSize: 12,
  //                                 color:
  //                                     isExpired ? HexColor('#9FA5AD') : null),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                     const SizedBox(
  //                       height: 20,
  //                     ),
  //                     Container(
  //                       decoration: DottedDecoration(
  //                         shape: Shape.line,
  //                         linePosition: LinePosition.top,
  //                         color: Colors.black,
  //                       ),
  //                     ),
  //                     if (!isExpired)
  //                       Row(
  //                         children: [
  //                           TextButton(
  //                               style: const ButtonStyle(
  //                                   visualDensity: VisualDensity.compact),
  //                               onPressed: () {},
  //                               child: const Text(
  //                                 'Show QR Code',
  //                                 style: TextStyle(
  //                                     fontSize: 14, color: Colors.black),
  //                               )),
  //                           const Expanded(child: SizedBox()),
  //                           TextButton(
  //                               style: const ButtonStyle(
  //                                   visualDensity: VisualDensity.compact),
  //                               onPressed: () {},
  //                               child: Text(
  //                                 'Cancel Parking',
  //                                 style: TextStyle(
  //                                     fontSize: 14, color: HexColor('#EE2737')),
  //                               ))
  //                         ],
  //                       ),
  //                     if (isExpired)
  //                       Row(
  //                         mainAxisAlignment: MainAxisAlignment.center,
  //                         children: [
  //                           TextButton(
  //                               style: const ButtonStyle(
  //                                   visualDensity: VisualDensity.compact),
  //                               onPressed: null,
  //                               child: Text(
  //                                 'Expired',
  //                                 style: TextStyle(
  //                                     fontSize: 14, color: HexColor('#9FA5AD')),
  //                               )),
  //                         ],
  //                       ),
  //                   ],
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         Positioned(
  //           bottom: 35,
  //           left: -20,
  //           child: Container(
  //             height: 40,
  //             width: 40,
  //             decoration: BoxDecoration(
  //                 border: Border.all(color: HexColor(ticketTabColor)),
  //                 color: Colors.grey[50],
  //                 shape: BoxShape.circle),
  //           ),
  //         ),
  //         Positioned(
  //           bottom: 35,
  //           right: -20,
  //           child: Container(
  //             height: 40,
  //             width: 40,
  //             decoration: BoxDecoration(
  //                 border: Border.all(color: HexColor(ticketTabColor)),
  //                 color: Colors.grey[50],
  //                 shape: BoxShape.circle),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
