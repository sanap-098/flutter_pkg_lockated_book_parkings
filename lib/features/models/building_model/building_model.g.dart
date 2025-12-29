// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'building_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BuildingModelAdapter extends TypeAdapter<BuildingModel> {
  @override
  final int typeId = 1;

  @override
  BuildingModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BuildingModel(
      id: fields[0] as int?,
      name: fields[1] as String?,
      hasWing: fields[2] as bool?,
      hasFloor: fields[3] as bool?,
      hasArea: fields[4] as bool?,
      hasRoom: fields[5] as bool?,
      availableSeats: fields[6] as dynamic,
      isChecked: fields[7] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, BuildingModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.hasWing)
      ..writeByte(3)
      ..write(obj.hasFloor)
      ..writeByte(4)
      ..write(obj.hasArea)
      ..writeByte(5)
      ..write(obj.hasRoom)
      ..writeByte(6)
      ..write(obj.availableSeats)
      ..writeByte(7)
      ..write(obj.isChecked);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BuildingModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BuildingModel _$BuildingModelFromJson(Map<String, dynamic> json) =>
    BuildingModel(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      hasWing: json['has_wing'] as bool?,
      hasFloor: json['has_floor'] as bool?,
      hasArea: json['has_area'] as bool?,
      hasRoom: json['has_room'] as bool?,
      availableSeats: json['available_seats'],
      availableParkings: json['available_parkings'],
      isChecked: json['isChecked'] as bool? ?? false,
    );

Map<String, dynamic> _$BuildingModelToJson(BuildingModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'has_wing': instance.hasWing,
      'has_floor': instance.hasFloor,
      'has_area': instance.hasArea,
      'has_room': instance.hasRoom,
      'available_seats': instance.availableSeats,
      'available_parkings': instance.availableParkings,
      'isChecked': instance.isChecked,
    };
