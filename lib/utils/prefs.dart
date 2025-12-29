import 'dart:convert';

// import 'package:flutter_go_phygital/models/all_ticket_filter_models/complaint_type_model.dart';
// import 'package:flutter_go_phygital/models/all_ticket_filter_models/helpdesk_categories_response_model.dart';
// import 'package:flutter_go_phygital/models/all_ticket_filter_models/helpdesk_sub_categories_response_model.dart';
// import 'package:flutter_go_phygital/models/all_ticket_filter_models/pms_user_response_model.dart';
// import 'package:flutter_go_phygital/models/all_ticket_filter_models/priority_filter_model.dart';
// import 'package:flutter_go_phygital/models/all_ticket_filter_models/ticket_filter_data_response_model.dart';
// import 'package:flutter_go_phygital/screens/home_revamped/tabs/home_revamped_explore_tab_screen/models/custom_home_revamped_explore_tab_main_item_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

// import '../models/notice_board/notice_board_model/notice_board_model.dart';

class Prefs {
  static late final SharedPreferences preferences;
  static Future<SharedPreferences> init() async =>
      preferences = await SharedPreferences.getInstance();

  static String isFromNoti = "is_from_noti";

  static String lockatedToken = "Lockated_Token";
  static String lockatedSSOToken = "Lockated_SSO_Token";
  static String gcmRegId = "GCMID";

  static String splashScreenUrl = "SPLASH_SCREEN_URL";

  //Pms Sites
  static String pmsSiteId = "pmsSiteId";
  static String pmsSiteName = "pmsSiteName";
  static String pmsCompanyId = "pmsCompanyId";
  static String pmsSiteLatitude = "pmsSiteLatitude";
  static String pmsSiteLongitude = "pmsSiteLongitude";
  static String pmsSetGeoFence = "pmsSiteGoeFence";
  static String pmsAttendanceImage = "pmsAttendanceImage";

  //Account Details
  static String designation = "designation";
  static String domainUrl = "domainUrl";

  static String siteId = "site_id";
  static String contactNumber = "Contact_Number";
  static String emailId = "Email";
  static String customUrl = "customUrl";
  static String societyId = "societyId";
  static String userSocietyId = "UserSocietyId";
  static String userId = "userId";
  static String personalAvatar = "personal_avatar";
  static String personalName = "FirstName";
  static String lastName = "Last_Name";
  static String unitName = "unitName";
  static String departmentId = 'departmentId';
  static String departmentName = "departmentName";
  static String TEMPERATURE_ENABLED = "TEMPERATURE_ENABLED";
  static String HEALTH_QUESTIONS_ENABLED = "HEALTH_QUESTIONS_ENABLED";
  static String isApproved = "isApproved";
  static String userFaceAdded = "userFaceAdded";
  static String isbillsAndPaymentsEnabledForSite =
      "isBillsAndPaymentsEnabledForSite";
  static String notyValue = "notyValue";
  static String pmsUserType = "pmsUserType";
  static String rolesJsonResp = "RolesJsonResp";

  static String adminAttendanceEnabled = "pmsAdminAttendanceEnabled";
  static String technicianAttendanceEnabled = "pmsTechnicianAttendanceEnabled";
  static String occupantAttendanceEnabled = "pmsOccupantAttendanceEnabled";

  static String isLockUserPermissionEnabled = "Lock User Permission";
  static String isLockUserPermissionActive = "Lock User Status";
  static String operationHoursMSG = "Operational Hours Message";

  static String ticketUrgencyEnabled = "pmsUrgencyEnabled";

  static String faceRecognitionEnabled = "faceRecognitionEnbled";
  static String pmsUsersList = "PmsUserList";

  static String isRestaurants = "isRestaurants";
  static String isSpaceManagement = "isSpaceManagement";
  static String sFacilityBookingsEnabledForSite =
      "sFacilityBookingsEnabledForSite";

  //Ticket Filter Prefs Keys
  static String helpdeskFilteredUrlAssignedTickets =
      "helpdeskFilteredUrlAssignedTickets";
  static String helpdeskFilterScreenAssinees = "helpdeskFilterScreenAssinees";
  static String helpdeskFilterScreenSelectedDate =
      "helpdeskFilterScreenSelectedDate";
  static String helpdeskFilterScreenSubCategory =
      "helpdeskFilterScreenSubCategory";
  static String helpdeskFilterScreenPriority = "helpdeskFilterScreenPriority";
  static String helpdeskFilterScreenComplaintType =
      "helpdeskFilterScreenComplaintType";
  static String helpdeskFilterScreenDepartment =
      "helpdeskFilterScreenDepartment";
  static String helpdeskFilterScreenUnit = "helpdeskFilterScreenUnit";
  static String helpdeskFilterScreenStatus = "helpdeskFilterScreenStatus";
  static String helpdeskFilterScreenCategory = "helpdeskFilterScreenCategory";

