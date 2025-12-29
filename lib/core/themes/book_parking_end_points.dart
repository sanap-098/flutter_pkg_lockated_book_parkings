import 'package:flutter_pkg_lockated_gophygital_widgets/core/parent_end_points.dart';

class BookParkingEndPoints {
  // - Gophygital -
  // static String getAppId = "26";
  // static String getNotiAppId = "28";
  // - Vi -
  static String getAppId = "31";
  static String getNotiAppId = "40";
  static String getAppSupportId = '2649';
  // static const String baseURL = "https://snagging.lockated.com/api/";
  // static const String baseURLTwo = "https://lockated.com/";
  // static const String baseURLThree = "https://lockated.com/api/";
  // static const String baseURLFour = "https://lockated.com/";
  // static const String baseURLfive = "https://lockated.com/api/";
  // static const String baseURLsix = "https://lockated.com/";
  // static const String baseURLsaven = "https://lockated.com/";
  // static const String baseURLEight =
  //     'https://snagging.lockated.com/'; //snagging
  // static const String baseURLNine =
  //     'https://snagging.lockated.com/pms/admin/'; //snagging
  // static const String baseURLTen = "https://snagging.lockated.com/"; //snagging

  // static const String baseURL = "https://vi.gophygital.work/api/";
  // static const String baseURLTwo = "https://vi.gophygital.work/";
  // static const String baseURLThree = "https://vi.gophygital.work/api/";
  // static const String baseURLFour = "https://vi.gophygital.work/";
  // static const String baseURLfive = "https://vi.gophygital.work/api/";
  // static const String baseURLsix = "https://vi.gophygital.work/";
  // static const String baseURLsaven = "https://vi.gophygital.work/";
  // static const String baseURLEight =
  //     'https://vi.gophygital.work/'; //snagging
  // static const String baseURLNine =
  //     'https://vi.gophygital.work/pms/admin/'; //snagging
  // static const String baseURLTen = "https://vi.gophygital.work/"; //snagging

  static const String baseURL = ParentEndPoints.parentBaseURL;
  static const String baseURLTwo = ParentEndPoints.parentBaseURLTwo;
  static const String baseURLThree = ParentEndPoints.parentBaseURLThree;
  static const String baseURLFour = ParentEndPoints.parentBaseURLFour;
  static const String baseURLfive = ParentEndPoints.parentBaseURLfive;
  static const String baseURLsix = ParentEndPoints.parentBaseURLsix;
  static const String baseURLsaven = ParentEndPoints.parentBaseURLsaven;
  static const String baseURLEight =
      ParentEndPoints.parentBaseURLEight; //snagging
  static const String baseURLNine =
      ParentEndPoints.parentBaseURLNine; //snagging
  static const String baseURLTen = ParentEndPoints.parentBaseURLTen; //snagging

  //Splash Screen Endpoints
  static String getRolesDataUrl = baseURLTwo + "role_permissions.json?";
  static String getScreenUrl = baseURL + "users/account?";
  static String getUserSiteLists = baseURLTwo + "sitelist.json?";
  static String sendUserDetails = baseURLTwo + "user_devices.json?";

  // User(Login,Singup,Forgotpassword) Screens Endpoints
  static String LoginUrl = baseURLfive + "users/sign_in";
  // static String LoginUrl = baseURLfive + "users/new_sign_in";
  static String GenerateOtpUrl = baseURLsix + "generate_code";
  static String ValidateOtpUrl = baseURLsaven + "verify_code";
  static String forgotPasswordOtpUrl =
      baseURLThree + "users/forgot_password_otp";
  static String updatePersonalInformatio = baseURL + "users";
  static String pmsUpdateUser = '${baseURLEight}pms/users/';
  static String createNewUser = baseURLTwo + "pms/users/create_user.json";

