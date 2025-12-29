// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seat_configuration_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SeatConfigurationModelAdapter
    extends TypeAdapter<SeatConfigurationModel> {
  @override
  final int typeId = 7;

  @override
  SeatConfigurationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SeatConfigurationModel(
      id: fields[0] as int?,
      buildingId: fields[1] as int?,
      wingId: fields[2] as int?,
      areaId: fields[3] as int?,
      floorId: fields[4] as int?,
      seatCategory: fields[5] as String?,
      totalSeats: fields[6] as int?,
      availableSeats: fields[7] as int?,
      bookedSeats: fields[8] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, SeatConfigurationModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.buildingId)
      ..writeByte(2)
      ..write(obj.wingId)
      ..writeByte(3)
      ..write(obj.areaId)
      ..writeByte(4)
      ..write(obj.floorId)
      ..writeByte(5)
      ..write(obj.seatCategory)
      ..writeByte(6)
      ..write(obj.totalSeats)
      ..writeByte(7)
      ..write(obj.availableSeats)
      ..writeByte(8)
      ..write(obj.bookedSeats);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SeatConfigurationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeatConfigurationModel _$SeatConfigurationModelFromJson(
        Map<String, dynamic> json) =>
    SeatConfigurationModel(
      id: (json['id'] as num?)?.toInt(),
      buildingId: (json['building_id'] as num?)?.toInt(),
      wingId: (json['wing_id'] as num?)?.toInt(),
      areaId: (json['area_id'] as num?)?.toInt(),
      floorId: (json['floor_id'] as num?)?.toInt(),
      seatCategory: json['seat_category'] as String?,
      totalSeats: (json['total_seats'] as num?)?.toInt(),
      availableSeats: (json['available_seats'] as num?)?.toInt(),
      bookedSeats: (json['booked_seats'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SeatConfigurationModelToJson(
        SeatConfigurationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'building_id': instance.buildingId,
      'wing_id': instance.wingId,
      'area_id': instance.areaId,
      'floor_id': instance.floorId,
      'seat_category': instance.seatCategory,
      'total_seats': instance.totalSeats,
      'available_seats': instance.availableSeats,
      'booked_seats': instance.bookedSeats,
    };