  static String iTowerIdTag = "iTowerIdTag";
  static String iFloorIdTag = "iFloorIdTag";
  static String sFloorNameTag = "sFloorNameTag";
  static String sTowerNameTag = "sTowerNameTag";
  static String sFloorPlanTag = "sFloorPlanTag";

  //Attendance
  static String checkInTime = "checkInTime";

  static String checkOutTime = "checkOutTime";

  static String checkInFlag = "checkInFlag";

  static String checkInFlag2 = "checkInFlag";

  //Fitout
  static String fitoutAmount = 'fitout_amount';

  static String groupList = "groupList";

  static String ticketWingEnabled = 'ticket_wing_enabled';

  static String ticketAreaEnabled = 'ticket_area_enabled';

  static String subCategoryLocationEnabled = 'sub_category_location_enabled';

  //Default Visitor Pass
  static String defaultVisitorPassEnabled = 'default_visitor_pass';

  static Future<void> setFitoutAmount(double value) async {
    await preferences.setDouble(fitoutAmount, value);
  }

  static double getFitoutAmount() {
    return preferences.getDouble(fitoutAmount) ?? 0;
  }

  //Temp
  static String tempIsApproved = 'temp_is_approved';
  static Future<void> setTempIsApproved(bool value) async {
    await preferences.setBool(tempIsApproved, value);
  }

  static bool getTempIsApproved() {
    return preferences.getBool(tempIsApproved) ?? false;
  }
  // --- End ---

  static Future<void> setSiteid(int id) async {
    await preferences.setInt(siteId, id);
  }

  static int? getSiteid() {
    return preferences.getInt(siteId);
  }

  // Business Card Start

  static Future<void> setDesignation(String designationName) async {
    await preferences.setString(designation, designationName);
  }

  static String? getDesignation() {
    return preferences.getString(designation) ?? '';
  }

  static Future<void> setDomainUrl(String domainURL) async {
    await preferences.setString(domainUrl, domainURL);
  }

  static String? getDomainUrl() {
    return preferences.getString(domainUrl) ?? '';
  }

  // Business Card End

  static Future<void> setIsFromNoti(bool value) async {
    await preferences.setBool(isFromNoti, value);
  }

  static bool getIsFromNoti() {
    return preferences.getBool(isFromNoti) ?? false;
  }

  static Future<void> setLockatedSSOToken(String token) async {
    await preferences.setString(lockatedSSOToken, token);
  }

  static String? getLockatedSSOToken() {
    return preferences.getString(lockatedSSOToken) ?? '';
  }

  static Future<void> setLockatedToken(String token) async {
    await preferences.setString(lockatedToken, token);
  }

  //TODO Change Default Token to null
  static String? getLockatedToken() {
    return preferences.getString(lockatedToken) ?? '';
  }

  static Future<void> setGcmId(String id) async {
    await preferences.setString(gcmRegId, id);
  }

  static String? getGcmId() {
    return preferences.getString(gcmRegId);
  }

  static void setUserid(int id) async {
    await preferences.setInt('userid', id);
  }

  static int? getuserid() {
    return preferences.getInt('userid');
  }

  static Future<void> setSplashScreenUrl(String url) async {
    await preferences.setString(splashScreenUrl, url);
  }

  static String? getSplashScreenUrl() {
    return preferences.getString(splashScreenUrl);
  }

  static Future<void> setUserSiteId(int id) async {
    await preferences.setInt(pmsSiteId, id);
  }

  static int? getUserSiteId() {
    return preferences.getInt(pmsSiteId);
  }

  static Future<void> setPmsSiteName(String name) async {
    await preferences.setString(pmsSiteName, name);
  }

  static String? getPmsSiteName() {
    return preferences.getString(pmsSiteName);
  }

  static Future<void> setPmsCompanyId(int id) async {
    await preferences.setInt(pmsCompanyId, id);
  }

  static int? getPmsCompanyId() {
    return preferences.getInt(pmsCompanyId);
  }

  static Future<void> setContactNumber(String number) async {
    await preferences.setString(contactNumber, number);
  }

  static String? getContactNumber() {
    return preferences.getString(contactNumber);
  }

  static Future<void> setEmailAddress(String email) async {
    await preferences.setString(emailId, email);
  }

  static String? getEmailAddress() {
    return preferences.getString(emailId);
  }

  static Future<void> setCustomUrl(String url) async {
    await preferences.setString(customUrl, url);
  }

  static String? getCustomUrl() {
    return preferences.getString(customUrl);
  }

  static Future<void> setSocietyId(String value) async {
    await preferences.setString(societyId, value);
  }

  //TODO Change Default Id To blank
  static String getSocietyId() {
    // return preferences.getString(societyId) ?? '3492';
    return preferences.getString(societyId) ?? '';
  }

  static Future<void> setUserSocietyId(int id) async {
    await preferences.setInt(userSocietyId, id);
  }

