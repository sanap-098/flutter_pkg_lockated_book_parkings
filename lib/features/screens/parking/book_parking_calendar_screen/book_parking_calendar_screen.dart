import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_pkg_lockated_book_parking/core/themes/theme_view_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/parking_booking/parking_booking_building/parking_booking_building_model/parking_booking_building_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/providers/parking_booking/parking_booking_create_provider.dart';
import 'package:flutter_pkg_lockated_book_parking/features/providers/parking_booking/parking_booking_provider.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_pkg_lockated_book_parking/utils/prefs.dart';
import 'package:flutter_pkg_lockated_book_parking/utils/constants.dart';
import 'package:flutter_pkg_lockated_book_parking/widgets/common/common_app_bar.dart';
import 'package:flutter_pkg_lockated_book_parking/widgets/common/image_card_widget.dart';
import 'package:flutter_pkg_lockated_book_parking/widgets/common/common_button.dart';
import 'package:flutter_pkg_lockated_book_parking/features/screens/parking/book_parking_summary_screen/book_parking_summary_screen.dart';
import 'package:flutter_pkg_lockated_book_parking/features/screens/parking/parking_bookings_screen/parking_bookings_screen.dart';
import 'package:flutter_pkg_lockated_book_parking/features/screens/parking/book_parking_calendar_screen/widgets/dialogs/book_parking_calendar_floor_selection_dialog.dart';

class BookParkingCalendarScreen extends StatefulWidget {
  const BookParkingCalendarScreen({super.key});

  @override
  State<BookParkingCalendarScreen> createState() =>
      _BookParkingCalendarScreenState();
}

class _BookParkingCalendarScreenState extends State<BookParkingCalendarScreen> {
  @override
  void initState() {
    super.initState();
    _initializeAndLoad();
  }

  Future<void> _initializeAndLoad() async {
    await Prefs.init();

    if (mounted) {
      Provider.of<ParkingBookingCreateProvider>(context, listen: false)
          .init(selectedDate: DateTime.now().toIso8601String());

      if (Prefs.getParkingBookingAdvanceDays() != null) {
        setState(() {
          lastDate = DateTime.now()
              .add(Duration(days: Prefs.getParkingBookingAdvanceDays()!));
        });
      }
    }
  }