  static String getForgotPasswordOtp =
      baseURLThree + "users/forgot_password_otp";
  static String getAllCompanyData = baseURLTwo + "/pms/company_setups/";
  static String changePmsSite = baseURLTwo + "/change_site.json?";
  static String addUserFace = baseURLTwo + "user_faces.json?";
  static String getAllUsersList =
      baseURLTwo + "pms/occupant_users.json?site_id=";
  static String getMyAttendanceList =
      baseURLTwo + "pms/attendances/attendance_details.json?token=";
  static String verifyPunchInOutDetals =
      baseURLTwo + "pms/attendances/attendance_info.json?";
  static String deleteDevices = baseURLTwo + 'delete_devices.json?app_id=';
  //Banners
  static String crmBannerApi = "${baseURLFour}society_banners.json?";

  //Temperature
  static String temperaturesUrl = baseURLTwo + "temperatures.json?";

  // Ticket Screen EndPoints
  static String getHelpdeskUrl = baseURLTwo + "pms/complaints.json?";
  static String getPmsUsers = baseURLTwo + "pms_users.json?";
  static String getHelpDeskCatecory =
      baseURLTwo + "pms/admin/helpdesk_categories.json?";
  static String getDataForFilters =
      baseURLTwo + "complaints/data_for_filter.json?token=";
  static String getSubCategories =
      baseURLTwo + "pms/admin/get_sub_categories.json?category_type_id=";
  static String getHelpdeskFilters = baseURLTwo + "pms/admin/complaints.json?";
  static String getAdminPendingHelpDeskdUrl =
      baseURLTwo + "pms/admin/complaints.json?";
  static String getHelpdeskComplaints = baseURLTwo + "/pms/complaints/";
  static String createComplaintLog = baseURLTwo + "complaint_logs.json?";
  static String createOsrLogs = baseURLTwo + "crm/create_osr_log.json?";
  static String getReopenComplaint = baseURLTwo + "complaint_log/reopen.json";
  static String getSpaceManagementFloorList =
      baseURLTwo + "pms/admin/seat_configurations/floors.json?building_id=";
  static String getHelpdeskBuildingsList =
      baseURLTwo + "pms/sites/buildings.json?";
  static String addHelpdeskComplain =
      baseURLTwo + "/pms/admin/complaints.json?";
  static String getHelpdeskWings = '${baseURLTwo}pms/buildings/';
  static String getHelpdeskFloors = '${baseURLTwo}pms/wings/';
  static String getHelpdeskAreaFloors = '${baseURLTwo}pms/areas/';
  static String getHelpdeskAreas = '${baseURLTwo}pms/wings/';
  static String getHelpdeskRooms = '${baseURLTwo}pms/floors/';

  //Space Management
  static String getSeatBookingListNew =
      baseURLTwo + "pms/seat_bookings.json?token=";
  static String getSpaceManagementBuildingsList =
      baseURLTwo + "pms/sites/buildings.json?&date=";
  static String getSpaceManagementFixedBookedAvailableCountsList = baseURLTwo +
      "pms/admin/seat_configurations/seat_configuration_details.json?";
  static String getSeatApprovalRequests = baseURLTwo +
      "pms/admin/seat_configurations/seat_approval_requests.json?token=";
  static String sendPunchInDetals =
      baseURLTwo + "pms/attendances/punch_in.json?";
  static String sendPunchOutDetals = baseURLTwo + "pms/attendances/";
  static String getSeatConfigurationsListNew =
      baseURLTwo + "pms/admin/seat_configurations.json?token=";
  static String postCreateApprovalRequest = baseURLTwo +
      "pms/admin/seat_configurations/create_approval_request.json?date=";
  static String getSeatConfigurationsSlotsNew =
      baseURLTwo + "pms/admin/seat_configurations/";
  static String postBookSeatNew = baseURLTwo + "pms/seat_bookings.json?token=";
  static String postWaitListSeat = baseURLTwo + "pms/seat_bookings.json?token=";
  static String postRescheduleSeatNew =
      baseURLTwo + "pms/seat_bookings.json?seat_booking_id=";
  static String getSeatBookingDetail = baseURLTwo + "pms/seat_bookings/";
  static String cancelSeatBooking = baseURLTwo + "pms/seat_bookings/";

