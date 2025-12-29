// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'show_schedule.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ShowScheduleAdapter extends TypeAdapter<ShowSchedule> {
  @override
  final int typeId = 5;

  @override
  ShowSchedule read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ShowSchedule(
      id: fields[0] as int?,
      slotId: fields[1] as int?,
      slot: fields[2] as String?,
      seat: fields[3] as String?,
      slotStatus: fields[4] as String?,
      slotCancelledAt: fields[5] as String?,
      isChecked: fields[6] as bool,
      parkingNumber: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ShowSchedule obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.slotId)
      ..writeByte(2)
      ..write(obj.slot)
      ..writeByte(3)
      ..write(obj.seat)
      ..writeByte(4)
      ..write(obj.slotStatus)
      ..writeByte(5)
      ..write(obj.slotCancelledAt)
      ..writeByte(6)
      ..write(obj.isChecked)
      ..writeByte(7)
      ..write(obj.parkingNumber);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShowScheduleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShowSchedule _$ShowScheduleFromJson(Map<String, dynamic> json) => ShowSchedule(
      id: (json['id'] as num?)?.toInt(),
      slotId: (json['slot_id'] as num?)?.toInt(),
      slot: json['slot'] as String?,
      seat: json['seat'] as String?,
      slotStatus: json['slot_status'] as String?,
      slotCancelledAt: json['slot_cancelled_at'] as String?,
      isChecked: json['isChecked'] as bool? ?? false,
      parkingNumber: json['parking_number'] as String?,
    );

Map<String, dynamic> _$ShowScheduleToJson(ShowSchedule instance) =>
    <String, dynamic>{
      'id': instance.id,
      'slot_id': instance.slotId,
      'slot': instance.slot,
      'seat': instance.seat,
      'slot_status': instance.slotStatus,
      'slot_cancelled_at': instance.slotCancelledAt,
      'isChecked': instance.isChecked,
      'parking_number': instance.parkingNumber,
    };
