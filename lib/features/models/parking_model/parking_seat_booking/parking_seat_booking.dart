
import 'package:flutter_pkg_lockated_book_parking/features/models/seat_booking_attendance/seat_booking_attendance.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/show_schedule/show_schedule.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'parking_seat_booking.g.dart';



@HiveType(typeId: 14)
@JsonSerializable()
class ParkingSeatBooking {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  @JsonKey(name: 'resource_id')
  final int? resourceId;
  @HiveField(2)
  @JsonKey(name: 'resource_type')
  final String? resourceType;
  @HiveField(3)
  @JsonKey(name: 'user_id')
  final int? userId;
  @HiveField(4)
  @JsonKey(name: 'parking_configuration_id')
  int? parkingConfigurationId;
  @HiveField(5)
  @JsonKey(name: 'booking_date')
  String? bookingDate;
  @HiveField(6)
  @JsonKey(name: 'status')
  final String? status;
  @HiveField(7)
  @JsonKey(name: 'cancelled_by_id')
  final int? cancelledById;
  @HiveField(8)
  @JsonKey(name: 'cancelled_at')
  final String? cancelledAt;
  @HiveField(9)
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @HiveField(10)
  @JsonKey(name: 'building_name')
  String? buildingName;
  @HiveField(11)
  @JsonKey(name: 'wing_name')
  final String? wingName;
  @HiveField(12)
  @JsonKey(name: 'area_name')
  final String? areaName;
  @HiveField(13)
  @JsonKey(name: 'floor_name')
  String? floorName;
  @HiveField(14)
  final List<SeatBookingAttendance>? attendance;
  @HiveField(15)
  @JsonKey(name: 'floor_id')
  int? floorId;
  @HiveField(16)
  @JsonKey(name: 'building_id')
  int? buildingId;
  @HiveField(17)
  @JsonKey(name: 'wing_id')
  final int? wingId;
  @HiveField(18)
  @JsonKey(name: 'area_id')
  final int? areaId;
  @HiveField(19)
  @JsonKey(name: 'floor_plan_attachment')
  final String? floorPlanAttachment;
  @HiveField(20)
  @JsonKey(name: 'current_status')
  final String? currentStatus;
  @HiveField(21)
  @JsonKey(name: 'placed_by')
  final String? placedBy;
  @HiveField(22)
  @JsonKey(name: 'cancel_by')
  final String? cancelBy;
  @HiveField(23)
  @JsonKey(name: 'parking_image_url')
  final String? parkingImageUrl;
  @HiveField(24)
  @JsonKey(name: 'category_name')
  String? categoryName;
  @HiveField(25)
  @JsonKey(name: 'show_schedule')
  final ShowSchedule? showSchedule;
  @HiveField(26)
  @JsonKey(name: 'can_cancel')
  final bool? canCancel;
  @JsonKey(name: 'qr_code_url')
  final String? qrCodeUrl;

  ParkingSeatBooking({
    this.id,
    this.resourceId,
    this.resourceType,
    this.userId,
    this.parkingConfigurationId,
    this.bookingDate,
    this.status,
    this.cancelledById,
    this.cancelledAt,
    this.createdAt,
    this.buildingName,
    this.wingName,
    this.areaName,
    this.floorName,
    this.attendance,
    this.floorId,
    this.buildingId,
    this.wingId,
    this.areaId,
    this.floorPlanAttachment,
    this.currentStatus,
    this.placedBy,
    this.cancelBy,
    this.parkingImageUrl,
    this.categoryName,
    this.showSchedule,
    this.canCancel,
    this.qrCodeUrl,
  });

  factory ParkingSeatBooking.fromJson(Map<String, dynamic> json) =>
      _$ParkingSeatBookingFromJson(json);

  Map<String, dynamic> toJson() => _$ParkingSeatBookingToJson(this);
}