  // RangeValues _currentRangeValues = const RangeValues(8, 20);
  List<int> timeSlots = [8, 9, 10, 11, 12, 1, 2, 3, 4, 5, 6, 7, 8];
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  DateTime lastDate = DateTime(3000);
  bool isTwoWheelerSelected = false;
  bool isFourWheelerSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(title: 'Parking Management', actions: [
        IconButton(
          icon: Image.asset(
            'assets/transport/parking_calendar_icon.png',
            package: 'flutter_pkg_lockated_book_parking',
            height: 20,
            width: 20,
          ),
          onPressed: () {
            final themeViewModel =
                Provider.of<ThemeViewModel>(context, listen: false);
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                // return ChangeNotifierProvider.value(
                //   value: themeViewModel,
                return MultiProvider(
            providers: [
              ChangeNotifierProvider.value(value: themeViewModel),
              ChangeNotifierProvider(
                create: (_) => ParkingBookingProvider(),
              ),
            ],
                  child: const ParkingBookingsScreen(),
                );
              },
            ));
          },
        )
      ]),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              child: TableCalendar(
                calendarFormat: CalendarFormat.month,
                weekendDays: const [DateTime.sunday],
                startingDayOfWeek: StartingDayOfWeek.sunday,
                calendarStyle: const CalendarStyle(
                  weekendTextStyle: TextStyle(
                      // color: Colors.blue,
                      ),
                  selectedDecoration: BoxDecoration(
                    color: Color(0xffC72030),
                    shape: BoxShape.circle,
                  ),
                  selectedTextStyle: TextStyle(
                    color: Colors.white,
                  ),
                ),
                headerStyle: const HeaderStyle(
                  titleCentered: true,
                  formatButtonVisible: false,
                ),
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  if (!isSameDay(_selectedDay, selectedDay)) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                    Provider.of<ParkingBookingCreateProvider>(context,
                            listen: false)
                        .onDateSelected(
                            context: context,
                            selectDay: selectedDay,
                            focusDay: focusedDay);
                  }
                },
                firstDay: DateTime(1990),
                lastDay: lastDate,
                calendarBuilders: CalendarBuilders(
                  selectedBuilder: (context, day, date) {
                    return null;
                  },
                  todayBuilder: (context, day, date) {
                    return null;
                  },
                  defaultBuilder: (context, day, date) {
                    final now = DateTime.now();
                    final today = DateTime(now.year, now.month, now.day);
                    if (day.isBefore(today)) {
                      return Center(
                        child: Text(
                          '${day.day}',
                          style: const TextStyle(color: Colors.grey),
                        ),
                      );
                    }
                    return null;
                  },
                ),
                focusedDay: _focusedDay,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Card(
              child: Column(
                children: [
                  if (context
                      .watch<ParkingBookingCreateProvider>()
                      .parkingCategories
                      .isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Vehicle Type',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            height: 30,
                            child: ListView.builder(
                              itemCount: context
                                  .read<ParkingBookingCreateProvider>()
                                  .parkingCategories
                                  .length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                final item = context
                                    .read<ParkingBookingCreateProvider>()
                                    .parkingCategories[index];

     
                                String imagePath = item.imageUrl ?? '';
                                final name = item.name?.toLowerCase() ?? '';
                                if (name.contains('4') || name.contains('car')) {
                                  imagePath = 'assets/transport/parking_car_icon.png';
                                } else if (name.contains('2') || name.contains('bike') || name.contains('scooter')) {
                                  imagePath = 'assets/transport/parking_scooter_mini_icon.png';
                                }

                                return vehicleTypeButton(
                                    onPressed: () async {
                                      context
                                          .read<ParkingBookingCreateProvider>()
                                          .onParkingCategoryChanged(
                                              value: item,
                                              selectedDate: _focusedDay
                                                  .toIso8601String());
                                    },
                                    image: imagePath,
                                    title: '${item.name}',
                                    isSelected: (context
                                            .watch<
                                                ParkingBookingCreateProvider>()
                                            .selectedParkingCategory
                                            ?.id ==
                                        item.id));
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  if (context
                      .watch<ParkingBookingCreateProvider>()
                      .buildings
                      .isNotEmpty)
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            width: 120,
                            height: 40,
                            margin: const EdgeInsets.only(right: 20, left: 20),
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(30),
                                border: Border.all(
                                    color: HexColor(texfieldBorderColor))),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton2<
                                    ParkingBookingBuildingModel>(
                                  iconStyleData: const IconStyleData(
                                    icon: Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.black,
                                    ),
                                  ),
                                  dropdownStyleData: const DropdownStyleData(
                                    maxHeight: 200,
                                  ),
                                  isExpanded: true,
                                  hint: const Text(
                                    'Tower*',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                  value: context
                                      .watch<ParkingBookingCreateProvider>()
                                      .selectedBuilding,
                                  onChanged: (newValue) {
                                    if (newValue != null) {
                                      context
                                          .read<ParkingBookingCreateProvider>()
                                          .onBuildingChanged(value: newValue);
                                    }
                                  },
                                  items: context
                                      .read<ParkingBookingCreateProvider>()
                                      .buildings
                                      .map((item) {
                                    return DropdownMenuItem(
                                      value: item,
                                      child: Text(
                                        item.name ?? 'NA',
                                        style: const TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (context
                      .watch<ParkingBookingCreateProvider>()
                      .floors
                      .isNotEmpty)
                    GestureDetector(
                      onTap: () async {
                        final themeViewModel =
                            Provider.of<ThemeViewModel>(context, listen: false);
                        await showDialog(
                          context: context,
                          builder: (_) {
                            return ChangeNotifierProvider.value(
                              value: themeViewModel,
                              child: BookParkingCalendarFloorSelectionDialog(
                                parentContext: context,
                                floors: context
                                    .watch<ParkingBookingCreateProvider>()
                                    .floors,
                              ),
                            );
                          },
                        );
                      },
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              width: 120,
                              height: 40,
                              margin:
                                  const EdgeInsets.only(right: 20, left: 20),
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(30),
                                  border: Border.all(
                                      color: HexColor(texfieldBorderColor))),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 12),
                                      child: Text(
                                        context
                                                    .watch<
                                                        ParkingBookingCreateProvider>()
                                                    .selectedFloor
                                                    ?.name ==
                                                null
                                            ? 'Select Floor'
                                            : context
                                                .watch<
                                                    ParkingBookingCreateProvider>()
                                                .selectedFloor!
                                                .name!,
                                        style: const TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    const Icon(Icons.arrow_drop_down),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (context
                              .watch<ParkingBookingCreateProvider>()
                              .selectedParkingCategory !=
                          null &&
                      context
                          .watch<ParkingBookingCreateProvider>()
                          .slots
                          .isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding:
                              EdgeInsets.only(left: 20, right: 20, top: 20),
                          child: Text(
                            "Choose Time",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        if (context
                                .watch<ParkingBookingCreateProvider>()
                                .currentRangeValues !=
                            null)
                          SfRangeSlider(
                            min: context
                                .watch<ParkingBookingCreateProvider>()
                                .minTimeInternal,
                            max: context
                                .watch<ParkingBookingCreateProvider>()
                                .maxTimeInternal,
                            values: context
                                .watch<ParkingBookingCreateProvider>()
                                .currentRangeValues!,
                            interval: 2,
                            showTicks: true,
                            showLabels: true,
                            enableTooltip: true,
                            dragMode: SliderDragMode.onThumb,
                            stepSize: 1,
                            labelPlacement: LabelPlacement.onTicks,
                            minorTicksPerInterval: 1,
                            onChanged: (SfRangeValues values) {
                              context
                                  .read<ParkingBookingCreateProvider>()
                                  .onTimeRangeChanged(value: values);
                            },
                          ),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 50,
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
                title: 'Proceed',
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
                  
                  final themeViewModel =
                      Provider.of<ThemeViewModel>(context, listen: false);
                  
                  final parkingProvider = 
                      Provider.of<ParkingBookingCreateProvider>(context, listen: false);

                  context
                      .read<ParkingBookingCreateProvider>()
                      .onProceedClicked()
                      .then((value) {
                    if (value == true) {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return MultiProvider(
                            providers: [
                              ChangeNotifierProvider.value(value: themeViewModel),
                              ChangeNotifierProvider.value(value: parkingProvider),
                            ],
                            child: const BookParkingSummaryScreen(),
                          );
                        },
                      )).then((value) {
                        if (value != null && value! as bool) {
                          Provider.of<ParkingBookingCreateProvider>(context,
                                  listen: false)
                              .init(
                                  selectedDate:
                                      DateTime.now().toIso8601String());
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return ChangeNotifierProvider.value(
                                value: themeViewModel,
                                child: const ParkingBookingsScreen(),
                              );
                            }),
                          );
                        }
                      });
                    }
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget vehicleTypeButton(
      {required void Function()? onPressed,
      required String image,
      required String title,
      required bool isSelected}) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
            decoration: BoxDecoration(
                color: isSelected ? const Color(0xffC72030) : null,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: isSelected ? const Color(0xffC72030) : Colors.grey.shade400,
                ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  
                  if (image.startsWith('http'))
                    Image.network(
                      image,
                      height: 20,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) =>
                          const SizedBox(width: 20, height: 20, child: Icon(Icons.error, size: 15)),
                    )
                  else
                    Image.asset(
                      image,
                      package: 'flutter_pkg_lockated_book_parking',
                      height: 20,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return const SizedBox(width: 20, height: 20, child: Icon(Icons.error, size: 15));
                      },
                    ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      color: isSelected ? Colors.white : HexColor('#111111'),
                      fontSize: 14,
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}




// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:flutter_pkg_lockated_book_parking/core/themes/theme_view_model.dart';
// import 'package:flutter_pkg_lockated_book_parking/features/models/parking_booking/parking_booking_building/parking_booking_building_model/parking_booking_building_model.dart';
// import 'package:flutter_pkg_lockated_book_parking/features/providers/parking_booking/parking_booking_create_provider.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:provider/provider.dart';
// import 'package:syncfusion_flutter_sliders/sliders.dart';
// import 'package:table_calendar/table_calendar.dart';
// import 'package:flutter_pkg_lockated_book_parking/utils/prefs.dart';
// import 'package:flutter_pkg_lockated_book_parking/utils/constants.dart';
// import 'package:flutter_pkg_lockated_book_parking/widgets/common/common_app_bar.dart';
// import 'package:flutter_pkg_lockated_book_parking/widgets/common/image_card_widget.dart';
// import 'package:flutter_pkg_lockated_book_parking/widgets/common/common_button.dart';
// import 'package:flutter_pkg_lockated_book_parking/features/screens/parking/book_parking_summary_screen/book_parking_summary_screen.dart';
// import 'package:flutter_pkg_lockated_book_parking/features/screens/parking/parking_bookings_screen/parking_bookings_screen.dart';
// import 'package:flutter_pkg_lockated_book_parking/features/screens/parking/book_parking_calendar_screen/widgets/dialogs/book_parking_calendar_floor_selection_dialog.dart';

// class BookParkingCalendarScreen extends StatefulWidget {
//   const BookParkingCalendarScreen({super.key});

//   @override
//   State<BookParkingCalendarScreen> createState() =>
//       _BookParkingCalendarScreenState();
// }

// class _BookParkingCalendarScreenState extends State<BookParkingCalendarScreen> {
//   @override
//   void initState() {
//     super.initState();
//     _initializeAndLoad();
//   }

//   Future<void> _initializeAndLoad() async {
//     await Prefs.init();

//     if (mounted) {
//       Provider.of<ParkingBookingCreateProvider>(context, listen: false)
//           .init(selectedDate: DateTime.now().toIso8601String());

//       if (Prefs.getParkingBookingAdvanceDays() != null) {
//         setState(() {
//           lastDate = DateTime.now()
//               .add(Duration(days: Prefs.getParkingBookingAdvanceDays()!));
//         });
//       }
//     }
//   }

//   // RangeValues _currentRangeValues = const RangeValues(8, 20);
//   List<int> timeSlots = [8, 9, 10, 11, 12, 1, 2, 3, 4, 5, 6, 7, 8];
//   DateTime _focusedDay = DateTime.now();
//   DateTime? _selectedDay;

//   DateTime lastDate = DateTime(3000);
//   bool isTwoWheelerSelected = false;
//   bool isFourWheelerSelected = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CommonAppBar(title: 'Parking Management', actions: [
//         IconButton(
//           icon: Image.asset(
//             'assets/transport/parking_calendar_icon.png',
//             package: 'flutter_pkg_lockated_book_parking',
//             height: 20,
//             width: 20,
//           ),
//           onPressed: () {
//             final themeViewModel =
//                 Provider.of<ThemeViewModel>(context, listen: false);
//             Navigator.push(context, MaterialPageRoute(
//               builder: (context) {
//                 return ChangeNotifierProvider.value(
//                   value: themeViewModel,
//                   child: const ParkingBookingsScreen(),
//                 );
//               },
//             ));
//           },
//         )
//       ]),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Card(
//               child: TableCalendar(
//                 calendarFormat: CalendarFormat.month,
//                 weekendDays: const [DateTime.sunday],
//                 startingDayOfWeek: StartingDayOfWeek.sunday,
//                 calendarStyle: CalendarStyle(
//                   weekendTextStyle: const TextStyle(
//                       // color: Colors.blue,
//                       ),
//                   selectedDecoration: BoxDecoration(
//                     color: HexColor(spaceManagementOrangeColor),
//                     shape: BoxShape.circle,
//                   ),
//                   selectedTextStyle: const TextStyle(
//                     color: Colors.white,
//                   ),
//                 ),
//                 headerStyle: const HeaderStyle(
//                   titleCentered: true,
//                   formatButtonVisible: false,
//                 ),
//                 selectedDayPredicate: (day) {
//                   return isSameDay(_selectedDay, day);
//                 },
//                 onDaySelected: (selectedDay, focusedDay) {
//                   if (!isSameDay(_selectedDay, selectedDay)) {
//                     setState(() {
//                       _selectedDay = selectedDay;
//                       _focusedDay = focusedDay;
//                     });
//                     Provider.of<ParkingBookingCreateProvider>(context,
//                             listen: false)
//                         .onDateSelected(
//                             context: context,
//                             selectDay: selectedDay,
//                             focusDay: focusedDay);
//                   }
//                 },
//                 firstDay: DateTime(1990),
//                 lastDay: lastDate,
//                 calendarBuilders: CalendarBuilders(
//                   selectedBuilder: (context, day, date) {
//                     return null;
//                   },
//                   todayBuilder: (context, day, date) {
//                     return null;
//                   },
//                   defaultBuilder: (context, day, date) {
//                     return null;
//                   },
//                 ),
//                 focusedDay: _focusedDay,
//               ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             Card(
//               child: Column(
//                 children: [
//                   if (context
//                       .watch<ParkingBookingCreateProvider>()
//                       .parkingCategories
//                       .isNotEmpty)
//                     Padding(
//                       padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text(
//                             'Vehicle Type',
//                             style: TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                           const SizedBox(
//                             height: 15,
//                           ),
//                           SizedBox(
//                             height: 30,
//                             child: ListView.builder(
//                               itemCount: context
//                                   .read<ParkingBookingCreateProvider>()
//                                   .parkingCategories
//                                   .length,
//                               scrollDirection: Axis.horizontal,
//                               itemBuilder: (context, index) {
//                                 final item = context
//                                     .read<ParkingBookingCreateProvider>()
//                                     .parkingCategories[index];
//                                 return vehicleTypeButton(
//                                     onPressed: () async {
//                                       context
//                                           .read<ParkingBookingCreateProvider>()
//                                           .onParkingCategoryChanged(
//                                               value: item,
//                                               selectedDate: _focusedDay
//                                                   .toIso8601String());
//                                     },
//                                     image: item.imageUrl ?? '',
//                                     title: '${item.name}',
//                                     isSelected: (context
//                                             .watch<
//                                                 ParkingBookingCreateProvider>()
//                                             .selectedParkingCategory
//                                             ?.id ==
//                                         item.id));
//                               },
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   if (context
//                       .watch<ParkingBookingCreateProvider>()
//                       .buildings
//                       .isNotEmpty)
//                     Row(
//                       children: [
//                         Expanded(
//                           child: Container(
//                             width: 120,
//                             height: 40,
//                             margin: const EdgeInsets.only(right: 20, left: 20),
//                             decoration: BoxDecoration(
//                                 shape: BoxShape.rectangle,
//                                 borderRadius: BorderRadius.circular(30),
//                                 border: Border.all(
//                                     color: HexColor(texfieldBorderColor))),
//                             child: Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 10),
//                               child: DropdownButtonHideUnderline(
//                                 child: DropdownButton2<
//                                     ParkingBookingBuildingModel>(
//                                   iconStyleData: const IconStyleData(
//                                     icon: Icon(
//                                       Icons.arrow_drop_down,
//                                       color: Colors.black,
//                                     ),
//                                   ),
//                                   dropdownStyleData: const DropdownStyleData(
//                                     maxHeight: 200,
//                                   ),
//                                   isExpanded: true,
//                                   hint: const Text(
//                                     'Tower*',
//                                     style: TextStyle(
//                                       color: Colors.grey,
//                                       fontSize: 12,
//                                     ),
//                                   ),
//                                   value: context
//                                       .watch<ParkingBookingCreateProvider>()
//                                       .selectedBuilding,
//                                   onChanged: (newValue) {
//                                     if (newValue != null) {
//                                       context
//                                           .read<ParkingBookingCreateProvider>()
//                                           .onBuildingChanged(value: newValue);
//                                     }
//                                   },
//                                   items: context
//                                       .read<ParkingBookingCreateProvider>()
//                                       .buildings
//                                       .map((item) {
//                                     return DropdownMenuItem(
//                                       value: item,
//                                       child: Text(
//                                         item.name ?? 'NA',
//                                         style: const TextStyle(
//                                           fontSize: 12,
//                                         ),
//                                       ),
//                                     );
//                                   }).toList(),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   if (context
//                       .watch<ParkingBookingCreateProvider>()
//                       .floors
//                       .isNotEmpty)
//                     GestureDetector(
//                       onTap: () async {
//                         final themeViewModel =
//                             Provider.of<ThemeViewModel>(context, listen: false);
//                         await showDialog(
//                           context: context,
//                           builder: (_) {
//                             return ChangeNotifierProvider.value(
//                               value: themeViewModel,
//                               child: BookParkingCalendarFloorSelectionDialog(
//                                 parentContext: context,
//                                 floors: context
//                                     .watch<ParkingBookingCreateProvider>()
//                                     .floors,
//                               ),
//                             );
//                           },
//                         );
//                       },
//                       child: Row(
//                         children: [
//                           Expanded(
//                             child: Container(
//                               width: 120,
//                               height: 40,
//                               margin:
//                                   const EdgeInsets.only(right: 20, left: 20),
//                               decoration: BoxDecoration(
//                                   shape: BoxShape.rectangle,
//                                   borderRadius: BorderRadius.circular(30),
//                                   border: Border.all(
//                                       color: HexColor(texfieldBorderColor))),
//                               child: Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(horizontal: 10),
//                                 child: Row(
//                                   children: [
//                                     Padding(
//                                       padding: const EdgeInsets.only(left: 12),
//                                       child: Text(
//                                         context
//                                                     .watch<
//                                                         ParkingBookingCreateProvider>()
//                                                     .selectedFloor
//                                                     ?.name ==
//                                                 null
//                                             ? 'Select Floor'
//                                             : context
//                                                 .watch<
//                                                     ParkingBookingCreateProvider>()
//                                                 .selectedFloor!
//                                                 .name!,
//                                         style: const TextStyle(
//                                           fontSize: 12,
//                                         ),
//                                       ),
//                                     ),
//                                     const Spacer(),
//                                     const Icon(Icons.arrow_drop_down),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   if (context
//                               .watch<ParkingBookingCreateProvider>()
//                               .selectedParkingCategory !=
//                           null &&
//                       context
//                           .watch<ParkingBookingCreateProvider>()
//                           .slots
//                           .isNotEmpty)
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Padding(
//                           padding:
//                               EdgeInsets.only(left: 20, right: 20, top: 20),
//                           child: Text(
//                             "Choose Time",
//                             style: TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                         if (context
//                                 .watch<ParkingBookingCreateProvider>()
//                                 .currentRangeValues !=
//                             null)
//                           SfRangeSlider(
//                             min: context
//                                 .watch<ParkingBookingCreateProvider>()
//                                 .minTimeInternal,
//                             max: context
//                                 .watch<ParkingBookingCreateProvider>()
//                                 .maxTimeInternal,
//                             values: context
//                                 .watch<ParkingBookingCreateProvider>()
//                                 .currentRangeValues!,
//                             interval: 2,
//                             showTicks: true,
//                             showLabels: true,
//                             enableTooltip: true,
//                             dragMode: SliderDragMode.onThumb,
//                             stepSize: 1,
//                             labelPlacement: LabelPlacement.onTicks,
//                             minorTicksPerInterval: 1,
//                             onChanged: (SfRangeValues values) {
//                               context
//                                   .read<ParkingBookingCreateProvider>()
//                                   .onTimeRangeChanged(value: values);
//                             },
//                           ),
//                         const SizedBox(
//                           height: 10,
//                         )
//                       ],
//                     ),
//                 ],
//               ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             const SizedBox(
//               height: 50,
//             )
//           ],
//         ),
//       ),
//       bottomSheet: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Row(
//             children: [
//               CommonButton(
//                 title: 'Proceed',
//                 backgroundColor: HexColor('#EC2B3E'), 
//                 customColor: HexColor('#EC2B3E'),
//                 useCustomColor: true,
//                 shouldShowArrow: true,
//                 borderRadius: BorderRadius.circular(5),
//                 shape: WidgetStateProperty.all(
//                   RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(5),
//                     side: const BorderSide(color: Colors.white, width: 2),
//                   ),
//                 ),
//                 onTap: () async {
                  
//                   final themeViewModel =
//                       Provider.of<ThemeViewModel>(context, listen: false);
//                   // CAPTURE the existing provider with all the data
//                   final parkingProvider = 
//                       Provider.of<ParkingBookingCreateProvider>(context, listen: false);

//                   context
//                       .read<ParkingBookingCreateProvider>()
//                       .onProceedClicked()
//                       .then((value) {
//                     if (value == true) {
//                       Navigator.push(context, MaterialPageRoute(
//                         builder: (context) {
//                           // PASS the captured provider to the new screen
//                           return MultiProvider(
//                             providers: [
//                               ChangeNotifierProvider.value(value: themeViewModel),
//                               ChangeNotifierProvider.value(value: parkingProvider),
//                             ],
//                             child: const BookParkingSummaryScreen(),
//                           );
//                         },
//                       )).then((value) {
//                         if (value != null && value! as bool) {
//                           Provider.of<ParkingBookingCreateProvider>(context,
//                                   listen: false)
//                               .init(
//                                   selectedDate:
//                                       DateTime.now().toIso8601String());
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(builder: (context) {
//                               // Wrap this screen too if it uses theme stuff
//                               return ChangeNotifierProvider.value(
//                                 value: themeViewModel,
//                                 child: const ParkingBookingsScreen(),
//                               );
//                             }),
//                           );
//                         }
//                       });
//                     }
//                   });
//                 },
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget vehicleTypeButton(
//       {required void Function()? onPressed,
//       required String image,
//       required String title,
//       required bool isSelected}) {
//     return GestureDetector(
//       onTap: onPressed,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 10),
//         child: Container(
//             decoration: BoxDecoration(
//                 color: isSelected ? const Color(0xffC72030) : null,
//                 borderRadius: BorderRadius.circular(25),
//                 border: Border.all(
//                   color: isSelected ? const Color(0xffC72030) : Colors.grey.shade400,
//                 ),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 15),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Image.asset(
//                     image,
//                     package: 'flutter_pkg_lockated_book_parking',
//                     height: 20,
//                     fit: BoxFit.contain,
//                     errorBuilder: (context, error, stackTrace) {
//                       return const SizedBox(width: 20, height: 20, child: Icon(Icons.error, size: 15));
//                     },
//                   ),
//                   const SizedBox(
//                     width: 10,
//                   ),
//                   Text(
//                     title,
//                     style: TextStyle(
//                       color: isSelected ? Colors.white : HexColor('#111111'),
//                       fontSize: 14,
//                     ),
//                   )
//                 ],
//               ),
//             )),
//       ),
//     );
//   }
// }


// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:flutter_pkg_lockated_book_parking/core/themes/theme_view_model.dart';
// import 'package:flutter_pkg_lockated_book_parking/features/models/parking_booking/parking_booking_building/parking_booking_building_model/parking_booking_building_model.dart';
// import 'package:flutter_pkg_lockated_book_parking/features/providers/parking_booking/parking_booking_create_provider.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:provider/provider.dart';
// import 'package:syncfusion_flutter_sliders/sliders.dart';
// import 'package:table_calendar/table_calendar.dart';
// import 'package:flutter_pkg_lockated_book_parking/utils/prefs.dart';
// import 'package:flutter_pkg_lockated_book_parking/utils/constants.dart';
// import 'package:flutter_pkg_lockated_book_parking/widgets/common/common_app_bar.dart';
// import 'package:flutter_pkg_lockated_book_parking/widgets/common/image_card_widget.dart';
// import 'package:flutter_pkg_lockated_book_parking/widgets/common/common_button.dart';
// import 'package:flutter_pkg_lockated_book_parking/features/screens/parking/book_parking_summary_screen/book_parking_summary_screen.dart';
// import 'package:flutter_pkg_lockated_book_parking/features/screens/parking/parking_bookings_screen/parking_bookings_screen.dart';
// import 'package:flutter_pkg_lockated_book_parking/features/screens/parking/book_parking_calendar_screen/widgets/dialogs/book_parking_calendar_floor_selection_dialog.dart';

// class BookParkingCalendarScreen extends StatefulWidget {
//   const BookParkingCalendarScreen({super.key});

//   @override
//   State<BookParkingCalendarScreen> createState() =>
//       _BookParkingCalendarScreenState();
// }

// class _BookParkingCalendarScreenState extends State<BookParkingCalendarScreen> {
//   @override
//   void initState() {
//     super.initState();
    
//     _initializeAndLoad();
//   }

//   Future<void> _initializeAndLoad() async {

//     await Prefs.init();

   
//     if (mounted) {
      
//       Provider.of<ParkingBookingCreateProvider>(context, listen: false)
//           .init(selectedDate: DateTime.now().toIso8601String());

//       if (Prefs.getParkingBookingAdvanceDays() != null) {
//         setState(() {
//           lastDate = DateTime.now()
//               .add(Duration(days: Prefs.getParkingBookingAdvanceDays()!));
//         });
//       }
//     }
//   }

//   List<int> timeSlots = [8, 9, 10, 11, 12, 1, 2, 3, 4, 5, 6, 7, 8];
//   DateTime _focusedDay = DateTime.now();
//   DateTime? _selectedDay;

//   DateTime lastDate = DateTime(3000);
//   bool isTwoWheelerSelected = false;
//   bool isFourWheelerSelected = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CommonAppBar(title: 'Parking Management', actions: [
//         IconButton(
//           icon: Image.asset(
//             'assets/transport/parking_calendar_icon.png',
//             package: 'flutter_pkg_lockated_book_parking',
//             height: 20,
//             width: 20,
//           ),
//           onPressed: () {
           
//             final themeViewModel =
//                 Provider.of<ThemeViewModel>(context, listen: false);
//             Navigator.push(context, MaterialPageRoute(
//               builder: (context) {
               
//                 return ChangeNotifierProvider.value(
//                   value: themeViewModel,
//                   child: const ParkingBookingsScreen(),
//                 );
//               },
//             ));
//           },
//         )
//       ]),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Card(
//               child: TableCalendar(
//                 calendarFormat: CalendarFormat.month,
//                 weekendDays: const [DateTime.sunday],
//                 startingDayOfWeek: StartingDayOfWeek.sunday,
//                 calendarStyle: const CalendarStyle(
//                   weekendTextStyle: TextStyle(
                   
//                       ),
//                   selectedDecoration: BoxDecoration(
                    
//                     color: Color(0xffC72030),
//                     shape: BoxShape.circle,
//                   ),
//                   selectedTextStyle: TextStyle(
//                     color: Colors.white,
//                   ),
//                 ),
//                 headerStyle: const HeaderStyle(
//                   titleCentered: true,
//                   formatButtonVisible: false,
//                 ),
//                 selectedDayPredicate: (day) {
//                   return isSameDay(_selectedDay, day);
//                 },
//                 onDaySelected: (selectedDay, focusedDay) {
//                   if (!isSameDay(_selectedDay, selectedDay)) {
//                     setState(() {
//                       _selectedDay = selectedDay;
//                       _focusedDay = focusedDay;
//                     });
//                     Provider.of<ParkingBookingCreateProvider>(context,
//                             listen: false)
//                         .onDateSelected(
//                             context: context,
//                             selectDay: selectedDay,
//                             focusDay: focusedDay);
//                   }
//                 },
//                 firstDay: DateTime(1990),
//                 lastDay: lastDate,
//                 calendarBuilders: CalendarBuilders(
//                   selectedBuilder: (context, day, date) {
//                     return null;
//                   },
//                   todayBuilder: (context, day, date) {
//                     return null;
//                   },
//                   defaultBuilder: (context, day, date) {
                    
//                     final now = DateTime.now();
//                     final today = DateTime(now.year, now.month, now.day);
                    
//                     if (day.isBefore(today)) {
//                       return Center(
//                         child: Text(
//                           '${day.day}',
//                           style: const TextStyle(color: Colors.grey),
//                         ),
//                       );
//                     }
//                     return null;
//                   },
//                 ),
//                 focusedDay: _focusedDay,
//               ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             Card(
//               child: Column(
//                 children: [
//                   if (context
//                       .watch<ParkingBookingCreateProvider>()
//                       .parkingCategories
//                       .isNotEmpty)
//                     Padding(
//                       padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text(
//                             'Vehicle Type',
//                             style: TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                           const SizedBox(
//                             height: 15,
//                           ),
//                           SizedBox(
//                             height: 30,
//                             child: ListView.builder(
//                               itemCount: context
//                                   .read<ParkingBookingCreateProvider>()
//                                   .parkingCategories
//                                   .length,
//                               scrollDirection: Axis.horizontal,
//                               itemBuilder: (context, index) {
//                                 final item = context
//                                     .read<ParkingBookingCreateProvider>()
//                                     .parkingCategories[index];
//                                 return vehicleTypeButton(
//                                     onPressed: () async {
//                                       context
//                                           .read<ParkingBookingCreateProvider>()
//                                           .onParkingCategoryChanged(
//                                               value: item,
//                                               selectedDate: _focusedDay
//                                                   .toIso8601String());
//                                     },
//                                     image: item.imageUrl ?? '',
//                                     title: '${item.name}',
//                                     isSelected: (context
//                                             .watch<
//                                                 ParkingBookingCreateProvider>()
//                                             .selectedParkingCategory
//                                             ?.id ==
//                                         item.id));
//                               },
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   if (context
//                       .watch<ParkingBookingCreateProvider>()
//                       .buildings
//                       .isNotEmpty)
//                     Row(
//                       children: [
//                         Expanded(
//                           child: Container(
//                             width: 120,
//                             height: 40,
//                             margin: const EdgeInsets.only(right: 20, left: 20),
//                             decoration: BoxDecoration(
//                                 shape: BoxShape.rectangle,
//                                 borderRadius: BorderRadius.circular(30),
//                                 border: Border.all(
//                                     color: HexColor(texfieldBorderColor))),
//                             child: Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 10),
//                               child: DropdownButtonHideUnderline(
//                                 child: DropdownButton2<
//                                     ParkingBookingBuildingModel>(
//                                   iconStyleData: const IconStyleData(
//                                     icon: Icon(
//                                       Icons.arrow_drop_down,
//                                       color: Colors.black,
//                                     ),
//                                   ),
//                                   dropdownStyleData: const DropdownStyleData(
//                                     maxHeight: 200,
//                                   ),
//                                   isExpanded: true,
//                                   hint: const Text(
//                                     'Tower*',
//                                     style: TextStyle(
//                                       color: Colors.grey,
//                                       fontSize: 12,
//                                     ),
//                                   ),
//                                   value: context
//                                       .watch<ParkingBookingCreateProvider>()
//                                       .selectedBuilding,
//                                   onChanged: (newValue) {
//                                     if (newValue != null) {
//                                       context
//                                           .read<ParkingBookingCreateProvider>()
//                                           .onBuildingChanged(value: newValue);
//                                     }
//                                   },
//                                   items: context
//                                       .read<ParkingBookingCreateProvider>()
//                                       .buildings
//                                       .map((item) {
//                                     return DropdownMenuItem(
//                                       value: item,
//                                       child: Text(
//                                         item.name ?? 'NA',
//                                         style: const TextStyle(
//                                           fontSize: 12,
//                                         ),
//                                       ),
//                                     );
//                                   }).toList(),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   if (context
//                       .watch<ParkingBookingCreateProvider>()
//                       .floors
//                       .isNotEmpty)
//                     GestureDetector(
//                       onTap: () async {
//                         // Capture ThemeViewModel
//                         final themeViewModel =
//                             Provider.of<ThemeViewModel>(context, listen: false);
//                         await showDialog(
//                           context: context,
//                           builder: (_) {
//                             // Pass ThemeViewModel to Dialog
//                             return ChangeNotifierProvider.value(
//                               value: themeViewModel,
//                               child: BookParkingCalendarFloorSelectionDialog(
//                                 parentContext: context,
//                                 floors: context
//                                     .watch<ParkingBookingCreateProvider>()
//                                     .floors,
//                               ),
//                             );
//                           },
//                         );
//                       },
//                       child: Row(
//                         children: [
//                           Expanded(
//                             child: Container(
//                               width: 120,
//                               height: 40,
//                               margin:
//                                   const EdgeInsets.only(right: 20, left: 20),
//                               decoration: BoxDecoration(
//                                   shape: BoxShape.rectangle,
//                                   borderRadius: BorderRadius.circular(30),
//                                   border: Border.all(
//                                       color: HexColor(texfieldBorderColor))),
//                               child: Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(horizontal: 10),
//                                 child: Row(
//                                   children: [
//                                     Padding(
//                                       padding: const EdgeInsets.only(left: 12),
//                                       child: Text(
//                                         context
//                                                     .watch<
//                                                         ParkingBookingCreateProvider>()
//                                                     .selectedFloor
//                                                     ?.name ==
//                                                 null
//                                             ? 'Select Floor'
//                                             : context
//                                                 .watch<
//                                                     ParkingBookingCreateProvider>()
//                                                 .selectedFloor!
//                                                 .name!,
//                                         style: const TextStyle(
//                                           fontSize: 12,
//                                         ),
//                                       ),
//                                     ),
//                                     const Spacer(),
//                                     const Icon(Icons.arrow_drop_down),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   if (context
//                               .watch<ParkingBookingCreateProvider>()
//                               .selectedParkingCategory !=
//                           null &&
//                       context
//                           .watch<ParkingBookingCreateProvider>()
//                           .slots
//                           .isNotEmpty)
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Padding(
//                           padding:
//                               EdgeInsets.only(left: 20, right: 20, top: 20),
//                           child: Text(
//                             "Choose Time",
//                             style: TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                         if (context
//                                 .watch<ParkingBookingCreateProvider>()
//                                 .currentRangeValues !=
//                             null)
//                           SfRangeSlider(
//                             min: context
//                                 .watch<ParkingBookingCreateProvider>()
//                                 .minTimeInternal,
//                             max: context
//                                 .watch<ParkingBookingCreateProvider>()
//                                 .maxTimeInternal,
//                             values: context
//                                 .watch<ParkingBookingCreateProvider>()
//                                 .currentRangeValues!,
//                             interval: 2,
//                             showTicks: true,
//                             showLabels: true,
//                             enableTooltip: true,
//                             dragMode: SliderDragMode.onThumb,
//                             stepSize: 1,
//                             labelPlacement: LabelPlacement.onTicks,
//                             minorTicksPerInterval: 1,
//                             onChanged: (SfRangeValues values) {
//                               context
//                                   .read<ParkingBookingCreateProvider>()
//                                   .onTimeRangeChanged(value: values);
//                             },
//                           ),
//                         const SizedBox(
//                           height: 10,
//                         )
//                       ],
//                     ),
//                 ],
//               ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             const SizedBox(
//               height: 50,
//             )
//           ],
//         ),
//       ),
//       bottomSheet: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Row(
//             children: [
//               CommonButton(
//                 title: 'Proceed',
//                 backgroundColor: HexColor('#EC2B3E'), 
//                 customColor: HexColor('#EC2B3E'),
//                 useCustomColor: true,
//                 shouldShowArrow: true,
//                 borderRadius: BorderRadius.circular(5),
//                 shape: WidgetStateProperty.all(
//                   RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(5),
//                     side: const BorderSide(color: Colors.white, width: 2),
//                   ),
//                 ),
//                 onTap: () async {
                  
//                   final themeViewModel =
//                       Provider.of<ThemeViewModel>(context, listen: false);

//                   context
//                       .read<ParkingBookingCreateProvider>()
//                       .onProceedClicked()
//                       .then((value) {
//                     if (value == true) {
//                       Navigator.push(context, MaterialPageRoute(
//                         builder: (context) {
//                           // WRAP the new screen with ChangeNotifierProvider.value
//                           return ChangeNotifierProvider.value(
//                             value: themeViewModel,
//                             child: const BookParkingSummaryScreen(),
//                           );
//                         },
//                       )).then((value) {
//                         if (value != null && value! as bool) {
//                           Provider.of<ParkingBookingCreateProvider>(context,
//                                   listen: false)
//                               .init(
//                                   selectedDate:
//                                       DateTime.now().toIso8601String());
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(builder: (context) {
//                               // Wrap this screen too if it uses theme stuff
//                               return ChangeNotifierProvider.value(
//                                 value: themeViewModel,
//                                 child: const ParkingBookingsScreen(),
//                               );
//                             }),
//                           );
//                         }
//                       });
//                     }
//                   });
//                 },
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget vehicleTypeButton(
//       {required void Function()? onPressed,
//       required String image,
//       required String title,
//       required bool isSelected}) {
//     return GestureDetector(
//       onTap: onPressed,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 10),
//         child: Container(
//             decoration: BoxDecoration(
//                 color: isSelected ? const Color(0xffC72030) : null,
//                 borderRadius: BorderRadius.circular(25),
//                border: Border.all(
//                   color: isSelected ? const Color(0xffC72030) : Colors.grey.shade400,
//                 ),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 15),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   ImageCardWidget(
//                     image: image,
//                     radius: BorderRadius.zero,
//                     height: 20,
//                     padding: 0,
//                   ),
//                   const SizedBox(
//                     width: 10,
//                   ),
//                   Text(
//                     title,
//                     style: TextStyle(
//                       color: isSelected ? Colors.white : HexColor('#111111'),
//                       fontSize: 14,
//                     ),
//                   )
//                 ],
//               ),
//             )),
//       ),
//     );
//   }
// }



// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:flutter_pkg_lockated_book_parking/core/themes/theme_view_model.dart';
// import 'package:flutter_pkg_lockated_book_parking/features/models/parking_booking/parking_booking_building/parking_booking_building_model/parking_booking_building_model.dart';
// import 'package:flutter_pkg_lockated_book_parking/features/providers/parking_booking/parking_booking_create_provider.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:provider/provider.dart';
// import 'package:syncfusion_flutter_sliders/sliders.dart';
// import 'package:table_calendar/table_calendar.dart';
// import 'package:flutter_pkg_lockated_book_parking/utils/prefs.dart';
// import 'package:flutter_pkg_lockated_book_parking/utils/constants.dart';
// import 'package:flutter_pkg_lockated_book_parking/widgets/common/common_app_bar.dart';
// import 'package:flutter_pkg_lockated_book_parking/widgets/common/image_card_widget.dart';
// import 'package:flutter_pkg_lockated_book_parking/widgets/common/common_button.dart';
// import 'package:flutter_pkg_lockated_book_parking/features/screens/parking/book_parking_summary_screen/book_parking_summary_screen.dart';
// import 'package:flutter_pkg_lockated_book_parking/features/screens/parking/parking_bookings_screen/parking_bookings_screen.dart';
// import 'package:flutter_pkg_lockated_book_parking/features/screens/parking/book_parking_calendar_screen/widgets/dialogs/book_parking_calendar_floor_selection_dialog.dart';

// class BookParkingCalendarScreen extends StatefulWidget {
//   const BookParkingCalendarScreen({super.key});

//   @override
//   State<BookParkingCalendarScreen> createState() =>
//       _BookParkingCalendarScreenState();
// }

// class _BookParkingCalendarScreenState extends State<BookParkingCalendarScreen> {
//   @override
//   void initState() {
//     super.initState();
//     // Only call this. Do not add SchedulerBinding logic here directly to avoid race conditions.
//     _initializeAndLoad();
//   }

//   Future<void> _initializeAndLoad() async {
//     // 1. Ensure Prefs is initialized first
//     await Prefs.init();

//     // 2. Now it is safe to access the provider which uses Prefs
//     if (mounted) {
//       // Initialize the provider
//       Provider.of<ParkingBookingCreateProvider>(context, listen: false)
//           .init(selectedDate: DateTime.now().toIso8601String());

//       // Set state based on prefs
//       if (Prefs.getParkingBookingAdvanceDays() != null) {
//         setState(() {
//           lastDate = DateTime.now()
//               .add(Duration(days: Prefs.getParkingBookingAdvanceDays()!));
//         });
//       }
//     }
//   }

//   // RangeValues _currentRangeValues = const RangeValues(8, 20);
//   List<int> timeSlots = [8, 9, 10, 11, 12, 1, 2, 3, 4, 5, 6, 7, 8];
//   DateTime _focusedDay = DateTime.now();
//   DateTime? _selectedDay;

//   DateTime lastDate = DateTime(3000);
//   bool isTwoWheelerSelected = false;
//   bool isFourWheelerSelected = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CommonAppBar(title: 'Parking Management', actions: [
//         IconButton(
//           icon: Image.asset(
//             'assets/transport/parking_calendar_icon.png',
//             package: 'flutter_pkg_lockated_book_parking',
//             height: 20,
//             width: 20,
//           ),
//           onPressed: () {
//             // Capture ThemeViewModel before pushing new route
//             final themeViewModel =
//                 Provider.of<ThemeViewModel>(context, listen: false);
//             Navigator.push(context, MaterialPageRoute(
//               builder: (context) {
//                 // Pass ThemeViewModel to the next screen
//                 return ChangeNotifierProvider.value(
//                   value: themeViewModel,
//                   child: const ParkingBookingsScreen(),
//                 );
//               },
//             ));
//           },
//         )
//       ]),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Card(
//               child: TableCalendar(
//                 calendarFormat: CalendarFormat.month,
//                 weekendDays: const [DateTime.sunday],
//                 startingDayOfWeek: StartingDayOfWeek.sunday,
//                 calendarStyle: CalendarStyle(
//                   weekendTextStyle: const TextStyle(
//                       // color: Colors.blue,
//                       ),
//                   selectedDecoration: BoxDecoration(
//                     color: HexColor(spaceManagementOrangeColor),
//                     shape: BoxShape.circle,
//                   ),
//                   selectedTextStyle: const TextStyle(
//                     color: Colors.white,
//                   ),
//                 ),
//                 headerStyle: const HeaderStyle(
//                   titleCentered: true,
//                   formatButtonVisible: false,
//                 ),
//                 selectedDayPredicate: (day) {
//                   return isSameDay(_selectedDay, day);
//                 },
//                 onDaySelected: (selectedDay, focusedDay) {
//                   if (!isSameDay(_selectedDay, selectedDay)) {
//                     setState(() {
//                       _selectedDay = selectedDay;
//                       _focusedDay = focusedDay;
//                     });
//                     Provider.of<ParkingBookingCreateProvider>(context,
//                             listen: false)
//                         .onDateSelected(
//                             context: context,
//                             selectDay: selectedDay,
//                             focusDay: focusedDay);
//                   }
//                 },
//                 firstDay: DateTime(1990),
//                 lastDay: lastDate,
//                 calendarBuilders: CalendarBuilders(
//                   selectedBuilder: (context, day, date) {
//                     return null;
//                   },
//                   todayBuilder: (context, day, date) {
//                     return null;
//                   },
//                   defaultBuilder: (context, day, date) {
//                     return null;
//                   },
//                 ),
//                 focusedDay: _focusedDay,
//               ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             Card(
//               child: Column(
//                 children: [
//                   if (context
//                       .watch<ParkingBookingCreateProvider>()
//                       .parkingCategories
//                       .isNotEmpty)
//                     Padding(
//                       padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text(
//                             'Vehicle Type',
//                             style: TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                           const SizedBox(
//                             height: 15,
//                           ),
//                           SizedBox(
//                             height: 30,
//                             child: ListView.builder(
//                               itemCount: context
//                                   .read<ParkingBookingCreateProvider>()
//                                   .parkingCategories
//                                   .length,
//                               scrollDirection: Axis.horizontal,
//                               itemBuilder: (context, index) {
//                                 final item = context
//                                     .read<ParkingBookingCreateProvider>()
//                                     .parkingCategories[index];
//                                 return vehicleTypeButton(
//                                     onPressed: () async {
//                                       context
//                                           .read<ParkingBookingCreateProvider>()
//                                           .onParkingCategoryChanged(
//                                               value: item,
//                                               selectedDate: _focusedDay
//                                                   .toIso8601String());
//                                     },
//                                     image: item.imageUrl ?? '',
//                                     title: '${item.name}',
//                                     isSelected: (context
//                                             .watch<
//                                                 ParkingBookingCreateProvider>()
//                                             .selectedParkingCategory
//                                             ?.id ==
//                                         item.id));
//                               },
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   if (context
//                       .watch<ParkingBookingCreateProvider>()
//                       .buildings
//                       .isNotEmpty)
//                     Row(
//                       children: [
//                         Expanded(
//                           child: Container(
//                             width: 120,
//                             height: 40,
//                             margin: const EdgeInsets.only(right: 20, left: 20),
//                             decoration: BoxDecoration(
//                                 shape: BoxShape.rectangle,
//                                 borderRadius: BorderRadius.circular(30),
//                                 border: Border.all(
//                                     color: HexColor(texfieldBorderColor))),
//                             child: Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 10),
//                               child: DropdownButtonHideUnderline(
//                                 child: DropdownButton2<
//                                     ParkingBookingBuildingModel>(
//                                   iconStyleData: const IconStyleData(
//                                     icon: Icon(
//                                       Icons.arrow_drop_down,
//                                       color: Colors.black,
//                                     ),
//                                   ),
//                                   dropdownStyleData: const DropdownStyleData(
//                                     maxHeight: 200,
//                                   ),
//                                   isExpanded: true,
//                                   hint: const Text(
//                                     'Tower*',
//                                     style: TextStyle(
//                                       color: Colors.grey,
//                                       fontSize: 12,
//                                     ),
//                                   ),
//                                   value: context
//                                       .watch<ParkingBookingCreateProvider>()
//                                       .selectedBuilding,
//                                   onChanged: (newValue) {
//                                     if (newValue != null) {
//                                       context
//                                           .read<ParkingBookingCreateProvider>()
//                                           .onBuildingChanged(value: newValue);
//                                     }
//                                   },
//                                   items: context
//                                       .read<ParkingBookingCreateProvider>()
//                                       .buildings
//                                       .map((item) {
//                                     return DropdownMenuItem(
//                                       value: item,
//                                       child: Text(
//                                         item.name ?? 'NA',
//                                         style: const TextStyle(
//                                           fontSize: 12,
//                                         ),
//                                       ),
//                                     );
//                                   }).toList(),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   if (context
//                       .watch<ParkingBookingCreateProvider>()
//                       .floors
//                       .isNotEmpty)
//                     GestureDetector(
//                       onTap: () async {
//                         // Capture ThemeViewModel
//                         final themeViewModel =
//                             Provider.of<ThemeViewModel>(context, listen: false);
//                         await showDialog(
//                           context: context,
//                           builder: (_) {
//                             // Pass ThemeViewModel to Dialog
//                             return ChangeNotifierProvider.value(
//                               value: themeViewModel,
//                               child: BookParkingCalendarFloorSelectionDialog(
//                                 parentContext: context,
//                                 floors: context
//                                     .watch<ParkingBookingCreateProvider>()
//                                     .floors,
//                               ),
//                             );
//                           },
//                         );
//                       },
//                       child: Row(
//                         children: [
//                           Expanded(
//                             child: Container(
//                               width: 120,
//                               height: 40,
//                               margin:
//                                   const EdgeInsets.only(right: 20, left: 20),
//                               decoration: BoxDecoration(
//                                   shape: BoxShape.rectangle,
//                                   borderRadius: BorderRadius.circular(30),
//                                   border: Border.all(
//                                       color: HexColor(texfieldBorderColor))),
//                               child: Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(horizontal: 10),
//                                 child: Row(
//                                   children: [
//                                     Padding(
//                                       padding: const EdgeInsets.only(left: 12),
//                                       child: Text(
//                                         context
//                                                     .watch<
//                                                         ParkingBookingCreateProvider>()
//                                                     .selectedFloor
//                                                     ?.name ==
//                                                 null
//                                             ? 'Select Floor'
//                                             : context
//                                                 .watch<
//                                                     ParkingBookingCreateProvider>()
//                                                 .selectedFloor!
//                                                 .name!,
//                                         style: const TextStyle(
//                                           fontSize: 12,
//                                         ),
//                                       ),
//                                     ),
//                                     const Spacer(),
//                                     const Icon(Icons.arrow_drop_down),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   if (context
//                               .watch<ParkingBookingCreateProvider>()
//                               .selectedParkingCategory !=
//                           null &&
//                       context
//                           .watch<ParkingBookingCreateProvider>()
//                           .slots
//                           .isNotEmpty)
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Padding(
//                           padding:
//                               EdgeInsets.only(left: 20, right: 20, top: 20),
//                           child: Text(
//                             "Choose Time",
//                             style: TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                         if (context
//                                 .watch<ParkingBookingCreateProvider>()
//                                 .currentRangeValues !=
//                             null)
//                           SfRangeSlider(
//                             min: context
//                                 .watch<ParkingBookingCreateProvider>()
//                                 .minTimeInternal,
//                             max: context
//                                 .watch<ParkingBookingCreateProvider>()
//                                 .maxTimeInternal,
//                             values: context
//                                 .watch<ParkingBookingCreateProvider>()
//                                 .currentRangeValues!,
//                             interval: 2,
//                             showTicks: true,
//                             showLabels: true,
//                             enableTooltip: true,
//                             dragMode: SliderDragMode.onThumb,
//                             stepSize: 1,
//                             labelPlacement: LabelPlacement.onTicks,
//                             minorTicksPerInterval: 1,
//                             onChanged: (SfRangeValues values) {
//                               context
//                                   .read<ParkingBookingCreateProvider>()
//                                   .onTimeRangeChanged(value: values);
//                             },
//                           ),
//                         const SizedBox(
//                           height: 10,
//                         )
//                       ],
//                     ),
//                 ],
//               ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             const SizedBox(
//               height: 50,
//             )
//           ],
//         ),
//       ),
//       bottomSheet: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Row(
//             children: [
//               CommonButton(
//                 title: 'Proceed',
//                 backgroundColor: HexColor('#EC2B3E'), 
//                 customColor: HexColor('#EC2B3E'),
//                 useCustomColor: true,
//                 shouldShowArrow: true,
//                 borderRadius: BorderRadius.circular(5),
//                 shape: WidgetStateProperty.all(
//                   RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(5),
//                     side: const BorderSide(color: Colors.white, width: 2),
//                   ),
//                 ),
//                 onTap: () async {
                  
//                   final themeViewModel =
//                       Provider.of<ThemeViewModel>(context, listen: false);

//                   context
//                       .read<ParkingBookingCreateProvider>()
//                       .onProceedClicked()
//                       .then((value) {
//                     if (value == true) {
//                       Navigator.push(context, MaterialPageRoute(
//                         builder: (context) {
//                           // WRAP the new screen with ChangeNotifierProvider.value
//                           return ChangeNotifierProvider.value(
//                             value: themeViewModel,
//                             child: const BookParkingSummaryScreen(),
//                           );
//                         },
//                       )).then((value) {
//                         if (value != null && value! as bool) {
//                           Provider.of<ParkingBookingCreateProvider>(context,
//                                   listen: false)
//                               .init(
//                                   selectedDate:
//                                       DateTime.now().toIso8601String());
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(builder: (context) {
//                               // Wrap this screen too if it uses theme stuff
//                               return ChangeNotifierProvider.value(
//                                 value: themeViewModel,
//                                 child: const ParkingBookingsScreen(),
//                               );
//                             }),
//                           );
//                         }
//                       });
//                     }
//                   });
//                 },
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget vehicleTypeButton(
//       {required void Function()? onPressed,
//       required String image,
//       required String title,
//       required bool isSelected}) {
//     return GestureDetector(
//       onTap: onPressed,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 10),
//         child: Container(
//             decoration: BoxDecoration(
//                 color: isSelected ? HexColor(ticketTabColor) : null,
//                 borderRadius: BorderRadius.circular(25),
//                 border: Border.all(color: Colors.orange)),
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 15),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   ImageCardWidget(
//                     image: image,
//                     radius: BorderRadius.zero,
//                     height: 20,
//                     padding: 0,
//                   ),
//                   const SizedBox(
//                     width: 10,
//                   ),
//                   Text(
//                     title,
//                     style: TextStyle(
//                       color: isSelected ? Colors.white : HexColor('#111111'),
//                       fontSize: 14,
//                     ),
//                   )
//                 ],
//               ),
//             )),
//       ),
//     );
//   }
// }





// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
// import 'package:flutter_pkg_lockated_book_parking/core/themes/theme_view_model.dart';
// import 'package:flutter_pkg_lockated_book_parking/features/models/parking_booking/parking_booking_building/parking_booking_building_model/parking_booking_building_model.dart';
// import 'package:flutter_pkg_lockated_book_parking/features/providers/parking_booking/parking_booking_create_provider.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:provider/provider.dart';
// import 'package:syncfusion_flutter_sliders/sliders.dart';
// import 'package:table_calendar/table_calendar.dart';
// import 'package:flutter_pkg_lockated_book_parking/utils/prefs.dart';
// import 'package:flutter_pkg_lockated_book_parking/utils/constants.dart';
// import 'package:flutter_pkg_lockated_book_parking/widgets/common/common_app_bar.dart';
// import 'package:flutter_pkg_lockated_book_parking/widgets/common/image_card_widget.dart';
// import 'package:flutter_pkg_lockated_book_parking/widgets/common/toast_dialog.dart';
// import 'package:flutter_pkg_lockated_book_parking/widgets/common/common_button.dart';
// import 'package:flutter_pkg_lockated_book_parking/features/screens/parking/book_parking_summary_screen/book_parking_summary_screen.dart';
// import 'package:flutter_pkg_lockated_book_parking/features/screens/parking/parking_bookings_screen/parking_bookings_screen.dart';
// import 'package:flutter_pkg_lockated_book_parking/features/screens/parking/book_parking_calendar_screen/widgets/dialogs/book_parking_calendar_floor_selection_dialog.dart';


// class BookParkingCalendarScreen extends StatefulWidget {
//   const BookParkingCalendarScreen({super.key});

//   @override
//   State<BookParkingCalendarScreen> createState() =>
//       _BookParkingCalendarScreenState();
// }

// class _BookParkingCalendarScreenState extends State<BookParkingCalendarScreen> {
//   @override
//   void initState() {
//     SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
//       Provider.of<ParkingBookingCreateProvider>(context, listen: false)
//           .init(selectedDate: DateTime.now().toIso8601String());
//       if (Prefs.getParkingBookingAdvanceDays() != null) {
//         setState(() {
//           lastDate = DateTime.now()
//               .add(Duration(days: Prefs.getParkingBookingAdvanceDays()!));
//         });
//       }
//     });
//     _initializeAndLoad();
//     super.initState();
//   }



//   Future<void> _initializeAndLoad() async {
//     // 1. Ensure Prefs is initialized
//     await Prefs.init(); 
    
//     // 2. Now it is safe to access the provider which uses Prefs
//     if (mounted) {
//       SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
//         Provider.of<ParkingBookingCreateProvider>(context, listen: false)
//             .init(selectedDate: DateTime.now().toIso8601String());
        
//         if (Prefs.getParkingBookingAdvanceDays() != null) {
//           setState(() {
//             lastDate = DateTime.now()
//                 .add(Duration(days: Prefs.getParkingBookingAdvanceDays()!));
//           });
//         }
//       });
//     }
//   }

//   // RangeValues _currentRangeValues = const RangeValues(8, 20);
//   List<int> timeSlots = [8, 9, 10, 11, 12, 1, 2, 3, 4, 5, 6, 7, 8];
//   DateTime _focusedDay = DateTime.now();
//   DateTime? _selectedDay;

//   DateTime lastDate = DateTime(3000);
//   bool isTwoWheelerSelected = false;
//   bool isFourWheelerSelected = false;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CommonAppBar(title: 'Parking Management', actions: [
//         IconButton(
//           icon: Image.asset('assets/transport/parking_calendar_icon.png',
//           package: 'flutter_pkg_lockated_book_parking',
//               height: 20, width: 20),
//           onPressed: () {
//             final themeViewModel = Provider.of<ThemeViewModel>(context, listen: false);
//             Navigator.push(context, MaterialPageRoute(
//               builder: (context) {
//                 return ChangeNotifierProvider.value(
//                   value: themeViewModel,
//                   child: const ParkingBookingsScreen(),

//                 // return const ParkingBookingsScreen();
//              ); },
//             ));
//           },
//         )
//       ]),
//       // appBar: AppBar(
//       //     backgroundColor: Colors.white,
//       //     leading: InkWell(
//       //       onTap: () {
//       //         // if (widget.isFromNoti) {
//       //         //   Navigator.pushNamedAndRemoveUntil(
//       //         //       context, Routes.homeScreen, (route) => false);
//       //         // } else {
//       //         Navigator.pop(context);
//       //         // }
//       //       },
//       //       child: const Icon(Icons.arrow_back_ios),
//       //     ),
//       //     title: const Center(
//       //       child: Text(
//       //         'Parking Management',
//       //         style: TextStyle(
//       //           color: Colors.black,
//       //         ),
//       //       ),
//       //     ),
//       //     centerTitle: true,
//       //     actions: [
//       //       IconButton(
//       //         icon: Image.asset('assets/transport/parking_calendar_icon.png',
//       //             height: 20, width: 20),
//       //         onPressed: () {
//       //           Navigator.push(context, MaterialPageRoute(
//       //             builder: (context) {
//       //               return const ParkingBookingsScreen();
//       //             },
//       //           ));
//       //         },
//       //       )
//       //     ]),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Card(
//               child: TableCalendar(
//                 calendarFormat: CalendarFormat.month,
//                 weekendDays: const [DateTime.sunday],
//                 startingDayOfWeek: StartingDayOfWeek.sunday,
//                 calendarStyle: CalendarStyle(
//                   weekendTextStyle: const TextStyle(
//                       // color: Colors.blue,
//                       ),
//                   selectedDecoration: BoxDecoration(
//                     // color: isDateSelectedAndPresentInBlueDates(
//                     //   day: widget.isForRescheduling
//                     //       ? Provider.of<ParkingManagementFragmentProvider>(context,
//                     //               listen: true)
//                     //           .selectedDay
//                     //       : Provider.of<ParkingManagementProvider>(context,
//                     //               listen: true)
//                     //           .selectedDay,
//                     //   blueDates: widget.isForRescheduling
//                     //       ? Provider.of<ParkingManagementFragmentProvider>(context,
//                     //               listen: true)
//                     //           .blueDates
//                     //       : Provider.of<ParkingManagementProvider>(context,
//                     //               listen: true)
//                     //           .blueDates,
//                     // )
//                     //     ? HexColor(calendarBlue)
//                     //     : Colors.white,
//                     color: HexColor(spaceManagementOrangeColor),
//                     shape: BoxShape.circle,
//                     // border: Border.all(
//                     //   width: 2,
//                     //   color: HexColor(spaceManagementOrangeColor),
//                     // ),
//                   ),
//                   selectedTextStyle: const TextStyle(
//                     color: Colors.white,
//                   ),
//                   // todayDecoration: BoxDecoration(
//                   //   color: HexColor(spaceManagementOrangeColor),
//                   //   shape: BoxShape.circle,
//                   // ),
//                 ),
//                 headerStyle: const HeaderStyle(
//                   titleCentered: true,
//                   formatButtonVisible: false,
//                 ),
//                 selectedDayPredicate: (day) {
//                   return isSameDay(_selectedDay, day);
//                   // Use `selectedDayPredicate` to determine which day is currently selected.
//                   // If this returns true, then `day` will be marked as selected.

//                   // Using `isSameDay` is recommended to disregard
//                   // the time-part of compared DateTime objects.
//                   // if (widget.isForRescheduling) {
//                   //   return isSameDay(
//                   //       Provider.of<ParkingManagementFragmentProvider>(context,
//                   //               listen: false)
//                   //           .selectedDay,
//                   //       day);
//                   // } else {
//                   //   return isSameDay(
//                   //       Provider.of<ParkingManagementProvider>(context,
//                   //               listen: false)
//                   //           .selectedDay,
//                   //       day);
//                   // }
//                 },
//                 onDaySelected: (selectedDay, focusedDay) {
//                   if (!isSameDay(_selectedDay, selectedDay)) {
//                     // Call `setState()` when updating the selected day
//                     setState(() {
//                       _selectedDay = selectedDay;
//                       _focusedDay = focusedDay;
//                     });
//                     Provider.of<ParkingBookingCreateProvider>(context,
//                             listen: false)
//                         .onDateSelected(
//                             context: context,
//                             selectDay: selectedDay,
//                             focusDay: focusedDay);
//                   }
//                   // if (widget.isForRescheduling) {
//                   //   if (!isSameDay(
//                   //       Provider.of<ParkingManagementFragmentProvider>(context,
//                   //               listen: false)
//                   //           .selectedDay,
//                   //       selectedDay)) {
//                   //     // Call `setState()` when updating the selected day
//                   //     Provider.of<ParkingManagementFragmentProvider>(context,
//                   //             listen: false)
//                   //         .dateSelected(
//                   //             context: context,
//                   //             selectDay: selectedDay,
//                   //             focusDay: focusedDay);
//                   //   }
//                   // } else {
//                   //   if (!isSameDay(
//                   //       Provider.of<ParkingManagementProvider>(context,
//                   //               listen: false)
//                   //           .selectedDay,
//                   //       selectedDay)) {
//                   //     // Call `setState()` when updating the selected day
//                   //     Provider.of<ParkingManagementProvider>(context, listen: false)
//                   //         .dateSelected(
//                   //             context: context,
//                   //             selectDay: selectedDay,
//                   //             focusDay: focusedDay);
//                   //   }
//                   // }
//                 },
//                 firstDay: DateTime(1990),
//                 // focusedDay: widget.isForRescheduling
//                 //     ? context.watch<ParkingManagementFragmentProvider>().focusedDay
//                 //     : context.watch<ParkingManagementProvider>().focusedDay,
//                 // lastDay: DateTime(3000),
//                 lastDay: lastDate,
//                 //onVisibleDaysChanged: _onVisibleDaysChanged,
//                 calendarBuilders: CalendarBuilders(
//                   selectedBuilder: (context, day, date) {
//                     // String formatedDate = DateFormat('yyyy-MM-dd').format(day);
//                     // final text = day.day;

//                     // bool isBlueDate = false;

//                     // if (widget.isForRescheduling) {
//                     //   isBlueDate = Provider.of<ParkingManagementFragmentProvider>(
//                     //           context,
//                     //           listen: true)
//                     //       .blueDates
//                     //       .contains(formatedDate);
//                     // } else {
//                     //   isBlueDate = Provider.of<ParkingManagementProvider>(context,
//                     //           listen: true)
//                     //       .blueDates
//                     //       .contains(formatedDate);
//                     // }

//                     // if (Utils.isToday(date: day) && !isBlueDate) {
//                     //   return Padding(
//                     //     padding: const EdgeInsets.all(4.0),
//                     //     child: Container(
//                     //       decoration: BoxDecoration(
//                     //           border: Border.all(
//                     //         width: 2,
//                     //         color: HexColor(spaceManagementOrangeColor),
//                     //       )),
//                     //       child: Padding(
//                     //         padding: const EdgeInsets.all(2.0),
//                     //         child: Container(
//                     //           decoration: BoxDecoration(
//                     //             borderRadius: BorderRadius.circular(30),
//                     //             color: HexColor(spaceManagementOrangeColor),
//                     //           ),
//                     //           child: Center(
//                     //             child: Text(
//                     //               text.toString(),
//                     //               style: const TextStyle(color: Colors.black),
//                     //             ),
//                     //           ),
//                     //         ),
//                     //       ),
//                     //     ),
//                     //   );
//                     // }
//                   },
//                   todayBuilder: (context, day, date) {
//                     // String formatedDate = DateFormat('yyyy-MM-dd').format(day);
//                     // final text = day.day;
//                     // logInfo(
//                     //     msg:
//                     //         'Boolean: ${Provider.of<ParkingManagementProvider>(context, listen: false).blueDates.contains(formatedDate)} formated $formatedDate : blue ${Provider.of<ParkingManagementProvider>(context, listen: false).blueDates}');
//                     // if (widget.isForRescheduling) {
//                     //   if (Provider.of<ParkingManagementFragmentProvider>(context,
//                     //           listen: true)
//                     //       .blueDates
//                     //       .isNotEmpty) {
//                     //     if (Provider.of<ParkingManagementFragmentProvider>(context,
//                     //             listen: true)
//                     //         .blueDates
//                     //         .contains(formatedDate)) {
//                     //       // logInfo(msg: 'in if');
//                     //       return Padding(
//                     //         padding: const EdgeInsets.all(4.0),
//                     //         child: Container(
//                     //           color: HexColor(spaceManagementBlueDateColor),
//                     //           child: Center(
//                     //             child: Text(
//                     //               text.toString(),
//                     //               style: const TextStyle(color: Colors.black),
//                     //             ),
//                     //           ),
//                     //         ),
//                     //       );
//                     //     }
//                     //   }
//                     // } else {
//                     //   if (Provider.of<ParkingManagementProvider>(context,
//                     //           listen: true)
//                     //       .blueDates
//                     //       .isNotEmpty) {
//                     //     if (Provider.of<ParkingManagementProvider>(context,
//                     //             listen: true)
//                     //         .blueDates
//                     //         .contains(formatedDate)) {
//                     //       // logInfo(msg: 'in if');
//                     //       return Padding(
//                     //         padding: const EdgeInsets.all(4.0),
//                     //         child: Container(
//                     //           color: HexColor(spaceManagementBlueDateColor),
//                     //           child: Center(
//                     //             child: Text(
//                     //               text.toString(),
//                     //               style: const TextStyle(color: Colors.black),
//                     //             ),
//                     //           ),
//                     //         ),
//                     //       );
//                     //     }
//                     //   }
//                     // }
//                   },
//                   defaultBuilder: (context, day, date) {
//                     // String formatedDate = DateFormat('yyyy-MM-dd').format(day);
//                     // final text = day.day;
//                     // logInfo(
//                     //     msg:
//                     //         'Boolean: ${Provider.of<ParkingManagementProvider>(context, listen: false).blueDates.contains(formatedDate)} formated $formatedDate : blue ${Provider.of<ParkingManagementProvider>(context, listen: false).blueDates}');
//                     // if (widget.isForRescheduling) {
//                     //   if (Provider.of<ParkingManagementFragmentProvider>(context,
//                     //           listen: false)
//                     //       .blueDates
//                     //       .isNotEmpty) {
//                     //     if (Provider.of<ParkingManagementFragmentProvider>(context,
//                     //             listen: false)
//                     //         .blueDates
//                     //         .contains(formatedDate)) {
//                     //       // logInfo(msg: 'in if');
//                     //       return Padding(
//                     //         padding: const EdgeInsets.all(4.0),
//                     //         child: Container(
//                     //           color: HexColor(spaceManagementBlueDateColor),
//                     //           child: Center(
//                     //             child: Text(
//                     //               text.toString(),
//                     //               style: const TextStyle(color: Colors.black),
//                     //             ),
//                     //           ),
//                     //         ),
//                     //       );
//                     //     }
//                     //   }
//                     // } else {
//                     //   if (Provider.of<ParkingManagementProvider>(context,
//                     //           listen: false)
//                     //       .blueDates
//                     //       .isNotEmpty) {
//                     //     if (Provider.of<ParkingManagementProvider>(context,
//                     //             listen: false)
//                     //         .blueDates
//                     //         .contains(formatedDate)) {
//                     //       // logInfo(msg: 'in if');
//                     //       return Padding(
//                     //         padding: const EdgeInsets.all(4.0),
//                     //         child: Container(
//                     //           color: HexColor(spaceManagementBlueDateColor),
//                     //           child: Center(
//                     //             child: Text(
//                     //               text.toString(),
//                     //               style: const TextStyle(color: Colors.black),
//                     //             ),
//                     //           ),
//                     //         ),
//                     //       );
//                     //     }
//                     //   }
//                     // }
//                   },
//                 ),
//                 focusedDay: _focusedDay,
//               ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             Card(
//               child: Column(
//                 children: [
//                   if (context
//                       .watch<ParkingBookingCreateProvider>()
//                       .parkingCategories
//                       .isNotEmpty)
//                     Padding(
//                       padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const Text(
//                             'Vehicle Type',
//                             style: TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                           const SizedBox(
//                             height: 15,
//                           ),
//                           SizedBox(
//                             height: 30,
//                             child: ListView.builder(
//                               itemCount: context
//                                   .read<ParkingBookingCreateProvider>()
//                                   .parkingCategories
//                                   .length,
//                               scrollDirection: Axis.horizontal,
//                               itemBuilder: (context, index) {
//                                 final item = context
//                                     .read<ParkingBookingCreateProvider>()
//                                     .parkingCategories[index];
//                                 return vehicleTypeButton(
//                                     onPressed: () async {
//                                       // if (item.noOfParkings == null ||
//                                       //     item.noOfParkings! == 0) {
//                                       //   showToastDialog(
//                                       //       msg:
//                                       //           'No Parkings available for this Category!');
//                                       //   return;
//                                       // }
//                                       context
//                                           .read<ParkingBookingCreateProvider>()
//                                           .onParkingCategoryChanged(
//                                               value: item,
//                                               selectedDate: _focusedDay
//                                                   .toIso8601String());
//                                     },
//                                     image: item.imageUrl ?? '',
//                                     // title:
//                                     //     '${item.parkingCategory} - ${item.noOfParkings}',

//                                     title: '${item.name}',
//                                     isSelected: (context
//                                             .watch<
//                                                 ParkingBookingCreateProvider>()
//                                             .selectedParkingCategory
//                                             ?.id ==
//                                         item.id));
//                               },
//                             ),
//                           )
//                           // Row(
//                           //   children: [
//                           //     Expanded(
//                           //         child: vehicleTypeButton(
//                           //             isSelected: isFourWheelerSelected,
//                           //             onPressed: () {
//                           //               setState(() {
//                           //                 isFourWheelerSelected =
//                           //                     !isFourWheelerSelected;
//                           //                 isTwoWheelerSelected = false;
//                           //               });
//                           //             },
//                           //             image:
//                           //                 'assets/transport/parking_car_mini_icon.png',
//                           //             title: '4 Wheeler')),
//                           //     const SizedBox(
//                           //       width: 20,
//                           //     ),
//                           //     Expanded(
//                           //         child: vehicleTypeButton(
//                           //             isSelected: isTwoWheelerSelected,
//                           //             onPressed: () {
//                           //               setState(() {
//                           //                 isFourWheelerSelected = false;
//                           //                 isTwoWheelerSelected =
//                           //                     !isTwoWheelerSelected;
//                           //               });
//                           //             },
//                           //             image:
//                           //                 'assets/transport/parking_scooter_mini_icon.png',
//                           //             title: '2 Wheeler')),
//                           //   ],
//                           // ),
//                         ],
//                       ),
//                     ),

//                   if (context
//                       .watch<ParkingBookingCreateProvider>()
//                       .buildings
//                       .isNotEmpty)
//                     Row(
//                       children: [
//                         Expanded(
//                           child: Container(
//                             width: 120,
//                             height: 40,
//                             margin: const EdgeInsets.only(right: 20, left: 20),
//                             decoration: BoxDecoration(
//                                 shape: BoxShape.rectangle,
//                                 borderRadius: BorderRadius.circular(30),
//                                 border: Border.all(
//                                     color: HexColor(texfieldBorderColor))),
//                             child: Padding(
//                               padding:
//                                   const EdgeInsets.symmetric(horizontal: 10),
//                               child: DropdownButtonHideUnderline(
//                                 child: DropdownButton2<
//                                     ParkingBookingBuildingModel>(
//                                   // dropdownMaxHeight: 250,
//                                   // icon: const Icon(
//                                   //   Icons.arrow_drop_down,
//                                   //   color: Colors.black,
//                                   // ),
//                                   iconStyleData: const IconStyleData(
//                                     icon: Icon(
//                                       Icons.arrow_drop_down,
//                                       color: Colors.black,
//                                     ),
//                                   ),
//                                   dropdownStyleData: const DropdownStyleData(
//                                     maxHeight: 200,
//                                   ),
//                                   isExpanded: true,
//                                   hint: const Text(
//                                     'Tower*',
//                                     style: TextStyle(
//                                       color: Colors.grey,
//                                       fontSize: 12,
//                                     ),
//                                   ), // Not necessary for Option 1
//                                   // style: baseTextTheme
//                                   //     .loginTextFieldFloatingLabelTextStyle,
//                                   value: context
//                                       .watch<ParkingBookingCreateProvider>()
//                                       .selectedBuilding,
//                                   onChanged: (newValue) {
//                                     if (newValue != null) {
//                                       context
//                                           .read<ParkingBookingCreateProvider>()
//                                           .onBuildingChanged(value: newValue);
//                                       // context
//                                       //     .read<MomCreateProvider>()
//                                       //     .onCompanyTagSelected(
//                                       //         value: newValue);
//                                       // state.onCompanyTagSelected(value: newValue);
//                                     }
//                                   },
//                                   items: context
//                                       .read<ParkingBookingCreateProvider>()
//                                       .buildings
//                                       .map((item) {
//                                     return DropdownMenuItem(
//                                       value: item,
//                                       child: Text(
//                                         item.name ?? 'NA',
//                                         style: const TextStyle(
//                                           fontSize: 12,
//                                         ),
//                                       ),
//                                     );
//                                   }).toList(),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   const SizedBox(
//                     height: 10,
//                   ),
//                   if (context
//                       .watch<ParkingBookingCreateProvider>()
//                       .floors
//                       .isNotEmpty)
//                     GestureDetector(
//                       onTap: () async {
//                         final themeViewModel = Provider.of<ThemeViewModel>(context, listen: false);
//                         await showDialog(
//                           context: context,
//                           builder: (_) {
//                             return ChangeNotifierProvider.value(value: themeViewModel,
//                              child:BookParkingCalendarFloorSelectionDialog(
//                               parentContext: context,
//                               floors: context
//                                   .watch<ParkingBookingCreateProvider>()
//                                   .floors,
//                             ));
//                           },
//                         );
//                       },
//                       child: Row(
//                         children: [
//                           Expanded(
//                             child: Container(
//                               width: 120,
//                               height: 40,
//                               margin:
//                                   const EdgeInsets.only(right: 20, left: 20),
//                               decoration: BoxDecoration(
//                                   shape: BoxShape.rectangle,
//                                   borderRadius: BorderRadius.circular(30),
//                                   border: Border.all(
//                                       color: HexColor(texfieldBorderColor))),
//                               child: Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(horizontal: 10),
//                                 child: Row(
//                                   children: [
//                                     Padding(
//                                       padding: const EdgeInsets.only(left: 12),
//                                       child: Text(
//                                         context
//                                                     .watch<
//                                                         ParkingBookingCreateProvider>()
//                                                     .selectedFloor
//                                                     ?.name ==
//                                                 null
//                                             ? 'Select Floor'
//                                             : context
//                                                 .watch<
//                                                     ParkingBookingCreateProvider>()
//                                                 .selectedFloor!
//                                                 .name!,
//                                         style: const TextStyle(
//                                           fontSize: 12,
//                                         ),
//                                       ),
//                                     ),
//                                     const Spacer(),
//                                     const Icon(Icons.arrow_drop_down),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),

//                   // if (context.watch<ParkingBookingCreateProvider>().slots.isNotEmpty)
//                   //   BookParkingTimeSlotWidget(
//                   //     slots: context.read<ParkingBookingCreateProvider>().slots,
//                   //   ),
//                   if (context
//                               .watch<ParkingBookingCreateProvider>()
//                               .selectedParkingCategory !=
//                           null &&
//                       context
//                           .watch<ParkingBookingCreateProvider>()
//                           .slots
//                           .isNotEmpty)
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Padding(
//                           padding:
//                               EdgeInsets.only(left: 20, right: 20, top: 20),
//                           child: Text(
//                             "Choose Time",
//                             style: TextStyle(fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                         // RangeSlider(
//                         //   values: _currentRangeValues,
//                         //   max: 24,
//                         //   min: 0,
//                         //   divisions: 24,
//                         //   labels: RangeLabels(0, end),
//                         //   // labels: RangeLabels(
//                         //   //   _currentRangeValues.start.round().toString(),
//                         //   //   _currentRangeValues.end.round().toString(),
//                         //   // ),
//                         //   onChanged: (RangeValues values) {
//                         //     setState(() {
//                         //       _currentRangeValues = values;
//                         //     });
//                         //   },
//                         // ),
//                         if (context
//                                 .watch<ParkingBookingCreateProvider>()
//                                 .currentRangeValues !=
//                             null)
//                           SfRangeSlider(
//                             min: context
//                                 .watch<ParkingBookingCreateProvider>()
//                                 .minTimeInternal,
//                             max: context
//                                 .watch<ParkingBookingCreateProvider>()
//                                 .maxTimeInternal,
//                             values: context
//                                 .watch<ParkingBookingCreateProvider>()
//                                 .currentRangeValues!,
//                             interval: 2,
//                             showTicks: true,
//                             showLabels: true,
//                             enableTooltip: true,
//                             dragMode: SliderDragMode.onThumb,
//                             stepSize: 1,
//                             labelPlacement: LabelPlacement.onTicks,
//                             minorTicksPerInterval: 1,
//                             onChanged: (SfRangeValues values) {
//                               context
//                                   .read<ParkingBookingCreateProvider>()
//                                   .onTimeRangeChanged(value: values);
//                               // setState(() {
//                               //   _currentRangeValues = values;
//                               // });
//                             },
//                           ),

//                         // Padding(
//                         //   padding: const EdgeInsets.symmetric(horizontal: 20),
//                         //   child: Container(
//                         //       height: 40,
//                         //       width: double.infinity,
//                         //       // width: 400,
//                         //       // width: 200,
//                         //       child: ListView.builder(
//                         //         scrollDirection: Axis.horizontal,
//                         //         physics: const NeverScrollableScrollPhysics(),
//                         //         itemCount: 24,
//                         //         itemBuilder: (context, index) {
//                         //           return Padding(
//                         //             padding: index > 0 && index < 24
//                         //                 ? const EdgeInsets.symmetric(horizontal: 5)
//                         //                 : EdgeInsets.zero,
//                         //             child: Column(
//                         //               crossAxisAlignment: CrossAxisAlignment.center,
//                         //               children: [
//                         //                 Container(
//                         //                   height: index % 4 == 0 ? 10 : 5,
//                         //                   color: Colors.grey,
//                         //                   width: 1,
//                         //                 ),
//                         //                 Text(
//                         //                   '${timeSlots[index]}\n${index >= 4 ? 'PM' : 'AM'}',
//                         //                   textAlign: TextAlign.center,
//                         //                   style: TextStyle(
//                         //                       fontSize: index % 4 == 0 ? 12 : 10,
//                         //                       color: index % 4 == 0
//                         //                           ? Colors.black
//                         //                           : HexColor('#E3E3E3'),
//                         //                       fontWeight: index % 4 == 0
//                         //                           ? FontWeight.bold
//                         //                           : null),
//                         //                 )
//                         //               ],
//                         //             ),
//                         //           );
//                         //         },
//                         //       )),
//                         // ),
//                         const SizedBox(
//                           height: 10,
//                         )
//                       ],
//                     ),
//                 ],
//               ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),

//             // BuildAndFloorTextTile(
//             //   title: context
//             //               .watch<ParkingBookingCreateProvider>()
//             //               .selectedFloor
//             //               ?.name ==
//             //           null
//             //       ? 'Select Floor'
//             //       : context
//             //           .watch<ParkingBookingCreateProvider>()
//             //           .selectedFloor!
//             //           .name!,
//             //   onTap: () async {
//             //     await showDialog(
//             //       context: context,
//             //       builder: (_) {
//             //         return BookParkingCalendarFloorSelectionDialog(
//             //           parentContext: context,
//             //           floors:
//             //               context.watch<ParkingBookingCreateProvider>().floors,
//             //         );
//             //       },
//             //     );
//             //   },
//             // ),
//             // if (context.watch<ParkingBookingCreateProvider>().floors.isNotEmpty)
//             //   Row(
//             //     children: [
//             //       Expanded(
//             //         child: Container(
//             //           width: 120,
//             //           height: 40,
//             //           margin: const EdgeInsets.only(right: 20, left: 20),
//             //           decoration: BoxDecoration(
//             //               shape: BoxShape.rectangle,
//             //               borderRadius: BorderRadius.circular(30),
//             //               border:
//             //                   Border.all(color: HexColor(texfieldBorderColor))),
//             //           child: Padding(
//             //             padding: const EdgeInsets.symmetric(horizontal: 10),
//             //             child: DropdownButtonHideUnderline(
//             //               child: DropdownButton2<ParkingBookingFloorModel>(
//             //                 dropdownMaxHeight: 250,
//             //                 icon: const Icon(
//             //                   Icons.arrow_drop_down,
//             //                   color: Colors.black,
//             //                 ),
//             //                 isExpanded: true,
//             //                 hint: const Text(
//             //                   'Floor*',
//             //                   style: TextStyle(
//             //                     color: Colors.grey,
//             //                     fontSize: 12,
//             //                   ),
//             //                 ), // Not necessary for Option 1
//             //                 // style: baseTextTheme
//             //                 //     .loginTextFieldFloatingLabelTextStyle,
//             //                 value: context
//             //                     .watch<ParkingBookingCreateProvider>()
//             //                     .selectedFloor,
//             //                 onChanged: (newValue) {
//             //                   if (newValue != null) {
//             //                     context
//             //                         .read<ParkingBookingCreateProvider>()
//             //                         .onFloorChanged(value: newValue);
//             //                     // state.onCompanyTagSelected(value: newValue);
//             //                   }
//             //                 },
//             //                 items: context
//             //                     .read<ParkingBookingCreateProvider>()
//             //                     .floors
//             //                     .map((item) {
//             //                   return DropdownMenuItem(
//             //                     value: item,
//             //                     child: Row(
//             //                       mainAxisAlignment:
//             //                           MainAxisAlignment.spaceBetween,
//             //                       children: [
//             //                         Text(
//             //                           item.name ?? 'NA',
//             //                           style: const TextStyle(
//             //                             fontSize: 12,
//             //                           ),
//             //                         ),
//             //                         Text(
//             //                           item.availableParkings != null
//             //                               ? item.availableParkings.toString()
//             //                               : 'NA',
//             //                           style: const TextStyle(
//             //                             fontSize: 12,
//             //                           ),
//             //                         ),
//             //                       ],
//             //                     ),
//             //                   );
//             //                 }).toList(),
//             //               ),
//             //             ),
//             //           ),
//             //         ),
//             //       ),
//             //     ],
//             //   ),

//             const SizedBox(
//               height: 50,
//             )
//           ],
//         ),
//       ),
//       bottomSheet: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Row(
//             children: [
//               CommonButton(
//                 title: 'Proceed',
//                 onTap: () async {
//                   context
//                       .read<ParkingBookingCreateProvider>()
//                       .onProceedClicked()
//                       .then((value) {
//                     if (value == true) {
//                       Navigator.push(context, MaterialPageRoute(
//                         builder: (context) {
//                           return const BookParkingSummaryScreen();
//                         },
//                       )).then((value) {
//                         if (value != null && value! as bool) {
//                           Provider.of<ParkingBookingCreateProvider>(context,
//                                   listen: false)
//                               .init(
//                                   selectedDate:
//                                       DateTime.now().toIso8601String());
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(builder: (context) {
//                               return const ParkingBookingsScreen();
//                             }),
//                           );
//                         }
//                       });
//                     }
//                   });
//                   // Navigator.push(context, MaterialPageRoute(
//                   //   builder: (context) {
//                   //     return const BookParkingSummaryScreen();
//                   //   },
//                   // ));
//                   // await showDialog(context: context, builder:(context) {
//                   //   return BookParkingLoadingDialog();
//                   // },);
//                 },
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   Widget vehicleTypeButton(
//       {required void Function()? onPressed,
//       required String image,
//       required String title,
//       required bool isSelected}) {
//     return GestureDetector(
//       onTap: onPressed,
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 10),
//         child: Container(
//             // width: 155,
//             decoration: BoxDecoration(
//                 color: isSelected ? HexColor(ticketTabColor) : null,
//                 borderRadius: BorderRadius.circular(25),
//                 border: Border.all(color: Colors.orange)),

//             // style: ButtonStyle(
//             //     backgroundColor: MaterialStateProperty.all(
//             //         isSelected ? HexColor(ticketTabColor) : null),
//             //     shape: MaterialStateProperty.all(RoundedRectangleBorder(
//             //         side: const BorderSide(
//             //           color: Colors.orange,
//             //         ),
//             //         borderRadius: BorderRadius.circular(25)))),

//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 15),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   // Image.asset(
//                   //   image,
//                   //   height: 20,
//                   // ),
//                   ImageCardWidget(
//                     image: image,
//                     radius: BorderRadius.zero,
//                     height: 20,
//                     padding: 0,
//                   ),
//                   const SizedBox(
//                     width: 10,
//                   ),
//                   Text(
//                     title,
//                     style: TextStyle(
//                       color: isSelected ? Colors.white : HexColor('#111111'),
//                       fontSize: 14,
//                     ),
//                   )
//                 ],
//               ),
//             )),
//       ),
//     );
//   }
// }