  //TODO Change Default Id To 0
  static int getUserSocietyId() {
    return preferences.getInt(userSocietyId) ?? 3792;
  }

  static Future<void> setUserId(int id) async {
    await preferences.setInt(userId, id);
  }

  static int? getUserId() {
    return preferences.getInt(userId);
  }

  static Future<void> setPersonalName(String name) async {
    await preferences.setString(personalName, name);
  }

  static String? getPersonalName() {
    return preferences.getString(personalName);
  }

  static Future<void> setLastName(String name) async {
    await preferences.setString(lastName, name);
  }

  static String? getLastName() {
    return preferences.getString(lastName);
  }

  static Future<void> setImageAvatar(String avatar) async {
    await preferences.setString(personalAvatar, avatar);
  }

  static String? getImageAvatar() {
    return preferences.getString(personalAvatar);
  }

  static Future<void> setUnitName(String name) async {
    await preferences.setString(unitName, name);
  }

  static String? getUnitName() {
    return preferences.getString(unitName);
  }

  static Future<void> setDepartmentId(int id) async {
    await preferences.setInt(departmentId, id);
  }

  static int? getDepartmentId() {
    return preferences.getInt(departmentId);
  }

  static Future<void> setDepartmentName(String name) async {
    await preferences.setString(departmentName, name);
  }

  static String? getDepartmentName() {
    return preferences.getString(departmentName);
  }

  static Future<void> setTemperatureEnabled(bool isenabled) async {
    await preferences.setBool(TEMPERATURE_ENABLED, isenabled);
  }

  static bool? isTemperatureEnabled() {
    return preferences.getBool(TEMPERATURE_ENABLED);
  }

  static Future<void> setHealthQuestionsEnabled(bool isenabled) async {
    await preferences.setBool(HEALTH_QUESTIONS_ENABLED, isenabled);
  }

  static bool? isHealthQuestionsEnabled() {
    return preferences.getBool(HEALTH_QUESTIONS_ENABLED);
  }

  static Future<void> setApproved(bool isenabled) async {
    await preferences.setBool(isApproved, isenabled);
  }

  static bool? getApproved() {
    return preferences.getBool(isApproved);
  }

  static Future<void> setIsFaceAdded(bool isenabled) async {
    await preferences.setBool(userFaceAdded, isenabled);
  }

  static bool? isFaceAdded() {
    return preferences.getBool(userFaceAdded);
  }

  static Future<void> setBillsAndPaymentsEnabledForSite(bool isenabled) async {
    await preferences.setBool(isbillsAndPaymentsEnabledForSite, isenabled);
  }

  static bool? isBillsAndPaymentsEnabledForSite() {
    return preferences.getBool(isbillsAndPaymentsEnabledForSite);
  }

  static Future<void> setNotificationValue(bool isenabled) async {
    await preferences.setBool(notyValue, isenabled);
  }

  static bool? getNotificationValue() {
    return preferences.getBool(notyValue);
  }

  static Future<void> setPmsUserType(String name) async {
    await preferences.setString(pmsUserType, name);
  }

  static String? getPmsUserType() {
    return preferences.getString(pmsUserType);
  }

  static Future<void> setPmsAdminAttendanceEnabled(bool isenabled) async {
    await preferences.setBool(adminAttendanceEnabled, isenabled);
  }

  static bool? getPmsAdminAttendanceEnabled() {
    return preferences.getBool(adminAttendanceEnabled);
  }

  static Future<void> setPmsTechnicianAttendanceEnabled(bool isenabled) async {
    await preferences.setBool(technicianAttendanceEnabled, isenabled);
  }

  static bool? getPmsTechnicianAttendanceEnabled() {
    return preferences.getBool(technicianAttendanceEnabled);
  }

  static Future<void> setPmsOccupantAttendanceEnabled(bool isenabled) async {
    await preferences.setBool(occupantAttendanceEnabled, isenabled);
  }

  static bool? getPmsOccupantAttendanceEnabled() {
    return preferences.getBool(occupantAttendanceEnabled);
  }

  static Future<void> setIsLockUserPermissionEnabled(bool isenabled) async {
    await preferences.setBool(isLockUserPermissionEnabled, isenabled);
  }

  static bool? getIsLockPermissionEnbled() {
    return preferences.getBool(isLockUserPermissionEnabled);
  }

  static Future<void> setIsLockUserPermissionActive(bool isenabled) async {
    await preferences.setBool(isLockUserPermissionActive, isenabled);
  }

  static bool? getIsLockPermissionActive() {
    return preferences.getBool(isLockUserPermissionActive);
  }

  static Future<void> setIsTicketUrgencyEnabled(bool isenabled) async {
    await preferences.setBool(ticketUrgencyEnabled, isenabled);
  }

  // Notices Start

  // static Future<void> saveArrayList(
  //     List<NoticeBoardModel> list, String key) async {
  //   await preferences.setString(key, jsonEncode(list));
  // }

