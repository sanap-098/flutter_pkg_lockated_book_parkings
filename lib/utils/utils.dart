import 'dart:convert';
import 'dart:developer';
import 'dart:io';
// import 'package:appcheck/appcheck.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_pkg_lockated_book_parking/core/themes/theme_view_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/providers/parking_booking/parking_booking_create_provider.dart';
// import 'package:flutter_go_phygital/core/repository/i_user_repository.dart';
// import 'package:flutter_go_phygital/core/routes.dart';
// import 'package:flutter_go_phygital/models/route_models/asset_stats/daily_task_route_model.dart';
// import 'package:flutter_go_phygital/models/route_models/events/event_details_route_model.dart';
// import 'package:flutter_go_phygital/repository/user_repository.dart';
// import 'package:flutter_go_phygital/screens/events/event_details_screen/event_details_screen.dart';
// import 'package:flutter_go_phygital/screens/home/home_screen_go_phygital.dart';
// import 'package:flutter_go_phygital/screens/home/tabs/home_tab_go_phygital/widgets/fit/home_tab_fitness_scoreboard_details_screen/home_tab_fitness_scoreboard_details_screen.dart';
import 'package:flutter_pkg_lockated_book_parking/features/screens/parking/book_parking_calendar_screen/book_parking_calendar_screen.dart';
// import 'package:flutter_go_phygital/services/offline_services/database/notification_offline_database.dart';
import 'package:flutter_pkg_lockated_book_parking/utils/analytics_event_names.dart';
import 'package:flutter_pkg_lockated_book_parking/utils/custom_logger.dart';
import 'package:flutter_pkg_lockated_book_parking/utils/prefs.dart';
// import 'package:flutter_go_phygital/utils/user_roles_controller.dart';
import 'package:flutter_pkg_lockated_book_parking/widgets/common/toast_dialog.dart';
// import 'package:flutter_pkg_lockated_book_parking/widgets/common/toast_dialog.dart';
// import 'package:flutter_pkg_lockated_chats/features/chats_view/screens/chats_view_screen.dart';
// import 'package:flutter_pkg_lockated_chats/utils/constant.dart';
// import 'package:flutter_pkg_lockated_msafe/features/msafe/screens/msafe_screen.dart';
// import 'package:flutter_pkg_lockated_msafe/features/msafe/screens/msafe_user_request_screen.dart';
// import 'package:flutter_pkg_lockated_task_management/flutter_pkg_lockated_task_management.dart';
// import 'package:flutter_pkg_lockated_task_management/utils/constant.dart';
// import 'package:flutter_pkg_lockated_travel/features/check_in/providers/check_in_out_provider.dart';
// import 'package:flutter_pkg_lockated_travel/features/check_out/screens/check_out_screen/check_out_screen.dart';
// import 'package:flutter_pkg_lockated_travel/features/travel/repository/i_travel_repository.dart';
// import 'package:flutter_pkg_lockated_travel/features/travel/repository/travel_repository.dart';
// import 'package:flutter_pkg_lockated_travel/features/travel/screens/travel_screen.dart';
// import 'package:flutter_pkg_lockated_travel/features/vehicle_registration/screens/vehicle_registration/vehicle_registration_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:mime/mime.dart';
import 'package:ndialog/ndialog.dart';
import 'package:open_file_safe_plus/open_file_safe_plus.dart';
// import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
// import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:table_calendar/table_calendar.dart';
import 'package:url_launcher/url_launcher.dart';

// import '../core/global_variable.dart';
// import '../core/repository/i_space_management_repository.dart';
// import '../features/facility_bookings/screens/booked_facility_details/facility_bookings_booked_facility_details_screen.dart';
// import '../models/buildings/building_model/building_model.dart';
// import '../models/floors/floor_model/floor_model.dart';
// import '../models/mailroom/inbound_mail_response_model/inbound_mail_model.dart';
// import '../models/route_models/asset_stats/daily_task_details_route_model.dart';
// import '../models/route_models/facility_bookings/booked_facility_details_route_model.dart';
// import '../models/route_models/fitout/fitout_detail_route_model.dart';
// import '../models/route_models/helpdesk_detail_route_model.dart';
// import '../models/route_models/notice/notice_details_route_model.dart';
// import '../models/route_models/space_management/book_space_date_and_slot_route_model.dart';
// import '../models/route_models/space_management/booking_details_screen_route_model.dart';
// import '../models/route_models/visitor/visitor_details_route_model.dart';
// import '../models/static_model/notification_static_model/notification_static_model.dart';
// import '../repository/space_management_repository.dart';
// import '../screens/assets/daily_task_details_screen/daily_task_details_screen.dart';
// import '../screens/fitout/fitout_detail_screen/fitout_detail_screen.dart';
// import '../screens/mailroom/mailroom_inbound_details_screen/mailroom_inbound_details_screen.dart';
// import '../screens/notices/notice_details_screen/notice_details_screen.dart';
// import '../screens/space_management/book_space_date_and_slot_screen/book_space_date_and_slot_screen.dart';
// import '../screens/space_management/booking_detail_screen/booking_detail_screen.dart';
// import '../screens/space_management/space_management_screen/space_management_screen.dart';
// import '../screens/tickets/hekpdesk_detail_screen/helpdesk_detail_screen.dart';
// import '../screens/visitor/visitor_details_screen/visitor_details_screen.dart';
import '../widgets/common/loading_dialog.dart';
import 'constants.dart';
// import 'prefs.dart';

class Utils {
  static isSameDay(DateTime dateOne, DateTime dateTwo) {
    return dateOne.day == dateTwo.day &&
        dateOne.month == dateTwo.month &&
        dateOne.year == dateTwo.year;
  }