  //Parking Management
  static String getParkingSeatBookingListNew =
      baseURLTen + "pms/parking_bookings.json?token=";
  static String getParkingManagementBuildingsList =
      baseURLTen + "pms/sites/buildings.json?&date=";
  static String getParkingManagementFloorList =
      baseURLTen + "pms/admin/parking_configurations/floors.json?building_id=";
  static String getParkingManagementFixedBookedAvailableCountsList = baseURLTen +
      "pms/admin/parking_configurations/parking_configuration_details.json?";
  static String getParkingSeatApprovalRequests = baseURLTen +
      "pms/admin/parking_configurations/parking_approval_requests.json?token=";
  static String sendParkingPunchInDetals =
      baseURLTen + "pms/attendances/punch_in.json?";
  static String sendParkingPunchOutDetals = baseURLTen + "pms/attendances/";
  static String getParkingSeatConfigurationsListNew =
      baseURLTen + "pms/admin/parking_configurations.json?token=";
  static String postParkingCreateApprovalRequest = baseURLTen +
      "pms/admin/parking_configurations/create_approval_request.json?date=";
  static String getParkingSeatConfigurationsSlotsNew =
      baseURLTen + "pms/admin/parking_configurations/";
  static String postParkingBookSeatNew =
      baseURLTen + "pms/parking_bookings.json?token=";
  static String postParkingWaitListSeat =
      baseURLTen + "pms/seat_bookings.json?token=";
  static String postParkingRescheduleSeatNew =
      baseURLTen + "pms/parking_bookings.json?parking_booking_id=";
  static String getParkingSeatBookingDetail =
      baseURLTen + "pms/parking_bookings/";
  static String cancelParkingSeatBooking = baseURLTen + "pms/parking_bookings/";
  static String parkingAutoCheckInOut =
      '${baseURLTen}pms/parking_bookings/check_in.json?token=';

  // Parking Bookings
  static String getParkingBookingBuildings =
      '${baseURLTen}pms/sites/buildings.json?&type=parking&date=';

  static String getParkingBookingCategories =
      '${baseURLTen}pms/admin/parking_configurations.json?';
  static String getParkingCategories =
      '${baseURLTen}pms/admin/parking_categories.json';

  static String getParkingBookingSchedules =
      '${baseURLTen}pms/admin/parking_configurations/';

  static String bookParkingBooking = '${baseURLTen}pms/parking_bookings.json?';

  static String bookParkingCancelBooking = '${baseURLTen}pms/parking_bookings/';

  //Notice (Comunication)
  static String getNoticesUrl = baseURLTwo + "pms/noticeboards.json?";
  static String getNoticeDetails = baseURLTwo + "pms/noticeboards/";

  //Bookings(Facility)
  static String getAvailableFacilities =
      '${baseURLTen}pms/admin/facility_setups/available_facilities.json?token=';

  static String getFacilitySetupUrl =
      baseURLTen + "pms/admin/facility_setups.json?token=";
  static String getFacilities =
      baseURLTen + "pms/facility_bookings.json?token=";
  static String getAdminFacilities =
      baseURLTen + "pms/admin/facility_bookings.json?token=";
  static String getFacilitySlots = baseURLTen + "pms/admin/facility_setups/";
  static String getBookFacility = baseURLTen + "pms/facility_bookings/";

  //Documents
  static String getMyAttachments =
      baseURLTwo + "pms/units/unit_related_attachments.json?";
  static String getPmsAttachments = baseURLTwo + "pms_common_attachments.json?";

  //Restaurant
  static String getRestaurantList =
      baseURLTwo + "pms/admin/restaurants.json?token=";
  static String getTableBookingsList =
      baseURLTwo + "pms/table_bookings.json?token=";
  static String getFoodOrderList = baseURLTwo + "pms/food_orders.json?token=";
  static String postTableBookings =
      baseURLTwo + "pms/table_bookings.json?token=";
  static String getFoodOrderWithID = baseURLTwo + "pms/food_orders/";
  static String postFoodOrder = baseURLTwo + "pms/food_orders.json?token=";