  // static List<NoticeBoardModel> getArrayList(String key) {
  //   List<NoticeBoardModel> result = [];

  //   String? list = preferences.getString(key);
  //   if (list != null) {
  //     final json = jsonDecode(list);
  //     result = json
  //         .map<NoticeBoardModel>(
  //             (e) => NoticeBoardModel.fromJson(e as Map<String, dynamic>))
  //         .toList();
  //   }
  //   return result;
  // }

  // Notices End

  static bool? getIsTicketUrgencyEnabled() {
    return preferences.getBool(ticketUrgencyEnabled);
  }

  static Future<void> setIsFrEnabled(bool isenabled) async {
    await preferences.setBool(faceRecognitionEnabled, isenabled);
  }

  static bool? getIsFREnabled() {
    return preferences.getBool(faceRecognitionEnabled);
  }

  static Future<void> setPmsUsersList(String value) async {
    await preferences.setString(pmsUsersList, value);
  }

  static String? getPmsUsersList() {
    return preferences.getString(pmsUsersList);
  }

  static Future<void> setSiteOperationHoursMSG(String name) async {
    await preferences.setString(operationHoursMSG, name);
  }

  static String? getSiteOperationHoursMSG() {
    return preferences.getString(operationHoursMSG);
  }

  static Future<void> setRolesJson(String json) async {
    await preferences.setString(rolesJsonResp, json);
  }

  static String? getRolesJson() {
    return preferences.getString(rolesJsonResp);
  }

  static Future<void> setRestaurantsEnabled(bool isenabled) async {
    await preferences.setBool(isRestaurants, isenabled);
  }

  static bool? isRestaurantsEnabled() {
    return preferences.getBool(isRestaurants);
  }

  static Future<void> setFacilityBookingsEnabledForSite(bool isenabled) async {
    await preferences.setBool(sFacilityBookingsEnabledForSite, isenabled);
  }

  static bool? getFacilityBookingsEnabledForSite() {
    return preferences.getBool(sFacilityBookingsEnabledForSite);
  }

  static Future<void> setSpaceManagementEnabled(bool isenabled) async {
    await preferences.setBool(isSpaceManagement, isenabled);
  }

  static bool? isSpaceManagementEnabled() {
    return preferences.getBool(isSpaceManagement);
  }

  static Future<void> setPmsSiteLatitude(String latitude) async {
    await preferences.setString(pmsSiteLatitude, latitude);
  }

  static String? getPmsSiteLatitude() {
    return preferences.getString(pmsSiteLatitude);
  }

  static Future<void> setPmsSiteLongitude(String longitude) async {
    await preferences.setString(pmsSiteLongitude, longitude);
  }

  static String? getPmsSiteLongitude() {
    return preferences.getString(pmsSiteLongitude);
  }

  static Future<void> setPmsSiteGeofence(double geo) async {
    await preferences.setDouble(pmsSetGeoFence, geo);
  }

  static double? getPmsSiteGeofence() {
    return preferences.getDouble(pmsSetGeoFence);
  }

  static Future<void> setPmsAttendanceImage(bool isEnabled) async {
    await preferences.setBool(pmsAttendanceImage, isEnabled);
  }

  static bool? getPmsAttendanceImage() {
    return preferences.getBool(pmsAttendanceImage);
  }

  //Ticket Filter Prefs Setter and Getter - Start -

  //Base Url
  static Future<void> setHelpdeskFilteredUrlAssignedTickets(
      String value) async {
    await preferences.setString(helpdeskFilteredUrlAssignedTickets, value);
  }

  static String? getHelpdeskFilteredUrlAssignedTickets() {
    return preferences.getString(helpdeskFilteredUrlAssignedTickets);
  }

  // //Pms User
  // static Future<void> setHelpdeskFilterScreenAssineesList(String value) async {
  //   await preferences.setString(helpdeskFilterScreenAssinees, value);
  // }

  // static List<PmsUser>? getHelpdeskFilterScreenAssineesList() {
  //   if (preferences.getString(helpdeskFilterScreenAssinees) != null) {
  //     final res =
  //         jsonDecode(preferences.getString(helpdeskFilterScreenAssinees) ?? '');
  //     final result = List<PmsUser>.from(res.map((x) => PmsUser.fromJson(x)));
  //     return result;
  //   } else {
  //     return null;
  //   }
  // }

  //Categories
  // static Future<void> setHelpdeskFilterScreenCategoryList(String value) async {
  //   await preferences.setString(helpdeskFilterScreenCategory, value);
  // }

  // static List<HelpdeskCategory>? getHelpdeskFilterScreenCategoryList() {
  //   if (preferences.getString(helpdeskFilterScreenCategory) != null) {
  //     final res =
  //         jsonDecode(preferences.getString(helpdeskFilterScreenCategory) ?? '');
  //     final result = List<HelpdeskCategory>.from(
  //         res.map((x) => HelpdeskCategory.fromJson(x)));
  //     return result;
  //   } else {
  //     return null;
  //   }
  // }

