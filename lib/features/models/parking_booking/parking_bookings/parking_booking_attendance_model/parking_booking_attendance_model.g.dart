// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parking_booking_attendance_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParkingBookingAttendanceModel _$ParkingBookingAttendanceModelFromJson(
        Map<String, dynamic> json) =>
    ParkingBookingAttendanceModel(
      id: (json['id'] as num?)?.toInt(),
      punchedInAt: json['punched_in_at'] as String?,
      punchedOutAt: json['punched_out_at'] as String?,
      parkingBookingId: (json['parking_booking_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ParkingBookingAttendanceModelToJson(
        ParkingBookingAttendanceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'punched_in_at': instance.punchedInAt,
      'punched_out_at': instance.punchedOutAt,
      'parking_booking_id': instance.parkingBookingId,
    };