  //Inventories
  static String getInventoryList =
      baseURLTwo + "pms/inventories.json?q[inventory_type_eq]=2";
  static String getInventoryListByMonth = baseURLTwo +
      "pms/consumptions.json?q[resource_type_eq]=Pms::Inventory&q[resource_id_eq]=";
  static String getInventories = baseURLTwo + "pms/inventories/";
  static String postInventoryConsumption = baseURLTwo + "pms/consumptions.json";

  //Breakdown
  static String getBreakDownlist =
      baseURLTwo + "get_assets_for_breakdown.json?";
  static String getBreakownAsset = baseURLTwo + "pms/assets/";

  //Visitor
  static String getVisitorUrl1 = baseURLTwo + "pms/visitors.json?token=";
  static String updateGateKeeper1 = baseURLTwo + "pms/visitors/";
  static String getInOutCablist = baseURLTwo + "requested_vehicles.json?";
  static String getVisitorAllPurposes =
      baseURLTwo + "pms/visitors/visit_purposes.json?token=";
  static String addVisitor =
      baseURLTwo + "pms/visitors/create_expected_visitor.json?token=";
  static String getSupportStaffCategory =
      baseURLTwo + "pms/admin/support_staff_categories.json?";
  static String getServiceProviders =
      baseURLTwo + "delivery_service_providers.json?";
  static String createCabVisitor =
      baseURLTwo + "vehicle_inouts/create_expected_vehicle.json?";
  static String getVisitorDetails = baseURLTwo + 'gatekeepers/';
  static String setFavouriteVisitor = "${baseURLTwo}favourite_visitors.json?";
  static String deleteFavouriteVisior = "${baseURLTwo}favourite_visitors/";
  static String getFavouriteVisitor = "${baseURLTwo}favourite_visitors.json?";

  //Assets Stats

  static String getAllAdminTasks =
      baseURLTwo + "pms/asset_task_occurrences/all_admin_tasks.json?";
  static String getAssetStats = baseURLTwo + "pms/asset_task_occurrences/";
  static String getTaskList = baseURLTwo + "all_tasks_listing.json?";
  static String getTaskListById = baseURLTwo + "pms/asset_task_occurrences/";
  static String getPmsFilteredData =
      baseURLTwo + "pms/sites/filtered_data.json?token=";
  static String getPmsFilteredTasks =
      baseURLTwo + "pms/asset_task_occurrences/all_tasks.json?token=";
  static String getCheckListWebView =
      baseURLTwo + "pms/asset_task_occurrences/";
  static String putVerifyTask = baseURLTwo + "pms/asset_task_occurrences/";
  static String getOpenTaskList = baseURLTwo + "open_tasks_listing.json?";

  //Invoice
  static String getAdminInvoices =
      baseURLTwo + "pms/admin_invoices.json?token=";
  static String getAdminInvoiceReceipts =
      baseURLTwo + "pms/admin_invoice_receipts.json?token=";

  //Account Ledger
  static String getAccountLedger = baseURLTwo +
      "pms/admin/my_account_ledgers/users_account_ledgers.json?token=";

  //Market Place
  static String getServiceCategories =
      baseURLEight + 'ecommerce_services/categories.json?token=';
  static String getServiceList = baseURLEight + 'ecommerce_services.json?';
  static String getServiceSessionList = baseURLEight + 'ecommerce_services/';
  static String bookServiceSlot = baseURLEight + 'service_bookings.json?token=';
  static String getServiceBookings =
      baseURLEight + 'service_bookings.json?token=';
  static String getBookedService = baseURLEight + 'service_bookings/';

  //Fit Out
  static String getFitoutUrl = baseURLNine + "fitout_requests.json?token=";
  static String getFitoutIndividualUrl = baseURLNine + "fitout_requests/";
  static String fitoutCreateOsrLogs =
      baseURLTwo + "crm/create_osr_log.json?token=";
  static String fitoutCreateCategoryCommentLogs =
      baseURLNine + "fitout_requests/update_status.json?id=";
  static String getFitoutCategory =
      baseURLNine + "fitout_categories.json?token=";
  static String getModuleActiveStatus =
      baseURLTwo + "module_for_society.json?fee_for_id=";
  static String getFitoutUnits =
      baseURLTwo + 'pms/users/allowed_units.json?token=';

