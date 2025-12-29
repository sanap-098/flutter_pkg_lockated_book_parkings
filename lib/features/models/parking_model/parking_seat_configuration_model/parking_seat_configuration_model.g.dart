// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parking_seat_configuration_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ParkingSeatConfigurationModelAdapter
    extends TypeAdapter<ParkingSeatConfigurationModel> {
  @override
  final int typeId = 10;

  @override
  ParkingSeatConfigurationModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ParkingSeatConfigurationModel(
      id: fields[0] as int?,
      buildingId: fields[1] as int?,
      floorId: fields[2] as int?,
      parkingCategory: fields[3] as String?,
      totalParkings: fields[4] as int?,
      availableParkings: fields[5] as int?,
      bookedParkings: fields[6] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, ParkingSeatConfigurationModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.buildingId)
      ..writeByte(2)
      ..write(obj.floorId)
      ..writeByte(3)
      ..write(obj.parkingCategory)
      ..writeByte(4)
      ..write(obj.totalParkings)
      ..writeByte(5)
      ..write(obj.availableParkings)
      ..writeByte(6)
      ..write(obj.bookedParkings);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ParkingSeatConfigurationModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParkingSeatConfigurationModel _$ParkingSeatConfigurationModelFromJson(
        Map<String, dynamic> json) =>
    ParkingSeatConfigurationModel(
      id: (json['id'] as num?)?.toInt(),
      buildingId: (json['building_id'] as num?)?.toInt(),
      floorId: (json['floor_id'] as num?)?.toInt(),
      parkingCategory: json['parking_category'] as String?,
      totalParkings: (json['total_parkings'] as num?)?.toInt(),
      availableParkings: (json['available_parkings'] as num?)?.toInt(),
      bookedParkings: (json['booked_parkings'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ParkingSeatConfigurationModelToJson(
        ParkingSeatConfigurationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'building_id': instance.buildingId,
      'floor_id': instance.floorId,
      'parking_category': instance.parkingCategory,
      'total_parkings': instance.totalParkings,
      'available_parkings': instance.availableParkings,
      'booked_parkings': instance.bookedParkings,
    };
