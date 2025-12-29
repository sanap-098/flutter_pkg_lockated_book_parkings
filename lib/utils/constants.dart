import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

const List<Permission> permissions = [
  Permission.location,
  Permission.camera,
  Permission.contacts,
  Permission.storage,
  Permission.microphone,
];



const primaryColor = "#E95420";
const accent = '#DCDCDC';
const secondaryColor = '#77216F';
const selection = '#E2B939';
const submit = '#01C875';
const closed = '#449D44';

const secondaryTextColor = '#959595';
const textPunchColor = '#b3b3b5';
const buttonDisableColor = '#66E5E4E7';

const primaryTextTrans = '#90212121';

const ticketTabColor = '#E95420';

const spaceManagementOrangeColor = '#F07857';

const String appBlue = '#3BAFDA';
const String green = '#008000';
const String footerColor = '#3dc2b1';
const String passPlaceholder = '#c6260c';
const String clearAll = '#52c19e';
const String editIcon = '#fa9223';

const String lightGreenStatusColor = '#C4E9C0';
const String lightRedStatusColor = '#FFB1B1';
const String lightYellowStatusColor = '#f4e113';
const String newUiPrimaryBlue = '#0073EA';

const String newUiLightGreenColor = '#01c875';
const String newUiDarkGreenColor = '#007946';
const String newUiLightGreenPartiallyApprovedColor = '#01c875';
const String newUiLightYellowColor = '#fdab3d';
const String newUiLightRedColor = '#e2445b';

const String foodOrderScreenMenuScreenProceedContainerBgColor = '#F8F8F8';

const String taskScheduled = "#605ca8";
const String taskOpen = "#00C0EF";
const String taskInProgress = "#EC971F";
const String taskClosed = "#449D44";
const String taskOverdue = "#DC4B39";
const String taskPartiallyClosed = "#00a65a";

const String headerTitleCardBgColor = '#F6EFF4';
const String textGreyColor = '#9F9F9F';
const String texfieldBorderColor = '#ECECEC';

//Helpdeak Details Constants
Color helpdeskDetailborderColor = Colors.grey[400]!;

//Ticket Constants
String createComplaintSelectionColor = '#F69380';

//Space Management
// String spaceManagementOrangeColor = '#F07857';
String spaceManagementBlueDateColor = '#E2F0FA';
String spaceManagementRescheduleButtonColor = '#AAC8DF';
String spaceManagementCheckinButtonColor = '#C4E9C0';
String spaceManagementCheckoutButtonColor = '#FFB1B1';
String spaceManagementMainButtonColor = '#5B78AF';

String spaceManagementAvailableColor = '#5B78AF';
String spaceManagementTotalColor = '#4E4E4E';

String calendarBlue = '#E2F0FA';
String seatBookingBorder = '#BCC2C7';

String spaceManagementBuildingTowerFillColor = '#fff8ec';

//Space Management BookSpaceDateAndSlot
String bookSpaceDateAndSlotsNewUiFieldbgColor = '#F3F3F3';
String bookSpaceBottomSheetTopBGColor = '#7F7F7F';

//F&B
String fooOrderScreenGreyTextColor = '#949494';
String foodOrderProceedColor = '#AF0C22';
String foodOrderScreenPinkColor = '#FFB1B1';
String foodOrderScreenBlueColor = '#6D86B7';

//Inventory
String inventoryBack = '#60E3E3E3';

//Profile
String newAccountsUiPersonalInfoBgColor = '#FBC7CF';
String newAccountsUiPersonalInfoHighlightedTextColor = '#000000';
String newAccountsUiPersonalInfoUnhighlightedTextColor = '#535251';
String newAccountsUiPersonalInfoPhotoBgColor = '#5B78AF';
String newAccountsUiPersonalInfoSignOutButtonColor = '#5B78AF';

//Temperature
String temperatureDialogValuesGrayColor = '#F1F1F1';
String fragmentTemperatureValuesLastRecordedTemperatureColor = '#114714';

//MarketPlace
String marketPlaceGreenColor = '#50BD9A';

//Coupons
String couponRedColor = '#FF4A4A';

//Toast Constants
String somethingWentWrong = 'Something went wrong, please try again later!';

String rupeeSymbol = '\u20B9';

// - Assets String -

class AssetsStrings {
  static String chatOrange16 = 'assets/home/chat_orange_16.png';
  static String searchOrange16 = 'assets/home/search_orange_16.png';
}

// - End -

//Notifications
enum NotiAppState {
  terminatedState,
  backgroundState,
  foregroundState,
}

// Splash
enum SplashComingFrom { splash, sso, login, welcome }

//Home Search
enum HomeViewSearchItems {
  createTicket,
  createVisitor,
  bookFacility,
  bookService,
  orderFood,
  bookTable,
  bookSeat,
  bookParking,
  createOutboundMail,
  createNotice,
  breakdown,
  inventory,
  payments,
  wellness,
  fitout,
  documents,
  events,
  mailroom
}

enum SpaceManagementButtonType {
  reschedule,
  checkIn,
  checkOut,
  cancel,
}

enum TicketFilterTypes {
  ticketType,
  dateType,
  categoryType,
  subCategoryType,
  pmsUsertype,
  statusType,
  unitType,
  departmentType,
  priorityType,
}

enum FacilityPaymentMode {
  payOnline,
  payOnFacility,
  postPaid,
}

enum ResponseRedirectActivityFrom {
  bookTable,
  foodOrder,
}

enum InventoryDialogAddConsume {
  add,
  consume,
}

enum DailyTaskCallApiEnum {
  getAllOpenTask,
  callAdminApi,
  getTaskList,
  callGetPmsFilteredDataApi,
}

enum DailyTaskFromEnum {
  fromHomeAdmin,
  fromHomeScan,
}

enum DailyTaskFilterTypes {
  scheduleType,
  taskOfType,
  statusType,
  buildingType,
  wingType,
  areaType,
  floorType,
  roomType,
}

enum DailyTaskListRoute {
  admin,
  user,
}

enum FitoutPaymentMode {
  payOnSite,
}

//Events
enum EventDetailsComingFrom {
  upcoming,
  past,
  details,
}

enum EventAreYouGoingSelection {
  yes,
  no,
  maybe,
}

enum CreateEventShareWith {
  all,
  group,
  individual,
}

enum EventComingFrom {
  home,
  admin,
}

enum FitnessHeightWeightDetailsComingFrom {
  home,
  profile,
}

// - Task -
enum TaskCreationResponsiblePerson {
  internal,
  external,
}

enum TaskCreationComingFrom {
  create,
  details,
}

//Quick Call
enum CreateQuickCallComingFor {
  add,
  update,
}

enum DIrectoryComingFrom {
  home,
  admin,
}

// home
enum HomeEventsComingFrom {
  home,
  revampedHome,
}