  // //Status
  // static Future<void> setHelpdeskFilterScreenStatusList(String value) async {
  //   await preferences.setString(helpdeskFilterScreenStatus, value);
  // }

  // static List<Status>? getHelpdeskFilterScreenStatusList() {
  //   if (preferences.getString(helpdeskFilterScreenStatus) != null) {
  //     final res =
  //         jsonDecode(preferences.getString(helpdeskFilterScreenStatus) ?? '');
  //     final result = List<Status>.from(res.map((x) => Status.fromJson(x)));
  //     return result;
  //   } else {
  //     return null;
  //   }
  // }

  //Unit
  // static Future<void> setHelpdeskFilterScreenUnitList(String value) async {
  //   await preferences.setString(helpdeskFilterScreenUnit, value);
  // }

  // static List<Unit>? getHelpdeskFilterScreenUnitList() {
  //   if (preferences.getString(helpdeskFilterScreenUnit) != null) {
  //     final res =
  //         jsonDecode(preferences.getString(helpdeskFilterScreenUnit) ?? '');
  //     final result = List<Unit>.from(res.map((x) => Unit.fromJson(x)));
  //     return result;
  //   } else {
  //     return null;
  //   }
  // }

  //Department
  static Future<void> setHelpdeskFilterScreenDepartmentList(
      String value) async {
    await preferences.setString(helpdeskFilterScreenDepartment, value);
  }

  // static List<Department>? getHelpdeskFilterScreenDepartmentList() {
  //   if (preferences.getString(helpdeskFilterScreenDepartment) != null) {
  //     final res = jsonDecode(
  //         preferences.getString(helpdeskFilterScreenDepartment) ?? '');
  //     final result =
  //         List<Department>.from(res.map((x) => Department.fromJson(x)));
  //     return result;
  //   } else {
  //     return null;
  //   }
  // }

  //Complaint Type
  // static Future<void> setHelpdeskFilterScreenComplaintTypeList(
  //     String value) async {
  //   await preferences.setString(helpdeskFilterScreenComplaintType, value);
  // }

  // static List<ComplaintTypeModel>? getHelpdeskFilterScreenComplaintTypeList() {
  //   if (preferences.getString(helpdeskFilterScreenComplaintType) != null) {
  //     final res = jsonDecode(
  //         preferences.getString(helpdeskFilterScreenComplaintType) ?? '');
  //     final result = List<ComplaintTypeModel>.from(
  //         res.map((x) => ComplaintTypeModel.fromJson(x)));
  //     return result;
  //   } else {
  //     return null;
  //   }
  // }

  // //Priority
  // static Future<void> setHelpdeskFilterScreenPriorityList(String value) async {
  //   await preferences.setString(helpdeskFilterScreenPriority, value);
  // }

  // static List<PriorityFilterModel>? getHelpdeskFilterScreenPriorityList() {
  //   if (preferences.getString(helpdeskFilterScreenPriority) != null) {
  //     final res =
  //         jsonDecode(preferences.getString(helpdeskFilterScreenPriority) ?? '');
  //     final result = List<PriorityFilterModel>.from(
  //         res.map((x) => PriorityFilterModel.fromJson(x)));
  //     return result;
  //   } else {
  //     return null;
  //   }
  // }

  // //Sub Categories
  // static Future<void> setHelpdeskFilterScreenSubCategoryList(
  //     String value) async {
  //   await preferences.setString(helpdeskFilterScreenSubCategory, value);
  // }

  // static List<SubCategory>? getHelpdeskFilterScreenSubCategoryList() {
  //   if (preferences.getString(helpdeskFilterScreenSubCategory) != null) {
  //     final res = jsonDecode(
  //         preferences.getString(helpdeskFilterScreenSubCategory) ?? '');
  //     final result =
  //         List<SubCategory>.from(res.map((x) => SubCategory.fromJson(x)));
  //     return result;
  //   } else {
  //     return null;
  //   }
  // }

  //Sub Categories
  static Future<void> setHelpdeskFilterScreenSelectedDate(String value) async {
    await preferences.setString(helpdeskFilterScreenSelectedDate, value);
  }

  static String? getHelpdeskFilterScreenSelectedDate() {
    return preferences.getString(helpdeskFilterScreenSelectedDate);
  }

  // - End -

  //User Buildings and Floor Prefs - Start-

  static Future<void> setTowerId(int value) async {
    await preferences.setInt(iTowerIdTag, value);
  }

  static int? getTowerId() {
    return preferences.getInt(iTowerIdTag);
  }

  static Future<void> setFloorId(int value) async {
    await preferences.setInt(iFloorIdTag, value);
  }

  static int? getFloorId() {
    return preferences.getInt(iFloorIdTag);
  }

