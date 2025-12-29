// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seat_booking.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SeatBookingAdapter extends TypeAdapter<SeatBooking> {
  @override
  final int typeId = 3;

  @override
  SeatBooking read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SeatBooking(
      id: fields[0] as int?,
      resourceId: fields[1] as int?,
      resourceType: fields[2] as String?,
      userId: fields[3] as int?,
      seatConfigurationId: fields[4] as int?,
      bookingDate: fields[5] as String?,
      status: fields[6] as String?,
      cancelledById: fields[7] as int?,
      cancelledAt: fields[8] as String?,
      createdAt: fields[9] as String?,
      buildingName: fields[10] as String?,
      wingName: fields[11] as String?,
      areaName: fields[12] as String?,
      floorName: fields[13] as String?,
      attendance: (fields[14] as List?)?.cast<SeatBookingAttendance>(),
      floorId: fields[15] as int?,
      buildingId: fields[16] as int?,
      wingId: fields[17] as int?,
      areaId: fields[18] as int?,
      floorPlanAttachment: fields[19] as String?,
      currentStatus: fields[20] as String?,
      placedBy: fields[21] as String?,
      cancelBy: fields[22] as String?,
      seatImageUrl: fields[23] as String?,
      categoryName: fields[24] as String?,
      showSchedule: (fields[25] as List?)?.cast<ShowSchedule>(),
      canCancel: fields[26] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, SeatBooking obj) {
    writer
      ..writeByte(27)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.resourceId)
      ..writeByte(2)
      ..write(obj.resourceType)
      ..writeByte(3)
      ..write(obj.userId)
      ..writeByte(4)
      ..write(obj.seatConfigurationId)
      ..writeByte(5)
      ..write(obj.bookingDate)
      ..writeByte(6)
      ..write(obj.status)
      ..writeByte(7)
      ..write(obj.cancelledById)
      ..writeByte(8)
      ..write(obj.cancelledAt)
      ..writeByte(9)
      ..write(obj.createdAt)
      ..writeByte(10)
      ..write(obj.buildingName)
      ..writeByte(11)
      ..write(obj.wingName)
      ..writeByte(12)
      ..write(obj.areaName)
      ..writeByte(13)
      ..write(obj.floorName)
      ..writeByte(14)
      ..write(obj.attendance)
      ..writeByte(15)
      ..write(obj.floorId)
      ..writeByte(16)
      ..write(obj.buildingId)
      ..writeByte(17)
      ..write(obj.wingId)
      ..writeByte(18)
      ..write(obj.areaId)
      ..writeByte(19)
      ..write(obj.floorPlanAttachment)
      ..writeByte(20)
      ..write(obj.currentStatus)
      ..writeByte(21)
      ..write(obj.placedBy)
      ..writeByte(22)
      ..write(obj.cancelBy)
      ..writeByte(23)
      ..write(obj.seatImageUrl)
      ..writeByte(24)
      ..write(obj.categoryName)
      ..writeByte(25)
      ..write(obj.showSchedule)
      ..writeByte(26)
      ..write(obj.canCancel);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SeatBookingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeatBooking _$SeatBookingFromJson(Map<String, dynamic> json) => SeatBooking(
      id: (json['id'] as num?)?.toInt(),
      resourceId: (json['resource_id'] as num?)?.toInt(),
      resourceType: json['resource_type'] as String?,
      userId: (json['user_id'] as num?)?.toInt(),
      seatConfigurationId: (json['seat_configuration_id'] as num?)?.toInt(),
      bookingDate: json['booking_date'] as String?,
      status: json['status'] as String?,
      cancelledById: (json['cancelled_by_id'] as num?)?.toInt(),
      cancelledAt: json['cancelled_at'] as String?,
      createdAt: json['created_at'] as String?,
      buildingName: json['building_name'] as String?,
      wingName: json['wing_name'] as String?,
      areaName: json['area_name'] as String?,
      floorName: json['floor_name'] as String?,
      attendance: (json['attendance'] as List<dynamic>?)
          ?.map(
              (e) => SeatBookingAttendance.fromJson(e as Map<String, dynamic>))
          .toList(),
      floorId: (json['floor_id'] as num?)?.toInt(),
      buildingId: (json['building_id'] as num?)?.toInt(),
      wingId: (json['wing_id'] as num?)?.toInt(),
      areaId: (json['area_id'] as num?)?.toInt(),
      floorPlanAttachment: json['floor_plan_attachment'] as String?,
      currentStatus: json['current_status'] as String?,
      placedBy: json['placed_by'] as String?,
      cancelBy: json['cancel_by'] as String?,
      seatImageUrl: json['seat_image_url'] as String?,
      categoryName: json['category_name'] as String?,
      showSchedule: (json['show_schedule'] as List<dynamic>?)
          ?.map((e) => ShowSchedule.fromJson(e as Map<String, dynamic>))
          .toList(),
      canCancel: json['can_cancel'] as bool?,
    );

Map<String, dynamic> _$SeatBookingToJson(SeatBooking instance) =>
    <String, dynamic>{
      'id': instance.id,
      'resource_id': instance.resourceId,
      'resource_type': instance.resourceType,
      'user_id': instance.userId,
      'seat_configuration_id': instance.seatConfigurationId,
      'booking_date': instance.bookingDate,
      'status': instance.status,
      'cancelled_by_id': instance.cancelledById,
      'cancelled_at': instance.cancelledAt,
      'created_at': instance.createdAt,
      'building_name': instance.buildingName,
      'wing_name': instance.wingName,
      'area_name': instance.areaName,
      'floor_name': instance.floorName,
      'attendance': instance.attendance,
      'floor_id': instance.floorId,
      'building_id': instance.buildingId,
      'wing_id': instance.wingId,
      'area_id': instance.areaId,
      'floor_plan_attachment': instance.floorPlanAttachment,
      'current_status': instance.currentStatus,
      'placed_by': instance.placedBy,
      'cancel_by': instance.cancelBy,
      'seat_image_url': instance.seatImageUrl,
      'category_name': instance.categoryName,
      'show_schedule': instance.showSchedule,
      'can_cancel': instance.canCancel,
    };