  static Future<void> callNumber({required String contactNum}) async {
    if (contactNum.isEmpty) {
      showToastDialog(msg: 'Mobile Number Unavailable');
    } else {
      final url = "tel:$contactNum";
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        logError(msg: 'Unable to launch Url');
      }
    }
  }

  static bool isNotNullOrNotEmpty(dynamic value) {
    if (value != null && value != '' && value != 'null') {
      return true;
    }
    return false;
  }

  static bool isToday({required DateTime date}) {
    DateTime now = DateTime.now();
    if (now.day == date.day &&
        now.month == date.month &&
        now.year == date.year) {
      return true;
    }
    return false;
  }

  static bool matchDate({required DateTime date1, required DateTime date2}) {
    if (date1.day == date2.day &&
        date1.month == date2.month &&
        date1.year == date2.year) {
      return true;
    }
    return false;
  }

  static String parseToSimpleDateFormat({required String date}) {
    try {
      DateTime tempDate = DateTime.parse(date);
      return '${tempDate.day}/${tempDate.month}/${tempDate.year}';
    } catch (e) {
      logError(msg: e);
      return "dd/MM/yyyy";
    }
  }

  static bool dateIsBefore({required DateTime date}) {
    DateTime now = DateTime.now();
    if (now.year >= date.year &&
        now.month >= date.month &&
        now.day > date.day) {
      return true;
    } else {
      return false;
    }
    // return date.isBefore(DateTime.now());
  }

  static String ddMonYearAmPmTimeFormat({required String date}) {
    String date1;
    if (!(date == "null")) {
      date1 = dateTrim2(date);
      String trimTime = timeAmPm(date);
      date = (date1 + " " + trimTime);
    } else {
      date = "No Date";
    }
    return date;
  }

  static String ddMonYearAmPmTimeFormat3({required String fullDate}) {
    // 1-11-2016 11:16 AM
    String date1, fulldate;
    if (fullDate != null && !(fullDate == "")) {
      date1 = dateTrim3(fullDate);
      String trimTime = m12TimeFormat3(fullDate);
      fulldate = (date1 + " " + trimTime);
    } else {
      fulldate = "No Date";
    }

    return fulldate;
  }

  static String dateTrim3(String dateString) {
    String trimDate = "No data";
    if (dateString != null && !(dateString == "")) {
      try {
        if (dateString.contains("T")) {
          trimDate = dateString.substring(0, dateString.indexOf("T"));
        } else {
          trimDate = dateString;
        }

        // trimDate = dateString.substring(0, dateString.indexOf("T"));

        DateFormat format = DateFormat("yyyy-MM-dd");
        DateTime date = format.parse(trimDate);
        trimDate = DateFormat("dd/MM/yyyy").format(date);
      } catch (e) {
        logError(msg: e);
      }
    } else {
      trimDate = "No Date";
    }

    return trimDate.replaceAll('PM', 'pm').replaceAll('AM', 'am');
  }

  static String m12TimeFormat3(String dateStr) {
    //Only time 24
    if (dateStr != "null") {
      List<String> parts = dateStr.split("T");
      String part2 = parts[1];
      dateStr = part2.substring(0, 5);

      try {
        final DateFormat sdf = DateFormat("H:mm");
        final DateTime dateObj = sdf.parse(dateStr);
        // System.out.println(dateObj);
        // System.out.println(new SimpleDateFormat("hh:mm a").format(dateObj));

        dateStr = DateFormat("hh:mm a").format(dateObj);
      } catch (e) {
        logError(msg: e);
      }
    } else {
      dateStr = "No Time";
    }

    return dateStr.replaceAll('PM', 'pm').replaceAll('AM', 'am');
  }

  static String ddMonYearAmPmTimeFormat2(String fullDate) {
// 1-11-2016 11:16 AM
    String date1, fulldate;
    if ((null != fullDate) && !(fullDate == "null")) {
      date1 = dateTrim2(fullDate);
      String trimTime = timeAmPm2(fullDate);
      fulldate = (date1 + " " + trimTime);
    } else {
      fulldate = "No Date";
    }
    return fulldate;
  }

  static String timeAmPm2(String fullDate) {
    String trimTime = fullDate.substring(fullDate.indexOf("T") + 1);
    DateFormat sdf = DateFormat("hh:mm:ssss");

    DateTime dt;
    try {
      dt = sdf.parse(trimTime);
      DateFormat sdfs = DateFormat("hh:mm a");
      trimTime = sdfs.format(dt);
    } catch (e) {
      logError(msg: e);
    }
    return (trimTime);
  }

  static String dateTrim2(String dateString) {
    String trimDate = "No data";
    if (!(dateString == "null")) {
      try {
        if (dateString.contains("T")) {
          trimDate = dateString.substring(0, dateString.indexOf("T"));
        } else {
          trimDate = dateString;
        }
        // trimDate = dateString.substring(0, dateString.indexOf("T"));

        DateFormat format = DateFormat("yyyy-MM-dd");
        DateTime date = format.parse(trimDate);
        trimDate = DateFormat("dd/MM/yyyy").format(date);
      } catch (e) {
        logError(msg: e);
      }
    } else {
      trimDate = "No Date";
    }
    return trimDate;
  }

  static DateTime? dateTrimNReturnDateTime(String dateString) {
    String trimDate = "No data";
    DateTime? trimDateTime;
    if (!(dateString == "null")) {
      try {
        if (dateString.contains("T")) {
          trimDate = dateString.substring(0, dateString.indexOf("T"));
        } else {
          trimDate = dateString;
        }
        // trimDate = dateString.substring(0, dateString.indexOf("T"));

        DateFormat format = DateFormat("yyyy-MM-dd");
        trimDateTime = format.parse(trimDate);
        // trimDate = DateFormat("dd/MM/yyyy").format(date);
      } catch (e) {
        logError(msg: e);
      }
    } else {
      trimDate = "No Date";
    }
    return trimDateTime;
  }

  static bool isDateGreater(String date_time) {
    DateFormat sdf = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSz");
    // DateFormat output = DateFormat("dd MMM");
    DateTime? d;

    DateTime? current_date;

    try {
      d = sdf.parse(date_time);
      current_date = DateTime.now();

      if (d.isAfter(current_date)) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      logError(msg: e);
    }

    return false;
  }

  static String timeAmPm(String fullDate) {
    String trimTime =
        fullDate.substring(fullDate.indexOf("T") + 1, fullDate.length);
    // StringTokenizer tk = new StringTokenizer(trimTime);
    // String time = tk.nextToken();
    DateFormat sdf = DateFormat("hh:mm:ss");
    DateFormat sdfs = DateFormat("hh:mm a");
    DateTime dt;
    try {
      dt = sdf.parse(trimTime);
      trimTime = sdfs.format(dt);
    } catch (e) {
      logError(msg: e);
    }
    return (trimTime);
  }

  static String ddMonYYYYFormatWithoutTime(String dateString) {
    String trimDate = "No data";

    if (!(dateString == "null")) {
      try {
        if (dateString.contains("T")) {
          trimDate = dateString.substring(0, dateString.indexOf("T"));
        } else {
          trimDate = dateString;
        }

        // trimDate = dateString.substring(0, dateString.indexOf("T"));

        DateFormat format = DateFormat("yyyy-MM-dd");
        DateTime date = format.parse(trimDate);
        trimDate = DateFormat("dd/MM/yyyy").format(date);
      } catch (e) {
        logError(msg: e);
      }
    } else {
      trimDate = "No Date";
    }
    return trimDate;
  }

  static String ddMMYYYYFormat(String dateStr) {
    //24hr time
    if (!(dateStr == "null")) {
      List<String> parts = dateStr.split("T");
      String part1 = parts[0];
      String part2 = parts[1];
      DateFormat format = DateFormat("yyyy-MM-dd");

      DateTime? date;

      try {
        date = format.parse(part1);
        part2 = part2.substring(0, 5);
      } catch (e) {
        logError(msg: e);
      }

      dateStr = DateFormat("dd/MM/yyyy").format(date!) + "";
    } else {
      dateStr = "No Date";
    }

    return dateStr;
  }

  static String m12TimeFormat(String dateStr) {
    //Only time 24
    if (dateStr != "null") {
      List<String> parts = dateStr.split("T");
      String part2 = parts[1];
      dateStr = part2.substring(0, 5);

      try {
        final DateFormat sdf = DateFormat("H:mm");
        final DateTime dateObj = sdf.parse(dateStr);
        // System.out.println(dateObj);
        // System.out.println(new SimpleDateFormat("hh:mm a").format(dateObj));

        dateStr = DateFormat("hh:mm a").format(dateObj);
      } catch (e) {
        logError(msg: e);
      }
    } else
      dateStr = "No Time";

    return dateStr;
  }

  static String getPunchedInDate(String dateStr) {
    //Only date
    if (dateStr.isNotEmpty && (dateStr != "null")) {
//            DateFormat format = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSXXX", Locale.ENGLISH);
      DateFormat format = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ");
      DateTime? date;
      try {
        date = format.parse(dateStr);
      } catch (e) {
        logError(msg: e);
      }
      //dateStr = new SimpleDateFormat("dd-MM-yyyy").format(date);
      dateStr = DateFormat("yyyy-MM-dd").format(date!);
    } else {
      dateStr = "No Date";
    }
    return dateStr;
  }

  static String timeTxtWithDateFormat(String sTime) {
    if (sTime.isNotEmpty) {
      DateFormat sdf = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ");
      DateFormat sdfNew = DateFormat("dd/MM/yyyy HH:mm a");
      try {
        DateTime dTempTime = sdf.parse(sTime);
        String sTempTime = sdfNew.format(dTempTime);
        return sTempTime;
      } catch (e) {
        logError(msg: e);
      }
    } else {
      return "Not Available";
    }

    return '';
  }

  static String timeTxtFormat(String fullDate) {
    String trimTime =
        fullDate.substring(fullDate.indexOf("T") + 1, fullDate.length);

    DateFormat sdf = DateFormat("HH:mm:ss");
    DateFormat sdfs = DateFormat("hh:mm a");
    DateTime dt;
    try {
      dt = sdf.parse(trimTime);
      trimTime = sdfs.format(dt);
    } catch (e) {
      logError(msg: e);
    }
    return (trimTime);
  }

  static Future<String> downloadIOSFile(String url, String? docType) async {
    logInfo(msg: 'doctype: $docType');
    Future<bool> _requestWritePermission() async {
      await Permission.storage.request();
      return await Permission.storage.request().isGranted;
    }

    bool hasPermission = await _requestWritePermission();
    if (!hasPermission) return 'Permission not granted!';

    var dir = await getApplicationDocumentsDirectory();
    Dio dio = Dio();
    final dateTime = DateTime.now()
        .toString()
        .replaceAll('-', '')
        .replaceAll(':', '')
        .replaceAll(' ', '')
        .replaceAll('.', '');
    logInfo(msg: dateTime);
    String fileName = dateTime;
    fileName += url.split('/').last;
    // String fileName = Random().nextInt(999).toString();
    // String
    // if (docType == 'image/jpeg') {
    //    fileName += '.jpeg';
    // }

    await dio.download(url, "${dir.path}/$fileName");
    // .then((value) {
    //    OpenFile.open("${dir.path}/$fileName", type: docType);
    // });

    // final mimeType = lookupMimeType("${dir.path}/$fileName");

    // logInfo(msg: mimeType);

    return "${dir.path}/$fileName";
  }

  static Future<String> downloadFile(String url, BuildContext context) async {
    final dateTime = DateTime.now()
        .toString()
        .replaceAll('-', '')
        .replaceAll(':', '')
        .replaceAll(' ', '')
        .replaceAll('.', '');
    logInfo(msg: dateTime);
    String fileName = dateTime;
    fileName += url.split('/').last;
    // final format = url.split('/').last.split('.');
    // String dir = Directory('/storage/emulated/0/Download').path;
    String? externalStorageDirPath;
    if (Platform.isAndroid) {
      try {
        final directory = await getDownloadsDirectory();
        externalStorageDirPath = directory?.path;
      } catch (e) {
        logError(msg: e);
        final directory = await getExternalStorageDirectory();
        externalStorageDirPath = directory?.path;
      }
    } else if (Platform.isIOS) {
      externalStorageDirPath =
          (await getApplicationDocumentsDirectory()).absolute.path;
    }
    // final temp = await getExternalStorageDirectory();
    String dir = externalStorageDirPath ??
        Directory('/storage/emulated/0/Downloads').path;
    // HttpClient httpClient = HttpClient();
    // File file;
    String filePath = '';
    showToastDialog(msg: 'Downloading File....');
    logInfo(msg: externalStorageDirPath);

    // var status = await Permission.manageExternalStorage.status;
    // if (status.isDenied) {
    //    if (await Permission.manageExternalStorage.request().isGranted) {
    try {
      if (Platform.isIOS) {
        final CustomProgressDialog pd =
            loadingPleaseWaitDialog(context: context);
        pd.show();
        await Utils.downloadIOSFile(url, null).then((value) {
          if (pd.isShowed) {
            pd.dismiss();
          }
          if (value != null && value.isNotEmpty) {
            final mimeType = lookupMimeType(value);
            final contentformat = mimeType?.split('/').last;
            logInfo(msg: 'cF $contentformat');
            logInfo(msg: mimeType);
            showModalBottomSheet(
              context: context,
              isDismissible: false,
              builder: (context) {
                return Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '${toBeginningOfSentenceCase(fileName)} Downloaded Successfully!',
                          // '$toBeginningOfSentenceCase(
                          //    '${widget.routeModel.documents[_current].contentType}'
                          // ) dowmloaded successfully',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                        onPressed: () {
                          OpenFileSafePlus.open(value, type: contentformat);
                        },
                        child: const Text('Open'),
                      ),
                    ),
                  ],
                );
              },
            );
            Future.delayed(const Duration(seconds: 5)).then(
              (value) => Navigator.pop(context),
            );
          } else {
            showToastDialog(msg: 'Something went wrong!');
          }
        });
      } else {
        final taskId = await FlutterDownloader.enqueue(
          url: url,
          savedDir: dir,
          saveInPublicStorage: true,
          fileName: fileName,
          showNotification:
              true, // show download progress in status bar (for Android)
          openFileFromNotification:
              true, // click on notification to open downloaded file (for Android)
        );
      }

      // var request = await httpClient.getUrl(Uri.parse(url));
      // var response = await request.close();
      // if (response.statusCode == 200) {
      //    var bytes = await consolidateHttpClientResponseBytes(response);
      //    filePath = '$dir/$fileName';
      //    file = File(filePath);
      //    await file.writeAsBytes(bytes);

      //    showToastDialog(msg: 'File Downloaded');
      // } else {
      //    filePath = 'Error code: ' + response.statusCode.toString();
      // }
    } catch (ex) {
      logError(msg: ex);
      showToastDialog(msg: 'Unable to download File!');
      filePath = 'Can not fetch url';
    }
    //    } else {
    //      showToastDialog(msg: 'You Deined Permission');
    //    }
    // } else {
    //    try {
    //      var request = await httpClient.getUrl(Uri.parse(url));
    //      var response = await request.close();
    //      if (response.statusCode == 200) {
    //        var bytes = await consolidateHttpClientResponseBytes(response);
    //        filePath = '$dir/$fileName';
    //        file = File(filePath);
    //        await file.writeAsBytes(bytes);
    //      } else {
    //        filePath = 'Error code: ' + response.statusCode.toString();
    //      }
    //    } catch (ex) {
    //      logError(msg: ex);
    //      showToastDialog(msg: 'Unable to download File!');
    //      filePath = 'Can not fetch url';
    //    }
    // }

    return filePath;
  }

  static String convertddHyphenMMHyphenYyyyToDdMMYYYYFormat(String dateStr) {
    //24hr time
    if (dateStr != null && !(dateStr == "null")) {
      DateFormat format = DateFormat("yyyy-MM-dd");

      DateTime date = DateTime.now();

      try {
        date = format.parse(dateStr);
      } catch (e) {
        logError(msg: e);
      }

      dateStr = DateFormat("dd/MM/yyyy").format(date);
    } else {
      dateStr = "No Date";
    }

    return dateStr;
  }

  static String dateTrim(String dateString) {
    String trimDate = "No data";
    if (dateString != null && !(dateString == "")) {
      try {
        if (dateString.contains("T")) {
          trimDate = dateString.substring(0, dateString.indexOf("T"));
        } else {
          trimDate = dateString;
        }

        // trimDate = dateString.substring(0, dateString.indexOf("T"));

        DateFormat format = DateFormat("yyyy-MM-dd");
        DateTime date = format.parse(trimDate);
        trimDate = DateFormat("dd/MM/yyyy").format(date);
      } catch (e) {
        logError(msg: e);
      }
    } else {
      trimDate = "No Date";
    }

    return trimDate.replaceAll('PM', 'pm').replaceAll('AM', 'am');
  }

  static String dateFormat3({
    required DateTime date,
  }) {
    String formatedDate = '';
    try {
      final DateFormat dateFormatter = DateFormat('dd MMMM yyyy');

      return formatedDate = dateFormatter.format(date);
    } catch (e) {
      logError(msg: e);
      return '';
    }
  }

  static String convertddMMyyyyToddMMMyyyy(String date) {
    String tempDate = '';
    try {
      tempDate = DateFormat('dd MMM yyyy').format(DateTime.parse(date));
    } catch (e) {
      logError(msg: e);
    }
    return tempDate;
  }

  /*
  // Commented out to decouple unrelated modules from book_parking package
  static void onNotiClicked(
      Map<String, dynamic> data, NotiAppState state) async {
    // if (data == null) {
    //      Prefs.setIsFromNoti(false);
    //      return;
    //    }
    String? title,
        message,
        image,
        timestamp,
        deptName,
        user_id,
        ntype,
        notice_id,
        event_id,
        gatekeeper_id,
        cab_type,
        cab_model,
        driver_number,
        car_number,
        sender_id;

    String VIDEO_CALL_TAG = "VIDEO CALL";
    String? peer_name;
    String? conv_id;
    String? recipient_id;
    String? comp_id;
    String? apmt_id;
    String? facility_id;
    String? invoice_id;
    String? fitout_request_id;
    String? seat_booking_id;

    bool force_close = false;
    int depId = 0;

    logInfo(msg: data);

    if (data.containsKey("title")) {
      title = data["title"].toString();
    }
    if (data.containsKey("message")) {
      message = data["message"].toString();
    }
    if (data.containsKey("image")) {
      image = data["image"].toString();
    }
    if (data.containsKey("created_at")) {
      timestamp = data["created_at"].toString();
    }
    if (data.containsKey("user_id")) {
      user_id = data["user_id"].toString();
    }
    if (data.containsKey("notice_id")) {
      notice_id = data["notice_id"].toString();
    }
    if (data.containsKey("event_id")) {
      event_id = data["event_id"].toString();
    }

    //-------------GateKepper-------------------
    if (data.containsKey("gatekeeper_id")) {
      gatekeeper_id = data["gatekeeper_id"].toString();
    }

    //--------------Ola----------------------
    if (data.containsKey("cab_type")) {
      cab_type = data["cab_type"].toString();
    }
    if (data.containsKey("cab_model")) {
      cab_model = data["cab_model"].toString();
    }
    if (data.containsKey("driver_number")) {
      driver_number = data["driver_number"].toString();
    }
    if (data.containsKey("car_number")) {
      car_number = data["car_number"].toString();
    }

    if (data.containsKey("ntype")) {
      ntype = data["ntype"].toString();
      logInfo(msg: 'ntype:$ntype');
    }

    if (data.containsKey(sender_id)) {
      sender_id = data["sender_id"].toString();
    }

    if (data.containsKey("ntype")) {
      ntype = data["ntype"].toString();
      logInfo(msg: 'ntype:$ntype');
    }
    if (data.containsKey("peer_name")) {
      peer_name = data["peer_name"].toString();
    }

    if (data.containsKey("conv_id")) {
      conv_id = data["conv_id"].toString();
    }

    if (data.containsKey("sender_id")) {
      sender_id = data["sender_id"].toString();
    }

    if (data.containsKey("recipient_id")) {
      recipient_id = data["recipient_id"].toString();
    }

    if (data.containsKey("force_close")) {
      force_close = data["force_close"] as bool;
    }

    //Fitout
    if (data.containsKey("fitout_request_id")) {
      fitout_request_id = data["fitout_request_id"].toString();
    }

    //Space Management

    if (data.containsKey("seat_booking_id")) {
      seat_booking_id = data["seat_booking_id"].toString();
    }

    // - Chat -

    String? conversationId;
    String? projectSpaceId;

    if (data.containsKey('conversation_id')) {
      conversationId = data['conversation_id'].toString();
    }
    if (data.containsKey('project_space_id')) {
      projectSpaceId = data['project_space_id'].toString();
    }

    // - End -

    //TODO: uncomment this and implement Logout in Prefs
    // if (Prefs.getLockatedToken() != null && !Prefs.getLogout()) {

    if (Prefs.getLockatedToken() != null) {
      if (Prefs.getUserId().toString() == (user_id)) {
        if (state == NotiAppState.terminatedState) {
          logInfo(msg: 'check_here: isFromNoti True');
          Prefs.setIsFromNoti(true);
        }
        if (data.containsKey("dep_id")) {
          if (data["dep_id"] != null) {
            depId = int.parse(data["dep_id"].toString());
          }
        }
        if (data.containsKey("dep_name")) {
          if (data["dep_name"] != null) {
            deptName = data["dep_name"].toString();
          } else {
            deptName = "Chat";
          }
        }

        if (ntype != null && ntype.toLowerCase() == ("allnotices")) {
          if (notice_id != null) {
            // SchedulerBinding.instance.addPostFrameCallback((_) {
            GlobalVariable.navState.currentState!.push(MaterialPageRoute(
                builder: (context) => NoticeDetailsScreen(
                      routeModel: NoticeDetailsRouteModel(
                        id: notice_id!,
                        isFromNoti: state == NotiAppState.terminatedState,
                      ),
                    )));
            // });
          }
        } else if (ntype != null && ntype.toLowerCase() == ("approvednotice")) {
          if (notice_id != null) {
            // SchedulerBinding.instance.addPostFrameCallback((_) {
            GlobalVariable.navState.currentState!.push(MaterialPageRoute(
                builder: (context) => NoticeDetailsScreen(
                      routeModel: NoticeDetailsRouteModel(
                        id: notice_id!,
                        isFromNoti: state == NotiAppState.terminatedState,
                      ),
                    )));
            // });
          }
        } else if (ntype != null &&
            ntype.toLowerCase() == ("newcommentbyuser")) {
          if (data.containsKey("complaint_id")) {
            final complaintId = data["complaint_id"].toString();
            // SchedulerBinding.instance.addPostFrameCallback((_) {
            GlobalVariable.navState.currentState!.push(MaterialPageRoute(
                builder: (context) => HelpdeskDetailScreen(
                      routeModel: HelpdeskDetailRouteModel(
                        complaintId: complaintId,
                        isFromAllTickets: true,
                        isFromNoti: state == NotiAppState.terminatedState,
                      ),
                    )));
            // });
          }
        } else if (ntype != null &&
            ntype.toLowerCase() == ("pms_newcomplaintadmin")) {
          if (data.containsKey("complaint_id")) {
            final complaintId = data["complaint_id"].toString();
            // SchedulerBinding.instance.addPostFrameCallback((_) {
            GlobalVariable.navState.currentState!.push(MaterialPageRoute(
                builder: (context) => HelpdeskDetailScreen(
                      routeModel: HelpdeskDetailRouteModel(
                        complaintId: complaintId,
                        isFromAllTickets: true,
                        isFromNoti: state == NotiAppState.terminatedState,
                      ),
                    )));
            // });
          }
        } else if (ntype != null &&
            ntype.toLowerCase() == ("pms_newcomplaint")) {
          if (data.containsKey("complaint_id")) {
            final complaintId = data["complaint_id"].toString();
            // SchedulerBinding.instance.addPostFrameCallback((_) {
            GlobalVariable.navState.currentState!.push(MaterialPageRoute(
                builder: (context) => HelpdeskDetailScreen(
                      routeModel: HelpdeskDetailRouteModel(
                        complaintId: complaintId,
                        isFromAllTickets: false,
                        isFromNoti: state == NotiAppState.terminatedState,
                      ),
                    )));
            // });
          }
        }

        //  new visitor

        else if (ntype != null &&
            ntype.toLowerCase() == ("newvisitorgatekeeper")) {
          if (GlobalVariable.navState.currentState != null) {
            // Navigator.of(context).pushNamed(Routes.visitorDetailsScreen,
            //      arguments: VisitorDetailsRouteModel(
            //          fromNotification: true, gatekeeperId: gatekeeper_id));
            // SchedulerBinding.instance.addPostFrameCallback((_) {
            GlobalVariable.navState.currentState!.push(MaterialPageRoute(
                builder: (context) => VisitorDetailsScreen(
                      routeModel: VisitorDetailsRouteModel(
                          fromNotification:
                              state == NotiAppState.terminatedState,
                          gatekeeperId: gatekeeper_id),
                    )));
            // });
          }
        }

        //Fitout
        else if (ntype != null &&
            ntype.toLowerCase() == ("new_fitout_request")) {
          int id = int.parse(fitout_request_id ?? '0');
          if (GlobalVariable.navState.currentState != null) {
            // SchedulerBinding.instance.addPostFrameCallback((_) {
            GlobalVariable.navState.currentState!.push(MaterialPageRoute(
                builder: (context) => FitoutDetailScreen(
                        routeModel: FitoutDetailRouteModel(
                      id: id,
                      isFromNoti: state == NotiAppState.terminatedState,
                    ))));
            // });
          }
        }

        // task detail
        else if (ntype != null &&
            ntype.toLowerCase() == ("pms_newcomplainttask")) {
          if (data.containsKey("complaint_id")) {
            comp_id = data["complaint_id"].toString();

            // SchedulerBinding.instance.addPostFrameCallback((_) {
            GlobalVariable.navState.currentState!.push(
              MaterialPageRoute(
                builder: (context) => DailyTaskDetailsScreen(
                  routeModel: DailyTaskDetailsRouteModel(
                    taskId: comp_id.toString(),
                    isFromNoti: state == NotiAppState.terminatedState,
                  ),
                ),
              ),
            );
            // });
          }
        } else if (ntype != null &&
            ntype.toLowerCase() == ("statuschangecomplaint")) {
          if (data.containsKey("complaint_id")) {
            final complaintId = data["complaint_id"].toString();
            // SchedulerBinding.instance.addPostFrameCallback((_) {
            GlobalVariable.navState.currentState!.push(MaterialPageRoute(
                builder: (context) => HelpdeskDetailScreen(
                      routeModel: HelpdeskDetailRouteModel(
                        complaintId: complaintId,
                        isFromAllTickets: false,
                        isFromNoti: state == NotiAppState.terminatedState,
                      ),
                    )));
            // });
          }
        } else if (ntype != null &&
            ntype.toLowerCase() == ("statuschangecomplaintadmin")) {
          if (data.containsKey("complaint_id")) {
            final complaintId = data["complaint_id"].toString();
            // SchedulerBinding.instance.addPostFrameCallback((_) {
            GlobalVariable.navState.currentState!.push(MaterialPageRoute(
                builder: (context) => HelpdeskDetailScreen(
                      routeModel: HelpdeskDetailRouteModel(
                        complaintId: complaintId,
                        isFromAllTickets: true,
                        isFromNoti: state == NotiAppState.terminatedState,
                      ),
                    )));
            // });
          }
        } else if (ntype != null &&
            ntype.toLowerCase() == ("complaintassigned")) {
          if (data.containsKey("complaint_id")) {
            final complaintId = data["complaint_id"].toString();
            // SchedulerBinding.instance.addPostFrameCallback((_) {
            GlobalVariable.navState.currentState!.push(MaterialPageRoute(
                builder: (context) => HelpdeskDetailScreen(
                      routeModel: HelpdeskDetailRouteModel(
                        complaintId: complaintId,
                        isFromAllTickets: true,
                        isFromNoti: state == NotiAppState.terminatedState,
                      ),
                    )));
            // });
          }
        } else if (ntype != null &&
            ntype.toLowerCase() == ("newcommentbyadmin")) {
          if (data.containsKey("complaint_id")) {
            final complaintId = data["complaint_id"].toString();
            // SchedulerBinding.instance.addPostFrameCallback((_) {
            GlobalVariable.navState.currentState!.push(MaterialPageRoute(
                builder: (context) => HelpdeskDetailScreen(
                      routeModel: HelpdeskDetailRouteModel(
                        complaintId: complaintId,
                        isFromAllTickets: false,
                        isFromNoti: state == NotiAppState.terminatedState,
                      ),
                    )));
            // });
          }
        } else if (ntype != null && ntype.toLowerCase() == ("pms_task")) {
          if (data.containsKey("complaint_id")) {
            comp_id = data["complaint_id"].toString();

            // SchedulerBinding.instance.addPostFrameCallback((_) {
            GlobalVariable.navState.currentState!.push(
              MaterialPageRoute(
                builder: (context) => DailyTaskDetailsScreen(
                  routeModel: DailyTaskDetailsRouteModel(
                    taskId: comp_id.toString(),
                    isFromNoti: state == NotiAppState.terminatedState,
                  ),
                ),
              ),
            );
            // });
          }
        } else if (ntype != null &&
            ntype.toLowerCase() == ("space_management")) {
          if (GlobalVariable.navState.currentState != null) {
            // SchedulerBinding.instance.addPostFrameCallback((_) {
            GlobalVariable.navState.currentState!.push(MaterialPageRoute(
                builder: (context) => SpaceManagementScreen(
                      isFromNoti: state == NotiAppState.terminatedState,
                    )));
            // });
          }
        } else if (ntype != null &&
            ntype.toLowerCase() == ("space_management_reminder")) {
          if (GlobalVariable.navState.currentState != null) {
            // SchedulerBinding.instance.addPostFrameCallback((_) {
            GlobalVariable.navState.currentState!.push(MaterialPageRoute(
                builder: (context) => BookingDetailScreen(
                        routeModel: BookingDetailsScreenRouteModel(
                      seatBookingId: seat_booking_id ?? '',
                      isFromNoti: state == NotiAppState.terminatedState,
                    ))));
            // });
          }
        } else if (ntype != null &&
            ntype.toLowerCase() == ("space_management_request")) {
          String? date;
          String? seatConfigurationId;
          String? buildingId;
          String? buildingName;
          String? floorId;
          String? floorName;
          if (data.containsKey("date")) {
            date = data["date"].toString();
          }
          if (data.containsKey("seat_configuration_id")) {
            seatConfigurationId = data["seat_configuration_id"].toString();
          }
          if (data.containsKey("building_id")) {
            buildingId = data["building_id"].toString();
          }
          if (data.containsKey("building_name")) {
            buildingName = data["building_name"].toString();
          }
          if (data.containsKey("floor_id")) {
            floorId = data["floor_id"].toString();
          }
          if (data.containsKey("floor_name")) {
            floorName = data["floor_name"].toString();
          }
          if (seatConfigurationId != null &&
              floorId != null &&
              buildingId != null &&
              floorName != null &&
              buildingName != null) {
            ISpaceManagementRepository spaceManagementRepository =
                SpaceManagementRepository();
            final res =
                await spaceManagementRepository.getSeatConfigurationResponse(
              buildingId: buildingId,
              floorId: floorId,
            );

            if (res != null &&
                res.seatConfigurations != null &&
                res.seatConfigurations!.isNotEmpty) {
              for (var item in res.seatConfigurations!) {
                if (item.id != null &&
                    item.id == int.parse(seatConfigurationId)) {
                  logError(msg: 'here_check: here_0 true');
                  //Open Book Seat Screen
                  // Navigator.of(context).pushNamed(Routes.bookSpaceDateAndSlot,
                  //      arguments: BookSpaceDateAndSlotRouteModel(
                  //        seatConfiguration: item,
                  //        selectDay: selectedDay,
                  //        building: building,
                  //        floor: floor,
                  //        isForRescheduling: false,
                  //      ));

                  if (GlobalVariable.navState.currentState != null) {
                    if (state == NotiAppState.terminatedState) {
                      // SchedulerBinding.instance.addPostFrameCallback((_) {
                      GlobalVariable.navState.currentState!
                          .push(MaterialPageRoute(
                              builder: (context) => BookSpaceDateAndSlotScreen(
                                    isFromNoti:
                                        state == NotiAppState.terminatedState,
                                    routeModel: BookSpaceDateAndSlotRouteModel(
                                      seatConfiguration: item,
                                      selectDay: date != null && date.isNotEmpty
                                          ? DateFormat('dd/MM/yyyy').parse(date)
                                          : DateTime.now(),
                                      building: BuildingModel(
                                        id: int.parse(buildingId ?? ''),
                                        name: buildingName,
                                      ),
                                      floor: FloorModel(
                                          id: int.parse(floorId ?? ''),
                                          name: floorName),
                                      isForRescheduling: false,
                                    ),
                                  )));
                      // });
                    } else {
                      // SchedulerBinding.instance.addPostFrameCallback((_) {
                      GlobalVariable.navState.currentState!
                          .push(MaterialPageRoute(
                              builder: (context) => BookSpaceDateAndSlotScreen(
                                    isFromNoti:
                                        state == NotiAppState.terminatedState,
                                    routeModel: BookSpaceDateAndSlotRouteModel(
                                      seatConfiguration: item,
                                      selectDay: date != null && date.isNotEmpty
                                          ? DateFormat('dd/MM/yyyy').parse(date)
                                          : DateTime.now(),
                                      building: BuildingModel(
                                        id: int.parse(buildingId ?? ''),
                                        name: buildingName,
                                      ),
                                      floor: FloorModel(
                                          id: int.parse(floorId ?? ''),
                                          name: floorName),
                                      isForRescheduling: false,
                                    ),
                                  )));
                      // });
                    }
                  }
                } else {
                  logError(msg: 'here_check: here_2');
                }
              }
            } else {
              if (GlobalVariable.navState.currentState != null) {
                // SchedulerBinding.instance.addPostFrameCallback((_) {
                GlobalVariable.navState.currentState!.push(MaterialPageRoute(
                    builder: (context) => SpaceManagementScreen(
                          isFromNoti: state == NotiAppState.terminatedState,
                          selectedDate: date,
                        )));
                // });
              }
            }
          } else {
            if (GlobalVariable.navState.currentState != null) {
              // SchedulerBinding.instance.addPostFrameCallback((_) {
              GlobalVariable.navState.currentState!.push(MaterialPageRoute(
                  builder: (context) => SpaceManagementScreen(
                        isFromNoti: state == NotiAppState.terminatedState,
                        selectedDate: date,
                      )));
              // });
            }
          }
        }
        //Facility booking
        else if (ntype != null && ntype == 'user_new_facility_booking') {
          if (data.containsKey("facility_booking_id")) {
            String facilityBookingId = data["facility_booking_id"].toString();
            if (GlobalVariable.navState.currentState != null) {
              // SchedulerBinding.instance.addPostFrameCallback((_) {
              GlobalVariable.navState.currentState!.push(MaterialPageRoute(
                  // builder: (context) => BookedFacilityDetailsScreen(
                  // Changed for VI
                  builder: (context) =>
                      FacilityBookingsBookedFacilityDetailsScreen(
                        routeModel: BookedFacilityDetailsRouteModel(
                          facilityBookingId: facilityBookingId,
                          isFromNoti: state == NotiAppState.terminatedState,
                        ),
                      )));
              // });
            }
          }
        }
        //Mailroom
        else if (ntype != null && ntype == 'new_inbound') {
          if (data.containsKey("mail_inbound_id")) {
            String mailInboundId = data['mail_inbound_id'].toString();
            if (GlobalVariable.navState.currentState != null) {
              // SchedulerBinding.instance.addPostFrameCallback((_) {
              GlobalVariable.navState.currentState!.push(MaterialPageRoute(
                  builder: (context) => MailroomInboundDetailsScreen(
                        item: InboundMailModel(
                          id: int.tryParse(mailInboundId),
                        ),
                        isFromNoti: state == NotiAppState.terminatedState,
                      )));
              // });
            }
          }
        }
        // Fitness
        else if (ntype != null && ntype == 'daily_goal') {
          if (GlobalVariable.navState.currentState != null) {
            // SchedulerBinding.instance.addPostFrameCallback((_) {
            // GlobalVariable.navState.currentState!.push(MaterialPageRoute(
            //      builder: (context) => HomeTabFitnessScoreboardDetailsScreen(
            //            isFromNoti: state == NotiAppState.terminatedState,
            //          )));
            // });
          }
        }
        // Events
        else if (ntype != null &&
            (ntype.toLowerCase() == 'neweventadmin' ||
                ntype.toLowerCase() == 'approvedevent')) {
          if (data.containsKey("event_id")) {
            String eventId = data['event_id'].toString();
            int eventDetailsID = int.tryParse(eventId) ?? 0;
            logInfo(msg: 'Event ID : $eventDetailsID');
            if (GlobalVariable.navState.currentState != null &&
                eventDetailsID > 0) {
              GlobalVariable.navState.currentState!.push(MaterialPageRoute(
                builder: (context) => EventDetailsScreen(
                    routeModel: EventDetailsRouteModel(
                        id: eventDetailsID,
                        comingFrom: EventDetailsComingFrom.upcoming)),
              ));
            }
          }
        } else if (ntype != null && ntype.toLowerCase() == 'local_travel') {
          if (GlobalVariable.navState.currentState != null) {
            GlobalVariable.navState.currentState!.push(MaterialPageRoute(
              builder: (context) => const HomeScreenGoPhygital(
                isComingFromViMilesNoti: true,
              ),
            ));
          }
        }
        // - Chat -
        else if (ntype != null && ntype.toLowerCase() == 'newmessage') {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          String token = preferences.getString(Prefs.lockatedToken) ?? '';
          String? conversationName;
          if (data.containsKey('conversation_name')) {
            conversationName = data['conversation_name'].toString();
          }
          if (GlobalVariable.navState.currentState != null) {
            GlobalVariable.navState.currentState!.push(MaterialPageRoute(
              builder: (context) => ChatsViewScreen(
                comingFrom: ChatViewComingFrom.directMessage,
                conversationId: conversationId ?? '',
                isFromNoti: state == NotiAppState.terminatedState,
                token: token,
                conversationName: conversationName,
              ),
            ));
          }
        } else if (ntype != null && ntype.toLowerCase() == 'newmessage_space') {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          String token = preferences.getString(Prefs.lockatedToken) ?? '';
          String? conversationName;
          if (data.containsKey('conversation_name')) {
            conversationName = data['conversation_name'].toString();
          }
          if (GlobalVariable.navState.currentState != null) {
            GlobalVariable.navState.currentState!.push(MaterialPageRoute(
              builder: (context) => ChatsViewScreen(
                comingFrom: ChatViewComingFrom.space,
                conversationId: projectSpaceId ?? '',
                isFromNoti: state == NotiAppState.terminatedState,
                token: token,
                conversationName: conversationName,
              ),
            ));
          }
        }

        //LMR
        else if (ntype != null &&
            (ntype.toLowerCase() == 'linemanagerchangeuser' ||
                ntype.toLowerCase() == 'linemanagerchangemanager')) {
          SharedPreferences preferences = await SharedPreferences.getInstance();
          int? userId = preferences.getInt(Prefs.userId);

          if (GlobalVariable.navState.currentState != null) {
            GlobalVariable.navState.currentState!.push(MaterialPageRoute(
              builder: (context) => MsafeUserRequestScreen(
                reportingManagerId: userId?.toString() ?? '',
              ),
            ));
          }
        } else {
          //TODO: Implement
          // SchedulerBinding.instance.addPostFrameCallback((_) {
          //    GlobalVariable.navState.currentState!.push(
          //      MaterialPageRoute(
          //        builder: (context) => const HomeScreen(),
          //      ),
          //    );
          // });
        }
      } else {
        showToastDialog(msg: 'User Id Not Matched');
        logError(msg: "User Id Not Matched");
        // SchedulerBinding.instance.addPostFrameCallback((_) {
        //    GlobalVariable.navState.currentState!.push(
        //      MaterialPageRoute(
        //        builder: (context) => const AuthHeader(),
        //      ),
        //    );
        // });
      }
    } else {
      logError(msg: 'Not Logged');
      // SchedulerBinding.instance.addPostFrameCallback((_) {
      //    GlobalVariable.navState.currentState!.push(
      //      MaterialPageRoute(
      //        builder: (context) => const AuthHeader(),
      //      ),
      //    );
      // });
    }
  }
  */

  /*
  // Commented out to avoid dependency on NotificationStaticModel and database which might not be in this package
  static Future<void> addNotiToDb(Map<String, dynamic> data) async {
    String? title,
        message,
        image,
        timestamp,
        deptName,
        user_id,
        ntype,
        notice_id,
        event_id,
        gatekeeper_id,
        cab_type,
        cab_model,
        driver_number,
        car_number,
        sender_id;

    String VIDEO_CALL_TAG = "VIDEO CALL";
    String? peer_name;
    String? conv_id;
    String? recipient_id;
    String? comp_id;
    String? apmt_id;
    String? facility_id;
    String? invoice_id;
    String? fitout_request_id;

    String? osr_appointment_id;
    String? society_staff_id;
    String? host_id;

    bool force_close = false;
    int depId = 0;

    if (data.containsKey("title")) {
      title = data["title"].toString();
    }
    if (data.containsKey("message")) {
      message = data["message"].toString();
    }
    if (data.containsKey("image")) {
      image = data["image"].toString();
    }
    if (data.containsKey("created_at")) {
      timestamp = data["created_at"].toString();
    }
    if (data.containsKey("user_id")) {
      user_id = data["user_id"].toString();
    }
    if (data.containsKey("notice_id")) {
      notice_id = data["notice_id"].toString();
    }
    if (data.containsKey("event_id")) {
      event_id = data["event_id"].toString();
    }

    //-------------GateKepper-------------------
    if (data.containsKey("gatekeeper_id")) {
      gatekeeper_id = data["gatekeeper_id"].toString();
    }

    //--------------Ola----------------------
    if (data.containsKey("cab_type")) {
      cab_type = data["cab_type"].toString();
    }
    if (data.containsKey("cab_model")) {
      cab_model = data["cab_model"].toString();
    }
    if (data.containsKey("driver_number")) {
      driver_number = data["driver_number"].toString();
    }
    if (data.containsKey("car_number")) {
      car_number = data["car_number"].toString();
    }

    if (data.containsKey("ntype")) {
      ntype = data["ntype"].toString();
      logInfo(msg: 'ntype:$ntype');
    }

    if (data.containsKey(sender_id)) {
      sender_id = data["sender_id"].toString();
    }

    if (data.containsKey("ntype")) {
      ntype = data["ntype"].toString();
      logInfo(msg: 'ntype:$ntype');
    }
    if (data.containsKey("peer_name")) {
      peer_name = data["peer_name"].toString();
    }

    if (data.containsKey("conv_id")) {
      conv_id = data["conv_id"].toString();
    }

    if (data.containsKey("sender_id")) {
      sender_id = data["sender_id"].toString();
    }

    if (data.containsKey("recipient_id")) {
      recipient_id = data["recipient_id"].toString();
    }

    if (data.containsKey("force_close")) {
      force_close = data["force_close"] as bool;
    }

    //Fitout
    if (data.containsKey("fitout_request_id")) {
      fitout_request_id = data["fitout_request_id"].toString();
    }

    if (data.containsKey('facility_booking_id')) {
      facility_id = data["facility_booking_id"].toString();
    }

    if (data.containsKey('osr_appointment_id')) {
      osr_appointment_id = data['osr_appointment_id'].toString();
    }
    if (data.containsKey('society_staff_id')) {
      society_staff_id = data['society_staff_id'].toString();
    }
    if (data.containsKey('host_id')) {
      host_id = data['host_id'].toString();
    }

    SharedPreferences preferences = await SharedPreferences.getInstance();

    int? userIdTemp = preferences.getInt('userId');

    if (userIdTemp.toString() == (user_id)) {
      final database = await $FloorNotificationOfflineDatabase
          .databaseBuilder(notificationOfflineDatabaseName)
          .build();
      final dao = database.notifiactionOfflineDao;

      await dao.insertNoticaition(NotificationStaticModel(
        title: title ?? '',
        message: message ?? '',
        ntype: ntype ?? '',
        timestamp: timestamp ?? '',
        userId: user_id ?? '',
        data: jsonEncode(data),
      ));
    }
  }
  */

  static List<DateTime> getDaysInBetweenIncludingStartEndDate({
    required DateTime startDateTime,
    required DateTime endDateTime,
  }) {
    // Converting dates provided to UTC
    // So that all things like DST don't affect subtraction and addition on dates
    DateTime startDateInUTC = DateTime.utc(
        startDateTime.year, startDateTime.month, startDateTime.day);
    DateTime endDateInUTC =
        DateTime.utc(endDateTime.year, endDateTime.month, endDateTime.day);

    // Created a list to hold all dates
    List<DateTime> daysInFormat = [];

    // Starting a loop with the initial value as the Start Date
    // With an increment of 1 day on each loop
    // With condition current value of loop is smaller than or same as end date
    for (DateTime i = startDateInUTC;
        i.isBefore(endDateInUTC) || i.isAtSameMomentAs(endDateInUTC);
        i = i.add(const Duration(days: 1))) {
      // Converting back UTC date to Local date if it was local before
      // Or keeping in UTC format if it was UTC

      if (startDateTime.isUtc) {
        daysInFormat.add(i);
      } else {
        daysInFormat.add(DateTime(i.year, i.month, i.day));
      }
    }
    return daysInFormat;
  }

  // Commented out as they rely on external packages/logic not strictly part of book_parking
  /*
  static Future<bool> isGoogleFitInstalled() async {
    String package = "com.google.android.apps.fitness";
    if (Platform.isAndroid) {
      package = "com.google.android.apps.fitness";
      // package = "com.google.android.apps.healthdata";
    } else {
      package = 'com.apple.Health';
      return true;
    }
    try {
      final response = await AppCheck.checkAvailability(package);
      if (response?.appName != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      logError(msg: e);
      return false;
    }

    // return false;
  }

  static Future<bool> isHealthConnectInstalled() async {
    String package = "com.google.android.apps.healthdata";
    if (Platform.isAndroid) {
      package = "com.google.android.apps.healthdata";
      // package = "com.google.android.apps.healthdata";
    } else {
      package = 'com.apple.Health';
      return true;
    }
    try {
      final response = await AppCheck.checkAvailability(package);
      if (response?.appName != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      logError(msg: e);
      return false;
    }

    // return false;
  }
  */

  static void onGridOnTap({
    required String title,
    required BuildContext context,
  }) async {
    // Keeping only Book Parking navigation active
    if (title == 'Book Parking') {
      await logEvents(name: AnalyticsEventNames.bookParkingPageClicked);
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (_) => ParkingBookingCreateProvider(),
              ),
              ChangeNotifierProvider(
                create: (_) => ThemeViewModel(),
              ),
            ],
            child: const BookParkingCalendarScreen(),
          );
        },
        // builder: (context) {return ChangeNotifierProvider(
        //     create: (_) => ParkingBookingCreateProvider(),
        //     child: const BookParkingCalendarScreen(),
        //   );
        //   //return const BookParkingCalendarScreen();
          
        // },
      ));
      // Navigator.pushNamed(context, Routes.parkingManagementScreen);
    }
    /*
    if (title == 'Fitout') {
      await logEvents(name: AnalyticsEventNames.fitoutPageClicked);
      Navigator.pushNamed(context, Routes.fitoutScreen);
    } else if (title == 'Tickets') {
      if ((Prefs.getSiteid() ?? 0) == 2459) {
        showToastDialog(
            msg:
                'This Module is not opted. kindly contact your administrator.');
        return;
      }
      await logEvents(name: AnalyticsEventNames.helpDeskPageClicked);
      Navigator.pushNamed(context, Routes.userTicketScreen);
    } else if (title == 'Visitors') {
      if ((Prefs.getSiteid() ?? 0) == 2459) {
        showToastDialog(
            msg:
                'This Module is not opted. kindly contact your administrator.');
        return;
      }
      await logEvents(name: AnalyticsEventNames.visitorsPageClicked);
      Navigator.pushNamed(context, Routes.userVisitorScreen);
    } else if (title == 'Book Facility') {
      if ((Prefs.getSiteid() ?? 0) == 2459) {
        showToastDialog(
            msg:
                'This Module is not opted. kindly contact your administrator.');
        return;
      }
      await logEvents(name: AnalyticsEventNames.bookFacilityPageClicked);
      Navigator.pushNamed(context, Routes.userBookingsScreen, arguments: 0);
    } else if (title == 'Book Seat') {
      if ((Prefs.getSiteid() ?? 0) == 2459) {
        showToastDialog(
            msg:
                'This Module is not opted. kindly contact your administrator.');
        return;
      }
      await logEvents(name: AnalyticsEventNames.bookSeatPageClicked);
      Navigator.pushNamed(context, Routes.spaceManagementScreen);
    } else if (title == 'F&B') {
      if ((Prefs.getSiteid() ?? 0) == 2459) {
        showToastDialog(
            msg:
                'This Module is not opted. kindly contact your administrator.');
        return;
      }
      await logEvents(name: AnalyticsEventNames.foodPageClicked);
      Navigator.pushNamed(context, Routes.foodAndBeverageScreen);
    } else if (title == 'Wellness') {
      if ((Prefs.getSiteid() ?? 0) == 2459) {
        showToastDialog(
            msg:
                'This Module is not opted. kindly contact your administrator.');
        return;
      }
      await logEvents(name: AnalyticsEventNames.wellnessPageClicked);
      Navigator.pushNamed(context, Routes.marketPlaceScreen);
    } else if (title == 'Payments') {
      if ((Prefs.getSiteid() ?? 0) == 2459) {
        showToastDialog(
            msg:
                'This Module is not opted. kindly contact your administrator.');
        return;
      }
      await logEvents(name: AnalyticsEventNames.paymentsPageClicked);
      Navigator.pushNamed(context, Routes.invoiceScreen);
    } else if (title == 'Documents') {
      await logEvents(name: AnalyticsEventNames.documentsPageClicked);
      Navigator.pushNamed(context, Routes.userDocumentScreen);
    } else if (title == 'Tasks') {
      await logEvents(name: AnalyticsEventNames.tasksPageClicked);
      Navigator.pushNamed(context, Routes.dailyTaskScreen,
          arguments: DailyTaskRouteModel(
              from: DailyTaskFromEnum.fromHomeAdmin, date: DateTime.now()));
    } else if (title == 'Book Parking') {
      await logEvents(name: AnalyticsEventNames.bookParkingPageClicked);
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return const BookParkingCalendarScreen();
        },
      ));
      // Navigator.pushNamed(context, Routes.parkingManagementScreen);
    } else if (title == 'Inventory') {
      await logEvents(name: AnalyticsEventNames.inventoryPageClicked);
      Navigator.pushNamed(context, Routes.userInventoryScreen);
    } else if (title == 'Broadcast') {
      await logEvents(name: AnalyticsEventNames.broadcastPageClicked);
      Navigator.pushNamed(context, Routes.noticeScreen);
    } else if (title == 'Breakdown') {
      await logEvents(name: AnalyticsEventNames.breakdownPageClicked);
      Navigator.pushNamed(context, Routes.userBreakdownScreen);
    } else if (title == 'Events') {
      await logEvents(name: AnalyticsEventNames.eventsPageClicked);
      Navigator.pushNamed(context, Routes.eventsScreen,
          arguments: EventComingFrom.home);
    } else if (title == 'Mailroom') {
      await logEvents(name: AnalyticsEventNames.mailroomPageClicked);
      Navigator.pushNamed(context, Routes.mailroomScreen);
    } else if (title == 'Transport') {
      await logEvents(name: AnalyticsEventNames.transportPageClicked);
      Navigator.pushNamed(context, Routes.transportScreen);
    } else if (title == "Business Card") {
      await logEvents(name: AnalyticsEventNames.businessCardPageClicked);
      Navigator.pushNamed(context, Routes.myBusinessCardScreen);
    }
    // else if (title == 'Task Management') {
    //    Navigator.pushNamed(context, Routes.taskManagementScreen);
    // }
    else if (title == 'Task Management') {
      await logEvents(name: AnalyticsEventNames.taskManagementPageClicked);
      // Navigator.pushNamed(context, Routes.tasksScreen);
      logInfo(msg: 'prefs_user_id: ${Prefs.getUserId()}');
      Navigator.push(context, MaterialPageRoute(builder: (_) {
        return FlutterPkgLockatedTaskManagement(
          lockatedToken: Prefs.getLockatedToken() ?? '',
          firstName: Prefs.getPersonalName() ?? '',
          lastName: Prefs.getLastName() ?? '',
          userId: Prefs.getUserId().toString(),
          comingFor: FlutterPkgLockatedTaskManagementComingFor.home,
        );
      }));
    } else if (title == 'Audit') {
      await logEvents(name: AnalyticsEventNames.auditPageClicked);
      Navigator.pushNamed(context, Routes.auditScreen);
    } else if (title == 'MOM') {
      await logEvents(name: AnalyticsEventNames.momPageClicked);
      Navigator.pushNamed(context, Routes.momScreen);
    } else if (title == 'Quick Call') {
      await logEvents(name: AnalyticsEventNames.directoryPageClicked);
      Navigator.pushNamed(
        context,
        Routes.directoryScreen,
        arguments: DIrectoryComingFrom.home,
      );
    }
    */
  }

  static Future<bool> logoutUser({
    bool shouldCallDeleteDevice = false,
    BuildContext? context,
  }) async {
    String id = Prefs.getEmailAddress() ?? '';
    await logEvents(
        name: AnalyticsEventNames.logOutButtonClicked,
        parameters: {'id': id});
    // IUserRepository repository = UserRepository(); // Commented out
    final res = await Prefs.clear();
    // Commented out database calls
    /*
    final database = await $FloorNotificationOfflineDatabase
        .databaseBuilder(notificationOfflineDatabaseName)
        .build();
    final dao = database.notifiactionOfflineDao;
    try {
      await dao.deleteAll();
    } catch (e) {
      logError(msg: e);
    }
    */
    try {
      const storage = FlutterSecureStorage();
      await storage.deleteAll();
    } catch (e) {
      logError(msg: e);
    }
    if (!shouldCallDeleteDevice) {
      return true;
    }
    // Commented out calls to UserRepository
    /*
    if (context != null && context.mounted) {
      await repository.deleteDevices(context: context);
      return res;
    } else {
      await repository.deleteDevices();
      return res;
    }
    */
    return res;
  }

  /*
  // Commented out due to dependency on Travel package and CheckInOutProvider
  static Future<void> onViMilesClickedFromNoti({
    required BuildContext context,
  }) async {
    ITravelRepository travelRepository = TravelRepository();
    final vehicleResponse = await travelRepository.getVehicleDetails(
        context: context, lockatedToken: Prefs.getLockatedToken() ?? '');
    if (vehicleResponse?.data == null || vehicleResponse!.data!.isEmpty) {
      if (context.mounted) {
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return VehicleRegistrationScreen(
            vehicleDetails: vehicleResponse!,
          );
        }));
      }
    } else {
      if (context.mounted) {
        final vehicleHistoryResponse = await travelRepository.getVehicleHistory(
          context: context,
          lockatedToken: Prefs.getLockatedToken() ?? '',
          checkInTimeNull: 0,
          checkOutTimeNull: 1,
        );

        if (vehicleHistoryResponse?.data == null ||
            vehicleHistoryResponse!.data!.isEmpty) {
          if (context.mounted) {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return TravelScreen(
                vehicleDetails: vehicleResponse,
              );
            }));
          }
        } else {
          final lastRecord = vehicleHistoryResponse.data!.last;
          if (lastRecord.checkInTime != null &&
              lastRecord.checkOutTime == null) {
            if (context.mounted) {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return CheckOutScreen(
                  vehicleDataResponseModel: vehicleResponse,
                  vehicleHistoryModelData: lastRecord,
                );
              }));
            }
          } else {
            if (context.mounted) {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return TravelScreen(
                  vehicleDetails: vehicleResponse,
                );
              }));
            }
          }
        }
      }
    }
  }
  */

  static bool getDateDiff(String selectedDate, int limit) {
    // Log.e("selected_date", "" + selected_date);
    // Log.e("limit", "" + limit);
    bool isValid = false;
    DateFormat sdf = DateFormat("dd/MM/yyyy");

    try {
      DateTime date = sdf.parse(selectedDate);
      // Calendar calendar = Calendar.getInstance();

      DateTime currentDate = DateTime.now();
      int diff = date.millisecond - currentDate.millisecond;
      int dayCount = date.difference(currentDate).inDays;

      logInfo(msg: "dayCount: $dayCount");
      //limit 5  ;diff 6
      isValid = dayCount < limit;
    } catch (e) {
      logError(msg: e);
    }

    logInfo(msg: "dayCount: $isValid");

    return isValid;
  }

  static Future<void> navigateToModule(
      BuildContext context, String title) async {
    // Redirecting to onGridOnTap for centralized navigation logic (which is now filtered)
    onGridOnTap(title: title, context: context);
  }

  // - Mark Attendance by Face -
  // Commented out as it relates to general attendance not specifically parking
  /*
  static Future<bool> shouldMarkAttendance(String value) async {
    bool temp = true;
    final attendanceMarkedDate = Prefs.getFaceDetectorInitialDate();
    // final attendanceMarkedDate = value;
    if (attendanceMarkedDate != null) {
      final now = DateTime.now();
      final nowParsed =
          DateFormat('yyyy-MM-dd').parse('${now.year}-${now.month}-${now.day}');
      final markedDateParsed =
          DateFormat('yyyy-MM-dd').parse(attendanceMarkedDate);

      temp = !isSameDay(nowParsed, markedDateParsed);
      addAttendanceMarkedDate();
    } else {
      addAttendanceMarkedDate();
    }
    return temp;
  }

  static Future<void> addAttendanceMarkedDate() async {
    final now = DateTime.now();
    await Prefs.setFaceDetectorInitialDate(
        '${now.year}-${now.month}-${now.day}');
  }
  */
  // - End -
}