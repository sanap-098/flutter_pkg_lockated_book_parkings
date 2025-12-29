// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parking_number_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ParkingNumberModelAdapter extends TypeAdapter<ParkingNumberModel> {
  @override
  final int typeId = 13;

  @override
  ParkingNumberModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ParkingNumberModel(
      id: fields[0] as int?,
      name: fields[1] as String?,
      active: fields[2] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, ParkingNumberModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.active);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ParkingNumberModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParkingNumberModel _$ParkingNumberModelFromJson(Map<String, dynamic> json) =>
    ParkingNumberModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      active: json['active'] as bool?,
      isSelected: json['isSelected'] as bool? ?? false,
    );

Map<String, dynamic> _$ParkingNumberModelToJson(ParkingNumberModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'active': instance.active,
      'isSelected': instance.isSelected,
    };
