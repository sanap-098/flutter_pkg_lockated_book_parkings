// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parking_booking_book_parking_show_schedule_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParkingBookingBookParkingShowScheduleModel
    _$ParkingBookingBookParkingShowScheduleModelFromJson(
            Map<String, dynamic> json) =>
        ParkingBookingBookParkingShowScheduleModel(
          slotId: (json['slot_id'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList(),
          slot: json['slot'] as String?,
          parkingNumber: json['parking_number'] as String?,
        );

Map<String, dynamic> _$ParkingBookingBookParkingShowScheduleModelToJson(
        ParkingBookingBookParkingShowScheduleModel instance) =>
    <String, dynamic>{
      'slot_id': instance.slotId,
      'slot': instance.slot,
      'parking_number': instance.parkingNumber,
    };
