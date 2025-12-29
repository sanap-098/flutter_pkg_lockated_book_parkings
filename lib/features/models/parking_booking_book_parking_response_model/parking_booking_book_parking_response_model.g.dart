// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parking_booking_book_parking_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParkingBookingBookParkingResponseModel
    _$ParkingBookingBookParkingResponseModelFromJson(
            Map<String, dynamic> json) =>
        ParkingBookingBookParkingResponseModel(
          id: (json['id'] as num?)?.toInt(),
          resourceId: (json['resource_id'] as num?)?.toInt(),
          resourceType: json['resource_type'] as String?,
          userId: (json['user_id'] as num?)?.toInt(),
          parkingConfigurationId:
              (json['parking_configuration_id'] as num?)?.toInt(),
          bookingDate: json['booking_date'] as String?,
          status: json['status'] as String?,
          cancelledById: json['cancelled_by_id'],
          cancelledAt: json['cancelled_at'],
          createdAt: json['created_at'] as String?,
          buildingName: json['building_name'] as String?,
          floorName: json['floor_name'] as String?,
          floorId: (json['floor_id'] as num?)?.toInt(),
          buildingId: (json['building_id'] as num?)?.toInt(),
          floorPlanAttachment: json['floor_plan_attachment'] as String?,
          currentStatus: json['current_status'] as String?,
          placedBy: json['placed_by'] as String?,
          cancelBy: json['cancel_by'],
          parkingImageUrl: json['parking_image_url'] as String?,
          categoryName: json['category_name'] as String?,
          showSchedule: json['show_schedule'] == null
              ? null
              : ParkingBookingBookParkingShowScheduleModel.fromJson(
                  json['show_schedule'] as Map<String, dynamic>),
          qrCodeUrl: json['qr_code_url'] as String?,
        );

Map<String, dynamic> _$ParkingBookingBookParkingResponseModelToJson(
        ParkingBookingBookParkingResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'resource_id': instance.resourceId,
      'resource_type': instance.resourceType,
      'user_id': instance.userId,
      'parking_configuration_id': instance.parkingConfigurationId,
      'booking_date': instance.bookingDate,
      'status': instance.status,
      'cancelled_by_id': instance.cancelledById,
      'cancelled_at': instance.cancelledAt,
      'created_at': instance.createdAt,
      'building_name': instance.buildingName,
      'floor_name': instance.floorName,
      'floor_id': instance.floorId,
      'building_id': instance.buildingId,
      'floor_plan_attachment': instance.floorPlanAttachment,
      'current_status': instance.currentStatus,
      'placed_by': instance.placedBy,
      'cancel_by': instance.cancelBy,
      'parking_image_url': instance.parkingImageUrl,
      'category_name': instance.categoryName,
      'show_schedule': instance.showSchedule,
      'qr_code_url': instance.qrCodeUrl,
    };