  //Events
  // static String getUpcominEvents = baseURLTwo + "upcoming_events_new.json?";
  // static String getPastEvents = baseURLTwo + "past_events_new.json?";
  static String getUpcominEvents =
      baseURLTwo + "pms/admin/events/upcoming_events.json?";
  static String getPastEvents =
      baseURLTwo + "pms/admin/events/past_events.json?";
  static String getAdminUpcomingEvent =
      baseURLTwo + "new_admin_upcoming_events.json?";
  static String getAdminPastEvents = baseURLTwo + "new_admin_past_events.json?";
  // static String getEventDetails = baseURLTwo + "new_event/";
  static String getEventDetails = baseURLTwo + "pms/admin/events/";
  static String goingInEventOrNot = baseURLTwo + "event_rsvps.json?";
  static String newEventLikeThings = baseURLTwo + "like_things.json?";
  static String newEventFeedback = baseURLTwo + "crm/create_osr_log.json?";
  static String getUserSociety = baseURLTwo + "minified_user_society.json?";
  static String getMyGroups = baseURLTwo + "usergroups.json?";
  static String addEventDetails = baseURLTwo + "events.json?";
  static String getImportantUpcominEvents =
      baseURLTwo + "crm/important_events.json?";

  // Mailroom
  static String getMailroomInboundList =
      baseURLTwo + 'pms/admin/mail_inbounds.json?token=';
  static String getMailroomInboundListItemDetails =
      baseURLTwo + 'pms/admin/mail_inbounds/';

  static String getMailroomOutboundList =
      baseURLTwo + '/pms/admin/mail_outbounds.json?';
  static String getMailroomOutboundListItemDetails =
      baseURLTwo + 'pms/admin/mail_outbounds/';

  static String getDelegateEmployeeList =
      '${baseURLTen}pms/admin/mail_inbounds/employee_list.json?';

  static String getInboundStateList =
      '${baseURLTwo}pms/admin/mail_inbounds/state_list.json?token=';
  static String getDeliveryVendorList =
      '${baseURLTwo}pms/admin/delivery_vendors.json?token=';
  static String postOutboundMail =
      '${baseURLTwo}pms/admin/mail_outbounds.json?token=';
  static String postDelegatePackage = '${baseURLTwo}pms/admin/mail_inbounds/';

  // Transport
  // Outstation
  static String getOutstationBookingsList =
      '${baseURLEight}pms/outstation_transportation_bookings.json?';
  static String getOutstationBookingDetails =
      '${baseURLEight}pms/outstation_transportation_bookings/';
  static String getVehicleSlabs =
      '${baseURLEight}pms/outstation_transportation_bookings/vehicle_slabs.json?';
  static String postOutstationRequest =
      '${baseURLEight}pms/outstation_transportation_bookings.json?';
  static String outstationStartTrip =
      '${baseURLEight}pms/outstation_transportation_bookings/';
  static String outstationVerifyOtp =
      '${baseURLEight}pms/outstation_transportation_bookings/';
  static String putOutstationEndTrip =
      '${baseURLEight}pms/outstation_transportation_bookings/';

  // Air
  static String getAirlineBookingsList =
      '${baseURLEight}pms/air_transportation_bookings.json?';
  static String getAirlineBookingDetails =
      '${baseURLEight}pms/air_transportation_bookings/';
  static String postAirlineRequest =
      '${baseURLEight}pms/air_transportation_bookings.json?';

  //Hotel
  static String getHotelBookingsList =
      '${baseURLEight}pms/hotel_transportation_bookings.json?';
  static String getHotelBookingDetails =
      '${baseURLEight}pms/hotel_transportation_bookings/';

  // Self Checkin
  static String getSelfCheckInBookingsList =
      '${baseURLEight}pms/self_transportation_bookings.json?';
  static String getSelfCheckInBookingDetails =
      '${baseURLEight}pms/self_transportation_bookings/';
  static String getSelfCheckInVehicleTypes =
      '${baseURLEight}pms/self_transportation_bookings/vehicle_types.json?';
  static String getRailwayBookingsList =
      '${baseURLEight}pms/rail_transportation_bookings.json?';
  static String getRailwayBookingDetails =
      '${baseURLEight}pms/rail_transportation_bookings/';
  static String postRailwayRequest =
      '${baseURLEight}pms/rail_transportation_bookings.json?';
  static String postSelfCheckInRequest =
      '${baseURLEight}pms/self_transportation_bookings.json?token=';
  static String putSelfCheckInStatus =
      '${baseURLEight}pms/self_transportation_bookings/';

