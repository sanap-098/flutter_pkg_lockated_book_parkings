// import 'package:flutter/material.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:provider/provider.dart';
// import 'package:flutter_pkg_lockated_book_parking/features/models/parking_model/parking_seat_configuration_detail/parking_seat_configuration_detail_model/parking_seat_configuration_detail_model.dart';
// import 'package:flutter_pkg_lockated_book_parking/features/providers/parking_management/parking_management_fragment_provider.dart';
// import 'package:flutter_pkg_lockated_book_parking/utils/constants.dart';
// import 'package:flutter_pkg_lockated_book_parking/core/themes/theme_view_model.dart';
// import 'package:flutter_pkg_lockated_book_parking/widgets/common/toast_dialog.dart';

// class ParkingManagementSendRequestDialog extends StatefulWidget {
//   final List<ParkingSeatConfigurationDetailModel> seatCategoryNames;
//   final String date;
//   final BuildContext parentContext;

//   const ParkingManagementSendRequestDialog(
//       {Key? key,
//       required this.seatCategoryNames,
//       required this.date,
//       required this.parentContext})
//       : super(key: key);

//   @override
//   State<ParkingManagementSendRequestDialog> createState() =>
//       _ParkingManagementSendRequestDialogState();
// }

// class _ParkingManagementSendRequestDialogState
//     extends State<ParkingManagementSendRequestDialog> {
//   @override
//   Widget build(BuildContext context) {
//     final themeViewModel = context.watch<ThemeViewModel>();
//     final baseShapeTheme = themeViewModel.companyShapeTheme;
//     return Dialog(
//       shape: baseShapeTheme.dialogBorderShape,
//       child: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 const Text(
//                   'Request',
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 InkWell(
//                   onTap: () {
//                     Navigator.pop(context);
//                   },
//                   child: const Icon(Icons.close),
//                 ),
//               ],
//             ),
//             const Divider(
//               thickness: 2,
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 8, bottom: 8),
//               child: Row(
//                 children: [
//                   const Expanded(child: Text('DATE')),
//                   Expanded(child: Text(widget.date)),
//                 ],
//               ),
//             ),
//             Row(
//               children: [
//                 const Expanded(child: Text('Parking TYPE')),
//                 Expanded(
//                   child: Container(
//                     height: 30,
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.black),
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.only(left: 4.0),
//                       child: DropdownButtonHideUnderline(
//                         child: ButtonTheme(
//                           alignedDropdown: true,
//                           child: DropdownButton<
//                               ParkingSeatConfigurationDetailModel>(
//                             hint: const Text(
//                               'Select Category',
//                               style: TextStyle(
//                                 fontSize: 11,
//                               ),
//                             ),
//                             isExpanded: true,
//                             // Corrected Provider
//                             value: context
//                                 .watch<ParkingManagementFragmentProvider>()
//                                 .sendRequestCategoryName,
//                             icon: const Icon(
//                               Icons.arrow_drop_down,
//                               size: 20,
//                             ),
//                             style: const TextStyle(
//                               color: Colors.black,
//                               fontSize: 12,
//                             ),
//                             onChanged:
//                                 (ParkingSeatConfigurationDetailModel? value) {
//                               if (value == null) {
//                                 showToastDialog(
//                                     msg: 'Selected Category Data Not Present');
//                                 return;
//                               }
//                               // Corrected Provider
//                               Provider.of<ParkingManagementFragmentProvider>(context,
//                                       listen: false)
//                                   .sendRequestCategoryNameChanged(
//                                       category: value);
//                             },
//                             items: widget.seatCategoryNames.map(
//                                 (ParkingSeatConfigurationDetailModel value) {
//                               return DropdownMenuItem<
//                                   ParkingSeatConfigurationDetailModel>(
//                                 value: value,
//                                 child: Text(value.parkingCategory ?? ''),
//                               );
//                             }).toList(),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   InkWell(
//                     onTap: () {
//                       Navigator.pop(context);
//                     },
//                     child: Text(
//                       'CANCEL',
//                       style: TextStyle(
//                         color: HexColor(spaceManagementOrangeColor),
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(
//                     width: 10,
//                   ),
//                   InkWell(
//                     onTap: () async {
//                       // Corrected Provider
//                       Provider.of<ParkingManagementFragmentProvider>(context,
//                               listen: false)
//                           .sendApprovalRequest(
//                               context: context,
//                               parentContext: widget.parentContext);
//                     },
//                     child: const Text(
//                       'OK',
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/parking_model/parking_seat_configuration_detail/parking_seat_configuration_detail_model/parking_seat_configuration_detail_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/providers/parking_management/parking_management_provider.dart';
import 'package:flutter_pkg_lockated_book_parking/utils/constants.dart';
import 'package:flutter_pkg_lockated_book_parking/core/themes/theme_view_model.dart';
import 'package:flutter_pkg_lockated_book_parking/widgets/common/toast_dialog.dart';



class ParkingManagementSendRequestDialog extends StatefulWidget {
  final List<ParkingSeatConfigurationDetailModel> seatCategoryNames;
  final String date;
  final BuildContext parentContext;

  const ParkingManagementSendRequestDialog(
      {Key? key,
      required this.seatCategoryNames,
      required this.date,
      required this.parentContext})
      : super(key: key);

  @override
  State<ParkingManagementSendRequestDialog> createState() =>
      _ParkingManagementSendRequestDialogState();
}

class _ParkingManagementSendRequestDialogState
    extends State<ParkingManagementSendRequestDialog> {
  @override
  Widget build(BuildContext context) {
    final themeViewModel = context.watch<ThemeViewModel>();
    final baseShapeTheme = themeViewModel.companyShapeTheme;
    return Dialog(
      shape: baseShapeTheme.dialogBorderShape,
      // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Request',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(Icons.close),
                ),
              ],
            ),
            const Divider(
              thickness: 2,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 8),
              child: Row(
                children: [
                  const Expanded(child: Text('DATE')),
                  Expanded(child: Text(widget.date)),
                ],
              ),
            ),
            Row(
              children: [
                const Expanded(child: Text('Parking TYPE')),
                Expanded(
                  child: Container(
                    height: 30,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: DropdownButton<
                              ParkingSeatConfigurationDetailModel>(
                            hint: const Text(
                              'Select Category',
                              style: TextStyle(
                                fontSize: 11,
                              ),
                            ),
                            isExpanded: true,
                            value: context
                                .watch<ParkingManagementProvider>()
                                .sendRequestCategoryName,
                            icon: const Icon(
                              Icons.arrow_drop_down,
                              size: 20,
                            ),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                            ),
                            onChanged:
                                (ParkingSeatConfigurationDetailModel? value) {
                              if (value == null) {
                                showToastDialog(
                                    msg: 'Selected Category Data Not Present');
                                return;
                              }
                              Provider.of<ParkingManagementProvider>(context,
                                      listen: false)
                                  .sendRequestCategoryNameChanged(
                                      category: value);
                            },
                            items: widget.seatCategoryNames.map(
                                (ParkingSeatConfigurationDetailModel value) {
                              return DropdownMenuItem<
                                  ParkingSeatConfigurationDetailModel>(
                                value: value,
                                child: Text(value.parkingCategory ?? ''),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'CANCEL',
                      style: TextStyle(
                        color: HexColor(spaceManagementOrangeColor),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () async {
                      Provider.of<ParkingManagementProvider>(context,
                              listen: false)
                          .sendApprovalRequest(
                              context: context,
                              parentContext: widget.parentContext);
                    },
                    child: const Text(
                      'OK',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
