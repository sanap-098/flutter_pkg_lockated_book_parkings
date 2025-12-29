// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parking_slot_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParkingSlotModel _$ParkingSlotModelFromJson(Map<String, dynamic> json) =>
    ParkingSlotModel(
      id: (json['id'] as num?)?.toInt(),
      startHour: (json['start_hour'] as num?)?.toInt(),
      startMin: (json['start_min'] as num?)?.toInt(),
      endHour: (json['end_hour'] as num?)?.toInt(),
      endMin: (json['end_min'] as num?)?.toInt(),
      parkingNumbers: (json['parking_numbers'] as List<dynamic>?)
          ?.map((e) => ParkingNumberModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      bookedParkingNumbers: (json['booked_parking_numbers'] as List<dynamic>?)
          ?.map((e) => ParkingNumberModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      amPm: json['ampm'] as String?,
      isSelected: json['isSelected'] as bool? ?? false,
      isSelectedBeforeBooking:
          json['isSelectedBeforeBooking'] as bool? ?? false,
    );

Map<String, dynamic> _$ParkingSlotModelToJson(ParkingSlotModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'start_hour': instance.startHour,
      'start_min': instance.startMin,
      'end_hour': instance.endHour,
      'end_min': instance.endMin,
      'parking_numbers': instance.parkingNumbers,
      'booked_parking_numbers': instance.bookedParkingNumbers,
      'ampm': instance.amPm,
      'isSelected': instance.isSelected,
      'isSelectedBeforeBooking': instance.isSelectedBeforeBooking,
    };