  //Fitness
  static String postUserDailyGoals =
      '${baseURLEight}user_daily_goals.json?token=';
  static String getDailyGoalsCompanyLeaderBoard =
      '${baseURLEight}user_daily_goals/company_leaderboard.json?';
  static String getDailyGoalsDepartmentLeaderBoard =
      '${baseURLEight}user_daily_goals/department_leaderboard.json?';
  static String getDailyGoalsClusterLeaderBoard =
      '${baseURLEight}user_daily_goals/company_cluster_leaderboard.json?';
  static String patchUserDetails = '${baseURLEight}pms/users/';
  static String postUserMeasures = '${baseURLEight}user_measures.json';
  static String getUserMeasures = '${baseURLEight}user_measures/nil.json';
  static String getUserMarathonCumulativeSteps =
      '${baseURLEight}user_daily_goals/user_marathon_cumulative.json';
  static String getTop10DepartmentStats =
      '${baseURLEight}user_daily_goals/top_10_department_stats.json?';
  static String getTop10CircleStats =
      '${baseURLEight}user_daily_goals/top_10_circles.json?';
  static String getCircleWiseAchievers =
      '${baseURLEight}user_daily_goals/circle_wise_achievers.json?';
  static String getTop10UserInCircleStats =
      '${baseURLEight}user_daily_goals/top_10_users_in_circle.json?';

  //Task Management
  static String getTaskManagementList =
      '${baseURLEight}pms/admin/task_managements.json';
  static String getTaskManagementDetails =
      '${baseURLEight}pms/admin/task_managements/';
  static String putUpdateTaskStatus =
      '${baseURLEight}pms/admin/task_managements/';
  static String getFmUsers = '${baseURLEight}pms/fm_users.json?token=';
  static String postMultiTasks =
      '${baseURLEight}pms/admin/task_managements/create_multiple_task_management.json?token=';
  static String createTaskCommentNoteLog =
      '${baseURLEight}pms/admin/task_managements/create_osr_log.json';
  static String getCompanyTags = '${baseURLEight}company_tags.json?token=';
  static String postSubTask = '${baseURLEight}sub_tasks.json?token=';
  static String putSubTask = '${baseURLEight}sub_tasks/';

  //Audit
  static String getAuditScheduled =
      '${baseURLEight}pms/asset_tasks/audits_scheduled.json?token=';
  static String getAuditScheduledDetails = '${baseURLEight}pms/asset_tasks/';
  static String startAuditScheduled = '${baseURLEight}pms/asset_tasks/';
  static String closeAuditScheduled = '${baseURLEight}pms/asset_tasks/';
  static String getAuditConducted =
      '${baseURLEight}pms/asset_tasks/audits_conducted.json?token=';

  // Mom

  static String postMultiMom =
      '${baseURLEight}pms/admin/mom_details.json?token=';
  static String getMomDetailsList =
      '${baseURLEight}pms/admin/mom_details.json?token=';
  // static String postMultiMom = '${baseURLTwo}pms/admin/mom_details.json?token=';
  // static String getMomDetailsList =
  //     '${baseURLTwo}pms/admin/mom_details.json?token=';

  //Quick Call
  static String getPublicDirectory = "${baseURLTwo}public_directories.json?";
  static String quickCallIconListing = "${baseURLTwo}quick_call_icon_listing";
  static String updatePublicDirectory = "${baseURLTwo}public_directories/";
  static String addPublicDirectory = "${baseURLTwo}public_directories.json?";

  // - Face Detection -

  static String recognizeFace = '${baseURLTwo}recognize_face.json?token=';
  static String punchInUser = "${baseURLTwo}pms/attendances/punch_in.json";

  // - End -
}
