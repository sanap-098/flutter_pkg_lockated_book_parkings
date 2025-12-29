import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/parking_model/parking_seat_configuration_model/parking_seat_configuration_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/providers/parking_management/parking_management_fragment_provider.dart';
import 'package:flutter_pkg_lockated_book_parking/features/providers/parking_management/parking_management_provider.dart';
import 'package:flutter_pkg_lockated_book_parking/utils/constants.dart';
import 'package:flutter_pkg_lockated_book_parking/core/themes/theme_view_model.dart'; // Import

class ParkingManagementFixedBookingListWidget extends StatelessWidget {
  const ParkingManagementFixedBookingListWidget(
      {Key? key, this.isForRescheduling = false})
      : super(key: key);
  final bool isForRescheduling;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(width: 0.5, color: Colors.grey[400]!)),
        child: Column(
          children: [
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio:
                      (((MediaQuery.of(context).size.width - 16) / 2) / 120)),
              itemBuilder: (context, index) {
                final item = isForRescheduling
                    ? Provider.of<ParkingManagementFragmentProvider>(context,
                            listen: false)
                        .seatConfigurations[index]
                    : Provider.of<ParkingManagementProvider>(context,
                            listen: false)
                        .seatConfigurations[index];
                return _buildListItem(
                    item: item, context: context, index: index);
              },
              itemCount: isForRescheduling
                  ? Provider.of<ParkingManagementFragmentProvider>(context,
                                  listen: true)
                              .seatConfigurations
                              .length ==
                          3
                      ? 2
                      : Provider.of<ParkingManagementFragmentProvider>(context,
                              listen: true)
                          .seatConfigurations
                          .length
                  : Provider.of<ParkingManagementProvider>(context,
                                  listen: true)
                              .seatConfigurations
                              .length ==
                          3
                      ? 2
                      : Provider.of<ParkingManagementProvider>(context,
                              listen: true)
                          .seatConfigurations
                          .length,
            ),
            _buildThirdItem(context),
          ],
        ),
      ),
    );
  }

  Widget _buildThirdItem(BuildContext context) {
    final themeViewModel = context.watch<ThemeViewModel>();
    final colors = themeViewModel.colors;
    
    const index = 2;
    final count = isForRescheduling
        ? Provider.of<ParkingManagementFragmentProvider>(context, listen: true)
            .seatConfigurations
            .length
        : Provider.of<ParkingManagementProvider>(context, listen: true)
            .seatConfigurations
            .length;
    if (count == 3) {
      final item = isForRescheduling
          ? Provider.of<ParkingManagementFragmentProvider>(context,
                  listen: true)
              .seatConfigurations[2]
          : Provider.of<ParkingManagementProvider>(context, listen: true)
              .seatConfigurations[2];
      return Row(
        children: [
          Expanded(
            child: Row(
              children: [
                if (index == 1 || index == 3)
                  const Padding(
                    padding: EdgeInsets.only(
                      top: 20,
                      bottom: 20,
                    ),
                    child: VerticalDivider(
                      thickness: 2,
                    ),
                  ),
                Expanded(
                  child: Column(
                    children: [
                      if (index == 2 || index == 3)
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                          ),
                          child: Container(
                            color: Colors.grey[300],
                            height: 2,
                            width: 80,
                          ),
                        ),
                      InkWell(
                        onTap: () {
                          if (!isForRescheduling) {
                            Provider.of<ParkingManagementProvider>(context,
                                    listen: false)
                                .openBookSeatScreen(
                                    context: context, seatConfiguration: item);
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: colors.primaryColor, // Theme Primary Color
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      item.parkingCategory ?? 'Hot Desk',
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: _buildCountWidget(
                                      count: item.bookedParkings == null
                                          ? '0'
                                          : item.bookedParkings.toString(),
                                      title: 'Booked',
                                      color: colors.bookingsConfirmedStatusColor, // Theme Color
                                    ),
                                  ),
                                  Expanded(
                                    child: _buildCountWidget(
                                        count: item.availableParkings == null
                                            ? '0'
                                            : item.availableParkings.toString(),
                                        title: 'Available',
                                        color: colors.visitorsApprovedStatusColor), // Theme Color (Green-ish)
                                  ),
                                  Expanded(
                                    child: _buildCountWidget(
                                        count: item.totalParkings == null
                                            ? '0'
                                            : item.totalParkings.toString(),
                                        title: 'Total',
                                        color: Colors.grey), // Keep grey or use theme
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    } else {
      return Container();
    }
  }

  Widget _buildListItem({
    required ParkingSeatConfigurationModel item,
    required BuildContext context,
    required int index,
  }) {
    final themeViewModel = context.watch<ThemeViewModel>();
    final colors = themeViewModel.colors;

    return Row(
      children: [
        if (index == 1 || index == 3)
          const Padding(
            padding: EdgeInsets.only(
              top: 20,
              bottom: 20,
            ),
            child: VerticalDivider(
              thickness: 2,
            ),
          ),
        Column(
          children: [
            if (index == 2 || index == 3)
              Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: Container(
                  color: Colors.grey[300],
                  height: 2,
                  width: 80,
                ),
              ),
            InkWell(
              onTap: () {
                if (!isForRescheduling) {
                  Provider.of<ParkingManagementProvider>(context, listen: false)
                      .openBookSeatScreen(
                          context: context, seatConfiguration: item);
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: colors.primaryColor, // Theme Primary Color
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            item.parkingCategory ?? 'Hot Desk',
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildCountWidget(
                          count: item.bookedParkings == null
                              ? '0'
                              : item.bookedParkings.toString(),
                          title: 'Booked',
                          color: colors.bookingsConfirmedStatusColor, // Theme Color
                        ),
                        _buildCountWidget(
                            count: item.availableParkings == null
                                ? '0'
                                : item.availableParkings.toString(),
                            title: 'Available',
                            color: colors.visitorsApprovedStatusColor), // Theme Color
                        _buildCountWidget(
                            count: item.totalParkings == null
                                ? '0'
                                : item.totalParkings.toString(),
                            title: 'Total',
                            color: Colors.grey),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCountWidget(
      {required String count, required String title, required Color color}) {
    return Column(
      children: [
        Text(
          count,
          style: TextStyle(
            color: color,
          ),
        ),
        Text(title),
      ],
    );
  }
}




// import 'package:flutter/material.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter_pkg_lockated_book_parking/features/models/parking_model/parking_seat_configuration_model/parking_seat_configuration_model.dart';
// import 'package:flutter_pkg_lockated_book_parking/features/providers/parking_management/parking_management_fragment_provider.dart';
// import 'package:flutter_pkg_lockated_book_parking/features/providers/parking_management/parking_management_provider.dart';
// import 'package:flutter_pkg_lockated_book_parking/utils/constants.dart';

// class ParkingManagementFixedBookingListWidget extends StatelessWidget {
//   const ParkingManagementFixedBookingListWidget(
//       {Key? key, this.isForRescheduling = false})
//       : super(key: key);
//   final bool isForRescheduling;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Container(
//         decoration: BoxDecoration(
//             border: Border.all(width: 0.5, color: Colors.grey[400]!)),
//         child: Column(
//           children: [
//             GridView.builder(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   childAspectRatio:
//                       (((MediaQuery.of(context).size.width - 16) / 2) / 120)),
//               itemBuilder: (context, index) {
//                 final item = isForRescheduling
//                     ? Provider.of<ParkingManagementFragmentProvider>(context,
//                             listen: false)
//                         .seatConfigurations[index]
//                     : Provider.of<ParkingManagementProvider>(context,
//                             listen: false)
//                         .seatConfigurations[index];
//                 return _buildListItem(
//                     item: item, context: context, index: index);
//               },
//               itemCount: isForRescheduling
//                   ? Provider.of<ParkingManagementFragmentProvider>(context,
//                                   listen: true)
//                               .seatConfigurations
//                               .length ==
//                           3
//                       ? 2
//                       : Provider.of<ParkingManagementFragmentProvider>(context,
//                               listen: true)
//                           .seatConfigurations
//                           .length
//                   : Provider.of<ParkingManagementProvider>(context,
//                                   listen: true)
//                               .seatConfigurations
//                               .length ==
//                           3
//                       ? 2
//                       : Provider.of<ParkingManagementProvider>(context,
//                               listen: true)
//                           .seatConfigurations
//                           .length,
//               // ],
//             ),
//             _buildThirdItem(context),
//           ],
//         ),
//       ),
//     );
//   }

//   // List<Widget> _buildListItems(
//   //     {required List<ParkingSeatConfigurationModel> seatConfigurations}) {
//   //   List<Widget> list = [];

//   //   for (var item in seatConfigurations) {
//   //     list.add(Container(
//   //       height: 150,
//   //       decoration: BoxDecoration(
//   //         border: Border.all(width: 0.5, color: Colors.black),
//   //       ),
//   //       child: Column(
//   //         mainAxisSize: MainAxisSize.min,
//   //         children: [
//   //           Text(item.parkingCategory ?? 'Hot Desk'),
//   //           Row(
//   //             children: [
//   //               _buildCountWidget(count: '0', title: 'Booked', color: ''),
//   //               _buildCountWidget(count: '0', title: 'Available', color: ''),
//   //               _buildCountWidget(count: '0', title: 'Total', color: ''),
//   //             ],
//   //           ),
//   //         ],
//   //       ),
//   //     ));
//   //   }

//   //   return list;
//   // }

//   Widget _buildThirdItem(BuildContext context) {
//     const index = 2;
//     final count = isForRescheduling
//         ? Provider.of<ParkingManagementFragmentProvider>(context, listen: true)
//             .seatConfigurations
//             .length
//         : Provider.of<ParkingManagementProvider>(context, listen: true)
//             .seatConfigurations
//             .length;
//     if (count == 3) {
//       final item = isForRescheduling
//           ? Provider.of<ParkingManagementFragmentProvider>(context,
//                   listen: true)
//               .seatConfigurations[2]
//           : Provider.of<ParkingManagementProvider>(context, listen: true)
//               .seatConfigurations[2];
//       return Row(
//         children: [
//           Expanded(
//             child: Row(
//               children: [
//                 if (index == 1 || index == 3)
//                   const Padding(
//                     padding: EdgeInsets.only(
//                       top: 20,
//                       bottom: 20,
//                     ),
//                     child: VerticalDivider(
//                       thickness: 2,
//                     ),
//                   ),
//                 Expanded(
//                   child: Column(
//                     children: [
//                       if (index == 2 || index == 3)
//                         Padding(
//                           padding: const EdgeInsets.only(
//                             left: 20,
//                             right: 20,
//                           ),
//                           child: Container(
//                             color: Colors.grey[300],
//                             height: 2,
//                             width: 80,
//                           ),
//                         ),
//                       InkWell(
//                         onTap: () {
//                           if (!isForRescheduling) {
//                             Provider.of<ParkingManagementProvider>(context,
//                                     listen: false)
//                                 .openBookSeatScreen(
//                                     context: context, seatConfiguration: item);
//                           }
//                         },
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Column(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(10),
//                                     color: HexColor(
//                                         spaceManagementMainButtonColor),
//                                   ),
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Text(
//                                       item.parkingCategory ?? 'Hot Desk',
//                                       style: const TextStyle(
//                                         color: Colors.white,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Row(
//                                 // mainAxisSize: MainAxisSize.min,
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceEvenly,
//                                 children: [
//                                   Expanded(
//                                     child: _buildCountWidget(
//                                       count: item.bookedParkings == null
//                                           ? '0'
//                                           : item.bookedParkings.toString(),
//                                       title: 'Booked',
//                                       color: spaceManagementOrangeColor,
//                                     ),
//                                   ),
//                                   Expanded(
//                                     child: _buildCountWidget(
//                                         count: item.availableParkings == null
//                                             ? '0'
//                                             : item.availableParkings.toString(),
//                                         title: 'Available',
//                                         color: spaceManagementAvailableColor),
//                                   ),
//                                   Expanded(
//                                     child: _buildCountWidget(
//                                         count: item.totalParkings == null
//                                             ? '0'
//                                             : item.totalParkings.toString(),
//                                         title: 'Total',
//                                         color: spaceManagementTotalColor),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       );
//     } else {
//       return Container();
//     }
//   }

//   Widget _buildListItem({
//     required ParkingSeatConfigurationModel item,
//     required BuildContext context,
//     required int index,
//   }) {
//     return Row(
//       children: [
//         if (index == 1 || index == 3)
//           const Padding(
//             padding: EdgeInsets.only(
//               top: 20,
//               bottom: 20,
//             ),
//             child: VerticalDivider(
//               thickness: 2,
//             ),
//           ),
//         Column(
//           children: [
//             if (index == 2 || index == 3)
//               Padding(
//                 padding: const EdgeInsets.only(
//                   left: 20,
//                   right: 20,
//                 ),
//                 child: Container(
//                   color: Colors.grey[300],
//                   height: 2,
//                   width: 80,
//                 ),
//               ),
//             InkWell(
//               onTap: () {
//                 if (!isForRescheduling) {
//                   Provider.of<ParkingManagementProvider>(context, listen: false)
//                       .openBookSeatScreen(
//                           context: context, seatConfiguration: item);
//                 }
//               },
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(10),
//                           color: HexColor(spaceManagementMainButtonColor),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Text(
//                             item.parkingCategory ?? 'Hot Desk',
//                             style: const TextStyle(
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Row(
//                       // mainAxisSize: MainAxisSize.min,
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         _buildCountWidget(
//                           count: item.bookedParkings == null
//                               ? '0'
//                               : item.bookedParkings.toString(),
//                           title: 'Booked',
//                           color: spaceManagementOrangeColor,
//                         ),
//                         _buildCountWidget(
//                             count: item.availableParkings == null
//                                 ? '0'
//                                 : item.availableParkings.toString(),
//                             title: 'Available',
//                             color: spaceManagementAvailableColor),
//                         _buildCountWidget(
//                             count: item.totalParkings == null
//                                 ? '0'
//                                 : item.totalParkings.toString(),
//                             title: 'Total',
//                             color: spaceManagementTotalColor),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildCountWidget(
//       {required String count, required String title, required String color}) {
//     return Column(
//       children: [
//         Text(
//           count,
//           style: TextStyle(
//             color: HexColor(color),
//           ),
//         ),
//         Text(title),
//       ],
//     );
//   }
// }
