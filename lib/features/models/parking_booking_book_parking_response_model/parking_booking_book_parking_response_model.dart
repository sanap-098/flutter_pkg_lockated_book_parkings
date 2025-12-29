import 'package:json_annotation/json_annotation.dart';

import '../parking_booking_book_parking_show_schedule_model/parking_booking_book_parking_show_schedule_model.dart';

part 'parking_booking_book_parking_response_model.g.dart';

@JsonSerializable()
class ParkingBookingBookParkingResponseModel {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'resource_id')
  final int? resourceId;
  @JsonKey(name: 'resource_type')
  final String? resourceType;
  @JsonKey(name: 'user_id')
  final int? userId;
  @JsonKey(name: 'parking_configuration_id')
  final int? parkingConfigurationId;
  @JsonKey(name: 'booking_date')
  final String? bookingDate;
  @JsonKey(name: 'status')
  final String? status;
  @JsonKey(name: 'cancelled_by_id')
  final dynamic cancelledById;
  @JsonKey(name: 'cancelled_at')
  final dynamic cancelledAt;
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @JsonKey(name: 'building_name')
  final String? buildingName;
  @JsonKey(name: 'floor_name')
  final String? floorName;
  @JsonKey(name: 'floor_id')
  final int? floorId;
  @JsonKey(name: 'building_id')
  final int? buildingId;
  @JsonKey(name: 'floor_plan_attachment')
  final String? floorPlanAttachment;
  @JsonKey(name: 'current_status')
  final String? currentStatus;
  @JsonKey(name: 'placed_by')
  final String? placedBy;
  @JsonKey(name: 'cancel_by')
  final dynamic cancelBy;
  @JsonKey(name: 'parking_image_url')
  final String? parkingImageUrl;
  @JsonKey(name: 'category_name')
  final String? categoryName;
  @JsonKey(name: 'show_schedule')
  final ParkingBookingBookParkingShowScheduleModel? showSchedule;
  @JsonKey(name: 'qr_code_url')
  final String? qrCodeUrl;

  ParkingBookingBookParkingResponseModel({
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
    this.floorName,
    this.floorId,
    this.buildingId,
    this.floorPlanAttachment,
    this.currentStatus,
    this.placedBy,
    this.cancelBy,
    this.parkingImageUrl,
    this.categoryName,
    this.showSchedule,
    this.qrCodeUrl,
  });

  factory ParkingBookingBookParkingResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ParkingBookingBookParkingResponseModelFromJson(json);

  Map<String, dynamic> toJosn() => _$ParkingBookingBookParkingResponseModelToJson(this);
}
