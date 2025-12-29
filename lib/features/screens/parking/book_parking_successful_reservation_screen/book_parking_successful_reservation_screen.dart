import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_pkg_lockated_book_parking/utils/constants.dart';
import 'package:flutter_pkg_lockated_book_parking/widgets/common/image_card_widget.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/parking_booking/parking_booking_book_parking/parking_booking_book_parking_response_model/parking_booking_book_parking_response_model.dart';

class BookParkingSuccessfulReservationScreen extends StatelessWidget {
  final ParkingBookingBookParkingResponseModel parkingDetails;
  const BookParkingSuccessfulReservationScreen({
    super.key,
    required this.parkingDetails,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
              colors: [
                HexColor('#E95420'),
                HexColor('#77216F'),
              ],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                if (parkingDetails.qrCodeUrl != null &&
                    parkingDetails.qrCodeUrl!.isNotEmpty)
                  const SizedBox(
                    height: 25,
                  ),
                Container(
                  height: (parkingDetails.qrCodeUrl != null &&
                          parkingDetails.qrCodeUrl!.isNotEmpty)
                      ? null
                      : MediaQuery.of(context).size.height,
                  width: (parkingDetails.qrCodeUrl != null &&
                          parkingDetails.qrCodeUrl!.isNotEmpty)
                      ? null
                      : MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: (parkingDetails.qrCodeUrl != null &&
                              parkingDetails.qrCodeUrl!.isNotEmpty)
                          ? MainAxisAlignment.start
                          : MainAxisAlignment.center,
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Card(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20,
                                        right: 20,
                                        bottom: 20,
                                        top: 40),
                                    child: Column(
                                      children: [
                                        Container(
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.green),
                                          height: 50,
                                          width: 50,
                                          child: const Icon(
                                            Icons.check,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Text(
                                          // 'Parking slot has been reserved successfully for your 4 Wheeler',
                                          'Parking slot has been reserved successfully for your ${parkingDetails.categoryName}',
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                  const Divider(
                                    thickness: 2,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Center(
                                                child: Text(
                                                  'Level',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color:
                                                          HexColor('#818181')),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                // 'Tower 3 - B1',
                                                '${parkingDetails.buildingName ?? 'NA'} - ${parkingDetails.floorName ?? 'NA'}',
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Center(
                                                child: Text(
                                                  'Slot',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color:
                                                          HexColor('#818181')),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                // '15',
                                                parkingDetails.showSchedule
                                                        ?.parkingNumber ??
                                                    'NA',
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Center(
                                                child: Text(
                                                  'Booking ID',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      color:
                                                          HexColor('#818181')),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Text(
                                                // '15',
                                                parkingDetails.id?.toString() ??
                                                    'NA',
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Positioned(
                              top: -20,
                              left: 0,
                              right: 0,
                              // child: ImageCardWidget(
                              //   image: parkingDetails.parkingImageUrl,
                              //   height: 10,
                              //   radius: BorderRadius.zero,
                              //   width: 25,
                              //   padding: 0,
                              // ),
                              child: Image.asset(
                                (parkingDetails.categoryName != null &&
                                        parkingDetails.categoryName!
                                            .contains('4'))
                                    ? 'assets/transport/parking_car_icon.png'
                                    : 'assets/transport/parking_scooter_mini_icon.png',
                                    package: 'flutter_pkg_lockated_book_parking',
                                height: 50,
                              ),
                            ),
                            Positioned(
                              top: -10,
                              right: -10,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey
                                              .withValues(alpha: 0.5),
                                          // spreadRadius: 0.5,
                                          // blurRadius: 1,

                                          //Alternate values
                                          spreadRadius: 1,
                                          blurRadius: 2,
                                          // offset: Offset(0,
                                          //     1), // changes position of shadow
                                        ),
                                      ]),
                                  child: const Icon(Icons.close),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                if (parkingDetails.qrCodeUrl != null &&
                    parkingDetails.qrCodeUrl!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Card(
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                // Text(
                                //   // 'Booking ID - 13Jun_T3_B1/15',
                                //   'Booking ID - ${parkingDetails.id}',
                                //   style: TextStyle(
                                //       fontSize: 14,
                                //       fontWeight: FontWeight.bold,
                                //       color: HexColor('262626')),
                                // ),
                                // const SizedBox(
                                //   height: 15,
                                // ),
                                ImageCardWidget(
                                  image: parkingDetails.qrCodeUrl,
                                ),
                                // QrImage(
                                //   padding: EdgeInsets.zero,
                                //   data: 'Booking ID - 13Jun_T3_B1/15',
                                //   version: QrVersions.auto,
                                //   size: 200,
                                // ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 40),
                                  child: Container(
                                    decoration: DottedDecoration(
                                      shape: Shape.line,
                                      linePosition: LinePosition.top,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Text(
                                  'Scan barcode at entry & exits for successful check in & check out respectively.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 14, color: HexColor('#818181')),
                                ),
                                const SizedBox(
                                  height: 30,
                                )
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 110,
                          left: -20,
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                color: HexColor(secondaryColor),
                                shape: BoxShape.circle),
                          ),
                        ),
                        Positioned(
                          bottom: 110,
                          right: -20,
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                color: HexColor(primaryColor),
                                shape: BoxShape.circle),
                          ),
                        ),
                        Positioned(
                          bottom: -25,
                          left: 0,
                          right: 0,
                          child: Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: HexColor(secondaryColor),
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: Colors.white, width: 1.5)),
                            child: Center(
                              child: Image.asset(
                                'assets/transport/business_card_send_icon.png',
                                package: 'flutter_pkg_lockated_book_parking',
                                height: 20,
                                width: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(
                  height: 100,
                )
              ],
            ),
          )),
    );
  }
}