  static Future<void> setTowerName(String value) async {
    await preferences.setString(sTowerNameTag, value);
  }

  static String? getTowerName() {
    return preferences.getString(sTowerNameTag);
  }

  static Future<void> setFloorName(String value) async {
    await preferences.setString(sFloorNameTag, value);
  }

  static String? getFloorName() {
    return preferences.getString(sFloorNameTag);
  }

  static Future<void> setFloorPlan(String value) async {
    await preferences.setString(sFloorPlanTag, value);
  }

  static String? getFloorPlan() {
    return preferences.getString(sFloorPlanTag);
  }

  // - End -

  // Attendance - Start -

  static String getCheckInTime() {
    return preferences.getString(checkInTime) ?? '';
  }

  static Future<void> setCheckInTime(String ct) async {
    await preferences.setString(checkInTime, ct);
  }

  static String getCheckOutTime() {
    return preferences.getString(checkOutTime) ?? '';
  }

  static Future<void> setCheckOutTime(String ct) async {
    await preferences.setString(checkOutTime, ct);
  }

  static String getCheckInFlag() {
    return preferences.getString(checkInFlag) ?? '';
  }

  static Future<void> setCheckInFlag(String ct) async {
    await preferences.setString(checkInFlag, ct);
  }

  // - End -

  static Future<void> setGroupList(String jsonObject) async {
    await preferences.setString(groupList, jsonObject.toString());
  }

  static String? getGroupList() {
    return preferences.getString(groupList);
  }

  static Future<void> setTicketWingEnabled(bool value) async {
    await preferences.setBool(ticketWingEnabled, value);
  }

  static bool getTicketWingEnabled() {
    return preferences.getBool(ticketWingEnabled) ?? false;
  }

  static Future<void> setTicketAreaEnabled(bool value) async {
    await preferences.setBool(ticketAreaEnabled, value);
  }

  static bool getTicketAreaEnabled() {
    return preferences.getBool(ticketAreaEnabled) ?? false;
  }

  static Future<void> setSubCategoryLocationEnabled(bool value) async {
    await preferences.setBool(subCategoryLocationEnabled, value);
  }

  static bool getSubCategoryLocationEnabled() {
    return preferences.getBool(subCategoryLocationEnabled) ?? false;
  }

  //Fitout
  static String fitoutEnabled = 'fitout_enabled';

  static Future<void> setFitoutEnabled(bool value) async {
    await preferences.setBool(fitoutEnabled, value);
  }

  static bool getFitoutEnabled() {
    return preferences.getBool(fitoutEnabled) ?? false;
  }

  static String parkingEnabledForSite = 'parkingEnabledForSite';

  static Future<void> setParkingEnabledForSite(bool value) async {
    await preferences.setBool(parkingEnabledForSite, value);
  }

  static bool getParkingEnabledForSite() {
    return preferences.getBool(parkingEnabledForSite) ?? false;
  }

  static String ecommerceServiceEnabled = 'ecommerceServiceEnabled';

  static Future<void> setEcommerceServiceEnabled(bool value) async {
    await preferences.setBool(ecommerceServiceEnabled, value);
  }

  static bool getEcommerceServiceEnabled() {
    return preferences.getBool(ecommerceServiceEnabled) ?? false;
  }

  static String mailroomEnabled = 'mailroomEnabled';

  static Future<void> setMailroomEnabled(bool value) async {
    await preferences.setBool(mailroomEnabled, value);
  }

  static bool getMailroomEnabled() {
    return preferences.getBool(mailroomEnabled) ?? false;
  }

  static String eventsEnabled = 'eventsEnabled';

  static Future<void> setEventsEnabled(bool value) async {
    await preferences.setBool(eventsEnabled, value);
  }

  static bool getEventsEnabled() {
    return preferences.getBool(eventsEnabled) ?? false;
  }

  static String documentsEnabled = 'documentsEnabled';

  static Future<void> setDocumentsEnabled(bool value) async {
    await preferences.setBool(documentsEnabled, value);
  }

  static bool getDocumentsEnabled() {
    return preferences.getBool(documentsEnabled) ?? false;
  }

  // Added for first run
  static String isFirstRun = "is_First_Run";

  static Future<void> setIsFirstRun(bool value) async {
    await preferences.setBool(isFirstRun, value);
  }

  static bool getIsFirstRun() {
    return preferences.getBool(isFirstRun) ?? true;
  }

  // - End -

  // - Fitness -

  static String stepsEnabled = "steps_enabled";

  static Future<void> setStepsEnabled(bool value) async {
    await preferences.setBool(stepsEnabled, value);
  }

  static bool getStepsEnabled() {
    return preferences.getBool(stepsEnabled) ?? false;
  }

  static String isHealthPermissionGiven = "isHealthPermissionGiven";

  static Future<void> setIsHealthPermissionGiven(bool value) async {
    await preferences.setBool(isHealthPermissionGiven, value);
  }

