// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seat_booking_attendance.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SeatBookingAttendanceAdapter extends TypeAdapter<SeatBookingAttendance> {
  @override
  final int typeId = 4;

  @override
  SeatBookingAttendance read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SeatBookingAttendance(
      id: fields[0] as int?,
      punchedInAt: fields[1] as String?,
      punchedOutAt: fields[2] as String?,
      seatBookingSlotId: fields[3] as int?,
      showSchedule: (fields[4] as List?)?.cast<ShowSchedule>(),
    );
  }

  @override
  void write(BinaryWriter writer, SeatBookingAttendance obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.punchedInAt)
      ..writeByte(2)
      ..write(obj.punchedOutAt)
      ..writeByte(3)
      ..write(obj.seatBookingSlotId)
      ..writeByte(4)
      ..write(obj.showSchedule);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SeatBookingAttendanceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeatBookingAttendance _$SeatBookingAttendanceFromJson(
        Map<String, dynamic> json) =>
    SeatBookingAttendance(
      id: (json['id'] as num?)?.toInt(),
      punchedInAt: json['punched_in_at'] as String?,
      punchedOutAt: json['punched_out_at'] as String?,
      seatBookingSlotId: (json['seat_booking_slot_id'] as num?)?.toInt(),
      showSchedule: (json['show_schedule'] as List<dynamic>?)
          ?.map((e) => ShowSchedule.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SeatBookingAttendanceToJson(
        SeatBookingAttendance instance) =>
    <String, dynamic>{
      'id': instance.id,
      'punched_in_at': instance.punchedInAt,
      'punched_out_at': instance.punchedOutAt,
      'seat_booking_slot_id': instance.seatBookingSlotId,
      'show_schedule': instance.showSchedule,
    };
