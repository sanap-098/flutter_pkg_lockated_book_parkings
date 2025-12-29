// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parking_booking_schedules_slot_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParkingBookingSchedulesSlotModel _$ParkingBookingSchedulesSlotModelFromJson(
        Map<String, dynamic> json) =>
    ParkingBookingSchedulesSlotModel(
      id: (json['id'] as num?)?.toInt(),
      startHour: (json['start_hour'] as num?)?.toInt(),
      startMin: (json['start_min'] as num?)?.toInt(),
      endHour: (json['end_hour'] as num?)?.toInt(),
      endMin: (json['end_min'] as num?)?.toInt(),
      ampm: json['ampm'] as String?,
      isSelected: json['isSelected'] as bool? ?? false,
    );

Map<String, dynamic> _$ParkingBookingSchedulesSlotModelToJson(
        ParkingBookingSchedulesSlotModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'start_hour': instance.startHour,
      'start_min': instance.startMin,
      'end_hour': instance.endHour,
      'end_min': instance.endMin,
      'ampm': instance.ampm,
      'isSelected': instance.isSelected,
    };