  static bool getIsHealthPermissionGiven() {
    return preferences.getBool(isHealthPermissionGiven) ?? false;
  }

  static String userFitnessWeight = 'userFitnessWeight';

  static Future<void> setUserFitnessWeight(int value) async {
    await preferences.setInt(userFitnessWeight, value);
  }

  static int getUserFitnessWeight() {
    return preferences.getInt(userFitnessWeight) ?? 0;
  }

  static String userFitnessHeight = 'userFitnessHeight';

  static Future<void> setUserFitnessHeight(int value) async {
    await preferences.setInt(userFitnessHeight, value);
  }

  static int getUserFitnessHeight() {
    return preferences.getInt(userFitnessHeight) ?? 0;
  }

  static String userFitnessIdealWeight = 'userFitnessIdealWeight';

  static Future<void> setUserFitnessIdealWeight(int value) async {
    await preferences.setInt(userFitnessIdealWeight, value);
  }

  static int getUserFitnessIdealWeight() {
    return preferences.getInt(userFitnessIdealWeight) ?? 0;
  }

  static String userFitnessBmi = 'userFitnessBmi';

  static Future<void> setUserFitnessBmi(double value) async {
    await preferences.setDouble(userFitnessBmi, value);
  }

  static double getUserFitnessBmi() {
    return preferences.getDouble(userFitnessBmi) ?? 0;
  }

  static String userFitnessTargetSteps = 'userFitnessTargetSteps';

  static Future<void> setUserFitnessTargetSteps(int value) async {
    await preferences.setInt(userFitnessTargetSteps, value);
  }

  static int getUserFitnessTargetSteps() {
    return preferences.getInt(userFitnessTargetSteps) ?? 20000;
  }

  static String userFitnessTargetCalories = 'userFitnessTargetCalories';

  static Future<void> setUserFitnessTargetCalories(int value) async {
    await preferences.setInt(userFitnessTargetCalories, value);
  }

  static int getUserFitnessTargetCalories() {
    return preferences.getInt(userFitnessTargetCalories) ?? 10000;
  }

  // - End -

  // - Transport & Business Card Permissions -

  static String transportationEnabled = "transportation_enabled";

  static Future<void> setTransportationEnabled(bool value) async {
    await preferences.setBool(transportationEnabled, value);
  }

  static bool getTransportationEnabled() {
    return preferences.getBool(transportationEnabled) ?? false;
  }

  static String businessCardEnabled = "business_card_enabled";

  static Future<void> setBusinessCardEnabled(bool value) async {
    await preferences.setBool(businessCardEnabled, value);
  }

  static bool getBusinessCardEnabled() {
    return preferences.getBool(businessCardEnabled) ?? false;
  }

  // - End -

  static String isAdmin = 'is_admin';
  static String isOccupant = 'is_occupant';
  static Future<void> setIsAdmin(bool value) async {
    await preferences.setBool(isAdmin, value);
  }

  static bool getIsAdmin() {
    return preferences.getBool(isAdmin) ?? false;
  }

  static Future<void> setIsOccupant(bool value) async {
    await preferences.setBool(isOccupant, value);
  }

  static bool getIsOccupant() {
    return preferences.getBool(isOccupant) ?? false;
  }

  // - Audit & Task -

  static String operationalAuditEnabled = 'operational_audit_enabled';

  static Future<void> setOperationalAuditEnabled(bool value) async {
    await preferences.setBool(operationalAuditEnabled, value);
  }

  static bool getOperationalAuditEnabled() {
    return preferences.getBool(operationalAuditEnabled) ?? false;
  }

  // - End -

  // - Visitor -

  static String visitorEnabled = 'visitor_enabled';

  static Future<void> setVisitorEnabled(bool value) async {
    await preferences.setBool(visitorEnabled, value);
  }

  static bool getVisitorEnabled() {
    return preferences.getBool(visitorEnabled) ?? false;
  }

  // - End -

  // Default Frequency Enabled
  static Future<void> setDefaultVisitorPassEnabled(bool value) async {
    await preferences.setBool(defaultVisitorPassEnabled, value);
  }

  static bool getDefaultVisitorPassEnabled() {
    return preferences.getBool(defaultVisitorPassEnabled) ?? false;
  }

  // - First Load -
  static String isFirstLoad = 'is_first_load';

  static Future<void> setIsFirstLoad(bool value) async {
    await preferences.setBool(isFirstLoad, value);
  }

  static bool getIsFirstLoad() {
    return preferences.getBool(isFirstLoad) ?? true;
  }

  // - End -

  // - User Data Synced Date -
  static String userDataSyncDate = 'user_data_sync_date';

  static Future<void> setUserDataSyncDate(String value) async {
    await preferences.setString(userDataSyncDate, value);
  }

  static String? getUserDataSyncDate() {
    return preferences.getString(userDataSyncDate);
  }

  // - End -

