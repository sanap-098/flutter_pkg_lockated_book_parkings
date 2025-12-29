import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_pkg_lockated_book_parking/features/providers/parking_management/parking_management_fragment_provider.dart';
import 'package:flutter_pkg_lockated_book_parking/features/providers/parking_management/parking_management_provider.dart';
import 'package:flutter_pkg_lockated_book_parking/utils/constants.dart';
import 'package:flutter_pkg_lockated_book_parking/utils/utils.dart';
import 'package:flutter_pkg_lockated_book_parking/core/themes/theme_view_model.dart'; // Import

class ParkingManagementCustomCalendarWidget extends StatefulWidget {
  const ParkingManagementCustomCalendarWidget(
      {Key? key, this.isForRescheduling = false})
      : super(key: key);
  final bool isForRescheduling;

  @override
  State<ParkingManagementCustomCalendarWidget> createState() =>
      _ParkingManagementCustomCalendarWidgetState();
}

class _ParkingManagementCustomCalendarWidgetState
    extends State<ParkingManagementCustomCalendarWidget> {
  @override
  Widget build(BuildContext context) {
    final themeViewModel = context.watch<ThemeViewModel>();
    final colors = themeViewModel.colors;

    return (widget.isForRescheduling
            ? Provider.of<ParkingManagementFragmentProvider>(context,
                    listen: true)
                .showCalendar
            : Provider.of<ParkingManagementProvider>(context, listen: true)
                .showCalendar)
        ? TableCalendar(
            calendarFormat: CalendarFormat.month,
            weekendDays: const [DateTime.sunday],
            startingDayOfWeek: StartingDayOfWeek.monday,
            calendarStyle: CalendarStyle(
              weekendTextStyle: const TextStyle(
                color: Colors.blue,
              ),
              selectedDecoration: BoxDecoration(
                // Use theme selected date color
                color: isDateSelectedAndPresentInBlueDates(
                  day: widget.isForRescheduling
                      ? Provider.of<ParkingManagementFragmentProvider>(context,
                              listen: true)
                          .selectedDay
                      : Provider.of<ParkingManagementProvider>(context,
                              listen: true)
                          .selectedDay,
                  blueDates: widget.isForRescheduling
                      ? Provider.of<ParkingManagementFragmentProvider>(context,
                              listen: true)
                          .blueDates
                      : Provider.of<ParkingManagementProvider>(context,
                              listen: true)
                          .blueDates,
                )
                    ? HexColor(calendarBlue) // Or use a theme color for "blue dates" if available
                    : Colors.white,
                border: Border.all(
                  width: 2,
                  color: colors.primaryColor, // Use Primary Color from Theme
                ),
              ),
              selectedTextStyle: const TextStyle(
                color: Colors.black,
              ),
              todayDecoration: BoxDecoration(
                color: colors.primaryColor, // Use Primary Color
                shape: BoxShape.circle,
              ),
            ),
            headerStyle: const HeaderStyle(
              titleCentered: true,
              formatButtonVisible: false,
            ),
            selectedDayPredicate: (day) {
               if (widget.isForRescheduling) {
                return isSameDay(
                    Provider.of<ParkingManagementFragmentProvider>(context,
                            listen: false)
                        .selectedDay,
                    day);
              } else {
                return isSameDay(
                    Provider.of<ParkingManagementProvider>(context,
                            listen: false)
                        .selectedDay,
                    day);
              }
            },
            onDaySelected: (selectedDay, focusedDay) {
              if (widget.isForRescheduling) {
                if (!isSameDay(
                    Provider.of<ParkingManagementFragmentProvider>(context,
                            listen: false)
                        .selectedDay,
                    selectedDay)) {
                  Provider.of<ParkingManagementFragmentProvider>(context,
                          listen: false)
                      .dateSelected(
                          context: context,
                          selectDay: selectedDay,
                          focusDay: focusedDay);
                }
              } else {
                if (!isSameDay(
                    Provider.of<ParkingManagementProvider>(context,
                            listen: false)
                        .selectedDay,
                    selectedDay)) {
                  Provider.of<ParkingManagementProvider>(context, listen: false)
                      .dateSelected(
                          context: context,
                          selectDay: selectedDay,
                          focusDay: focusedDay);
                }
              }
            },
            firstDay: DateTime(1990),
            focusedDay: widget.isForRescheduling
                ? context.watch<ParkingManagementFragmentProvider>().focusedDay
                : context.watch<ParkingManagementProvider>().focusedDay,
            lastDay: DateTime(3000),
            calendarBuilders: CalendarBuilders(
              selectedBuilder: (context, day, date) {
                String formatedDate = DateFormat('yyyy-MM-dd').format(day);
                final text = day.day;

                bool isBlueDate = false;

                if (widget.isForRescheduling) {
                  isBlueDate = Provider.of<ParkingManagementFragmentProvider>(
                          context,
                          listen: true)
                      .blueDates
                      .contains(formatedDate);
                } else {
                  isBlueDate = Provider.of<ParkingManagementProvider>(context,
                          listen: true)
                      .blueDates
                      .contains(formatedDate);
                }

                if (Utils.isToday(date: day) && !isBlueDate) {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(
                        width: 2,
                        color: colors.primaryColor, // Use Theme Color
                      )),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: colors.primaryColor, // Use Theme Color
                          ),
                          child: Center(
                            child: Text(
                              text.toString(),
                              style: const TextStyle(color: Colors.white), // Usually white on primary
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }
                return null; 
              },
              todayBuilder: (context, day, date) {
                String formatedDate = DateFormat('yyyy-MM-dd').format(day);
                final text = day.day;
                 if (widget.isForRescheduling) {
                  if (Provider.of<ParkingManagementFragmentProvider>(context,
                          listen: true)
                      .blueDates
                      .isNotEmpty) {
                    if (Provider.of<ParkingManagementFragmentProvider>(context,
                            listen: true)
                        .blueDates
                        .contains(formatedDate)) {
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          color: HexColor(spaceManagementBlueDateColor),
                          child: Center(
                            child: Text(
                              text.toString(),
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      );
                    }
                  }
                } else {
                  if (Provider.of<ParkingManagementProvider>(context,
                          listen: true)
                      .blueDates
                      .isNotEmpty) {
                    if (Provider.of<ParkingManagementProvider>(context,
                            listen: true)
                        .blueDates
                        .contains(formatedDate)) {
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          color: HexColor(spaceManagementBlueDateColor),
                          child: Center(
                            child: Text(
                              text.toString(),
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      );
                    }
                  }
                }
                return null;
              },
              defaultBuilder: (context, day, date) {
                String formatedDate = DateFormat('yyyy-MM-dd').format(day);
                final text = day.day;
                if (widget.isForRescheduling) {
                  if (Provider.of<ParkingManagementFragmentProvider>(context,
                          listen: false)
                      .blueDates
                      .isNotEmpty) {
                    if (Provider.of<ParkingManagementFragmentProvider>(context,
                            listen: false)
                        .blueDates
                        .contains(formatedDate)) {
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          color: HexColor(spaceManagementBlueDateColor),
                          child: Center(
                            child: Text(
                              text.toString(),
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      );
                    }
                  }
                } else {
                  if (Provider.of<ParkingManagementProvider>(context,
                          listen: false)
                      .blueDates
                      .isNotEmpty) {
                    if (Provider.of<ParkingManagementProvider>(context,
                            listen: false)
                        .blueDates
                        .contains(formatedDate)) {
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          color: HexColor(spaceManagementBlueDateColor),
                          child: Center(
                            child: Text(
                              text.toString(),
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      );
                    }
                  }
                }
                return null;
              },
            ),
          )
        : Container();
  }

  bool isDateSelectedAndPresentInBlueDates(
      {required DateTime day, List<String> blueDates = const []}) {
    String formatedDate = DateFormat('yyyy-MM-dd').format(day);
    if (blueDates.isNotEmpty) {
      if (blueDates.contains(formatedDate)) {
        return true;
      }
    }
    return false;
  }
}



// import 'package:flutter/material.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:table_calendar/table_calendar.dart';
// import 'package:flutter_pkg_lockated_book_parking/features/providers/parking_management/parking_management_fragment_provider.dart';
// import 'package:flutter_pkg_lockated_book_parking/features/providers/parking_management/parking_management_provider.dart';
// import 'package:flutter_pkg_lockated_book_parking/utils/constants.dart';
// import 'package:flutter_pkg_lockated_book_parking/utils/utils.dart';

// class ParkingManagementCustomCalendarWidget extends StatefulWidget {
//   const ParkingManagementCustomCalendarWidget(
//       {Key? key, this.isForRescheduling = false})
//       : super(key: key);
//   final bool isForRescheduling;

//   @override
//   State<ParkingManagementCustomCalendarWidget> createState() =>
//       _ParkingManagementCustomCalendarWidgetState();
// }

// class _ParkingManagementCustomCalendarWidgetState
//     extends State<ParkingManagementCustomCalendarWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return (widget.isForRescheduling
//             ? Provider.of<ParkingManagementFragmentProvider>(context,
//                     listen: true)
//                 .showCalendar
//             : Provider.of<ParkingManagementProvider>(context, listen: true)
//                 .showCalendar)
//         ? TableCalendar(
//             calendarFormat: CalendarFormat.month,
//             weekendDays: const [DateTime.sunday],
//             startingDayOfWeek: StartingDayOfWeek.monday,
//             calendarStyle: CalendarStyle(
//               weekendTextStyle: const TextStyle(
//                 color: Colors.blue,
//               ),
//               selectedDecoration: BoxDecoration(
//                 color: isDateSelectedAndPresentInBlueDates(
//                   day: widget.isForRescheduling
//                       ? Provider.of<ParkingManagementFragmentProvider>(context,
//                               listen: true)
//                           .selectedDay
//                       : Provider.of<ParkingManagementProvider>(context,
//                               listen: true)
//                           .selectedDay,
//                   blueDates: widget.isForRescheduling
//                       ? Provider.of<ParkingManagementFragmentProvider>(context,
//                               listen: true)
//                           .blueDates
//                       : Provider.of<ParkingManagementProvider>(context,
//                               listen: true)
//                           .blueDates,
//                 )
//                     ? HexColor(calendarBlue)
//                     : Colors.white,
//                 border: Border.all(
//                   width: 2,
//                   color: HexColor(spaceManagementOrangeColor),
//                 ),
//               ),
//               selectedTextStyle: const TextStyle(
//                 color: Colors.black,
//               ),
//               todayDecoration: BoxDecoration(
//                 color: HexColor(spaceManagementOrangeColor),
//                 shape: BoxShape.circle,
//               ),
//             ),
//             headerStyle: const HeaderStyle(
//               titleCentered: true,
//               formatButtonVisible: false,
//             ),
//             selectedDayPredicate: (day) {
//               // Use `selectedDayPredicate` to determine which day is currently selected.
//               // If this returns true, then `day` will be marked as selected.

//               // Using `isSameDay` is recommended to disregard
//               // the time-part of compared DateTime objects.
//               if (widget.isForRescheduling) {
//                 return isSameDay(
//                     Provider.of<ParkingManagementFragmentProvider>(context,
//                             listen: false)
//                         .selectedDay,
//                     day);
//               } else {
//                 return isSameDay(
//                     Provider.of<ParkingManagementProvider>(context,
//                             listen: false)
//                         .selectedDay,
//                     day);
//               }
//             },
//             onDaySelected: (selectedDay, focusedDay) {
//               if (widget.isForRescheduling) {
//                 if (!isSameDay(
//                     Provider.of<ParkingManagementFragmentProvider>(context,
//                             listen: false)
//                         .selectedDay,
//                     selectedDay)) {
//                   // Call `setState()` when updating the selected day
//                   Provider.of<ParkingManagementFragmentProvider>(context,
//                           listen: false)
//                       .dateSelected(
//                           context: context,
//                           selectDay: selectedDay,
//                           focusDay: focusedDay);
//                 }
//               } else {
//                 if (!isSameDay(
//                     Provider.of<ParkingManagementProvider>(context,
//                             listen: false)
//                         .selectedDay,
//                     selectedDay)) {
//                   // Call `setState()` when updating the selected day
//                   Provider.of<ParkingManagementProvider>(context, listen: false)
//                       .dateSelected(
//                           context: context,
//                           selectDay: selectedDay,
//                           focusDay: focusedDay);
//                 }
//               }
//             },
//             firstDay: DateTime(1990),
//             focusedDay: widget.isForRescheduling
//                 ? context.watch<ParkingManagementFragmentProvider>().focusedDay
//                 : context.watch<ParkingManagementProvider>().focusedDay,
//             lastDay: DateTime(3000),
//             //onVisibleDaysChanged: _onVisibleDaysChanged,
//             calendarBuilders: CalendarBuilders(
//               selectedBuilder: (context, day, date) {
//                 String formatedDate = DateFormat('yyyy-MM-dd').format(day);
//                 final text = day.day;

//                 bool isBlueDate = false;

//                 if (widget.isForRescheduling) {
//                   isBlueDate = Provider.of<ParkingManagementFragmentProvider>(
//                           context,
//                           listen: true)
//                       .blueDates
//                       .contains(formatedDate);
//                 } else {
//                   isBlueDate = Provider.of<ParkingManagementProvider>(context,
//                           listen: true)
//                       .blueDates
//                       .contains(formatedDate);
//                 }

//                 if (Utils.isToday(date: day) && !isBlueDate) {
//                   return Padding(
//                     padding: const EdgeInsets.all(4.0),
//                     child: Container(
//                       decoration: BoxDecoration(
//                           border: Border.all(
//                         width: 2,
//                         color: HexColor(spaceManagementOrangeColor),
//                       )),
//                       child: Padding(
//                         padding: const EdgeInsets.all(2.0),
//                         child: Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(30),
//                             color: HexColor(spaceManagementOrangeColor),
//                           ),
//                           child: Center(
//                             child: Text(
//                               text.toString(),
//                               style: const TextStyle(color: Colors.black),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 }
//               },
//               todayBuilder: (context, day, date) {
//                 String formatedDate = DateFormat('yyyy-MM-dd').format(day);
//                 final text = day.day;
//                 // logInfo(
//                 //     msg:
//                 //         'Boolean: ${Provider.of<ParkingManagementProvider>(context, listen: false).blueDates.contains(formatedDate)} formated $formatedDate : blue ${Provider.of<ParkingManagementProvider>(context, listen: false).blueDates}');
//                 if (widget.isForRescheduling) {
//                   if (Provider.of<ParkingManagementFragmentProvider>(context,
//                           listen: true)
//                       .blueDates
//                       .isNotEmpty) {
//                     if (Provider.of<ParkingManagementFragmentProvider>(context,
//                             listen: true)
//                         .blueDates
//                         .contains(formatedDate)) {
//                       // logInfo(msg: 'in if');
//                       return Padding(
//                         padding: const EdgeInsets.all(4.0),
//                         child: Container(
//                           color: HexColor(spaceManagementBlueDateColor),
//                           child: Center(
//                             child: Text(
//                               text.toString(),
//                               style: const TextStyle(color: Colors.black),
//                             ),
//                           ),
//                         ),
//                       );
//                     }
//                   }
//                 } else {
//                   if (Provider.of<ParkingManagementProvider>(context,
//                           listen: true)
//                       .blueDates
//                       .isNotEmpty) {
//                     if (Provider.of<ParkingManagementProvider>(context,
//                             listen: true)
//                         .blueDates
//                         .contains(formatedDate)) {
//                       // logInfo(msg: 'in if');
//                       return Padding(
//                         padding: const EdgeInsets.all(4.0),
//                         child: Container(
//                           color: HexColor(spaceManagementBlueDateColor),
//                           child: Center(
//                             child: Text(
//                               text.toString(),
//                               style: const TextStyle(color: Colors.black),
//                             ),
//                           ),
//                         ),
//                       );
//                     }
//                   }
//                 }
//               },
//               defaultBuilder: (context, day, date) {
//                 String formatedDate = DateFormat('yyyy-MM-dd').format(day);
//                 final text = day.day;
//                 // logInfo(
//                 //     msg:
//                 //         'Boolean: ${Provider.of<ParkingManagementProvider>(context, listen: false).blueDates.contains(formatedDate)} formated $formatedDate : blue ${Provider.of<ParkingManagementProvider>(context, listen: false).blueDates}');
//                 if (widget.isForRescheduling) {
//                   if (Provider.of<ParkingManagementFragmentProvider>(context,
//                           listen: false)
//                       .blueDates
//                       .isNotEmpty) {
//                     if (Provider.of<ParkingManagementFragmentProvider>(context,
//                             listen: false)
//                         .blueDates
//                         .contains(formatedDate)) {
//                       // logInfo(msg: 'in if');
//                       return Padding(
//                         padding: const EdgeInsets.all(4.0),
//                         child: Container(
//                           color: HexColor(spaceManagementBlueDateColor),
//                           child: Center(
//                             child: Text(
//                               text.toString(),
//                               style: const TextStyle(color: Colors.black),
//                             ),
//                           ),
//                         ),
//                       );
//                     }
//                   }
//                 } else {
//                   if (Provider.of<ParkingManagementProvider>(context,
//                           listen: false)
//                       .blueDates
//                       .isNotEmpty) {
//                     if (Provider.of<ParkingManagementProvider>(context,
//                             listen: false)
//                         .blueDates
//                         .contains(formatedDate)) {
//                       // logInfo(msg: 'in if');
//                       return Padding(
//                         padding: const EdgeInsets.all(4.0),
//                         child: Container(
//                           color: HexColor(spaceManagementBlueDateColor),
//                           child: Center(
//                             child: Text(
//                               text.toString(),
//                               style: const TextStyle(color: Colors.black),
//                             ),
//                           ),
//                         ),
//                       );
//                     }
//                   }
//                 }
//               },
//             ),
//           )
//         : Container();
//   }

//   bool isDateSelectedAndPresentInBlueDates(
//       {required DateTime day, List<String> blueDates = const []}) {
//     String formatedDate = DateFormat('yyyy-MM-dd').format(day);
//     // final text = day.day;
//     if (blueDates.isNotEmpty) {
//       if (blueDates.contains(formatedDate)) {
//         return true;
//       }
//     }
//     return false;
//   }
// }