  // - Parking Auto Check In -
  static String parkingAutoCheckInDate = 'parking_auto_check_in_date';

  static Future<void> setParkingAutoCheckInDate(String value) async {
    await preferences.setString(parkingAutoCheckInDate, value);
  }

  static String? getParkingAutoCheckInDate() {
    return preferences.getString(parkingAutoCheckInDate);
  }

  static String parkingAutoCheckedIn = 'parking_auto_checked_in';

  static Future<void> setParkingAutoCheckedIn(bool value) async {
    await preferences.setBool(parkingAutoCheckedIn, value);
  }

  static bool? getParkingAutoCheckedIn() {
    return preferences.getBool(parkingAutoCheckedIn) ?? false;
  }

  static String parkingAutoCheckedOut = 'parking_auto_checked_out';

  static Future<void> setParkingAutoCheckedOut(bool value) async {
    await preferences.setBool(parkingAutoCheckedOut, value);
  }

  static bool? getParkingAutoCheckedOut() {
    return preferences.getBool(parkingAutoCheckedOut) ?? false;
  }
  // - End -

  // - Revamp Modules List -

  static String revampModuleList = 'revamp_module_list';

  static Future<void> setRevampModulesList(String value) async {
    await preferences.setString(revampModuleList, value);
  }

  // static List<CustomHomeRevampedExploreTabMainItemModel>?
  //     getRevampModulesList() {
  //   if (preferences.getString(revampModuleList) != null &&
  //       preferences.getString(revampModuleList)!.isNotEmpty) {
  //     final res = jsonDecode(preferences.getString(revampModuleList) ?? '');
  //     final result = List<CustomHomeRevampedExploreTabMainItemModel>.from(res
  //         .map((x) => CustomHomeRevampedExploreTabMainItemModel.fromJson(x)));
  //     return result;
  //   } else {
  //     return null;
  //   }
  // }

  // - End -

  // - Show All Facility List Only(New) For Specific Users -
  static String showAllFacilityBookingsToOccupants =
      'show_all_facility_bookings_to_occupants';

  static Future<void> setShowAllFacilityBookingsToOccupants(
      String value) async {
    await preferences.setString(showAllFacilityBookingsToOccupants, value);
  }

  static String? getShowAllFacilityBookingsToOccupants() {
    return preferences.getString(showAllFacilityBookingsToOccupants);
  }

  // - End -

  // - Show All Facility List Only(New) For Specific Users -
  static String parkingBookingAdvanceDays = 'parkingBookingAdvanceDays';

  static Future<void> setParkingBookingAdvanceDays(int value) async {
    await preferences.setInt(parkingBookingAdvanceDays, value);
  }

  static int? getParkingBookingAdvanceDays() {
    return preferences.getInt(parkingBookingAdvanceDays);
  }

  // - End -

  // - TravelModuleDefaultCamera -

  static String travelModuleDefaultCamera = "travelModuleDefaultCamera";

  static Future<void> setTravelModuleDefaultCamera(bool value) async {
    await preferences.setBool(travelModuleDefaultCamera, value);
  }

  static bool getTravelModuleDefaultCamera() {
    return preferences.getBool(travelModuleDefaultCamera) ?? true;
  }

  // - End -

  // - User Activity -

  static String userActivityDate = "userActivityDate";

  static Future<void> setUserActivityDate(String value) async {
    await preferences.setString(userActivityDate, value);
  }

  static String? getUserActivityDate() {
    return preferences.getString(userActivityDate);
  }

  // - End -

  // - User Role Name -

  static String userRoleName = "userRoleName";

  static Future<void> setUserRoleName(String value) async {
    await preferences.setString(userRoleName, value);
  }

  static String? getUserRoleName() {
    return preferences.getString(userRoleName);
  }

  // - End -

  // - Steps Dashboard Enabled -

  static String stepsDashboardEnabled = "stepsDashboardEnabled";

  static Future<void> setStepsDashboardEnabled(bool value) async {
    await preferences.setBool(stepsDashboardEnabled, value);
  }

  static bool getStepsDashboardEnabled() {
    // return preferences.getBool(stepsDashboardEnabled) ?? false;
    return true;
  }

  // - End -

  // - Face Detector Date -

  static String faceDetectorInitialDate = "faceDetectorInitialDate";

  static Future<void> setFaceDetectorInitialDate(String value) async {
    await preferences.setString(faceDetectorInitialDate, value);
  }

  static String? getFaceDetectorInitialDate() {
    return preferences.getString(faceDetectorInitialDate);
  }

  // - End -

  // - Employee Type -

  static String employeeType = "employeeType";

  static Future<void> setEmployeeType(String value) async {
    await preferences.setString(employeeType, value);
  }

  static String? getEmployeeType() {
    return preferences.getString(employeeType);
  }

  // - End -

  static Future<bool> clear() {
    return preferences.clear();
  }
}

class Util {
  static showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
