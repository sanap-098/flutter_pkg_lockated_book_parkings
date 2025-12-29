// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'building_response_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BuildingResponseModelAdapter extends TypeAdapter<BuildingResponseModel> {
  @override
  final int typeId = 0;

  @override
  BuildingResponseModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BuildingResponseModel(
      code: fields[0] as int,
      buildings: (fields[1] as List?)?.cast<BuildingModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, BuildingResponseModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.code)
      ..writeByte(1)
      ..write(obj.buildings);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BuildingResponseModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BuildingResponseModel _$BuildingResponseModelFromJson(
        Map<String, dynamic> json) =>
    BuildingResponseModel(
      code: (json['code'] as num?)?.toInt() ?? 500,
      buildings: (json['buildings'] as List<dynamic>?)
          ?.map((e) => BuildingModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BuildingResponseModelToJson(
        BuildingResponseModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'buildings': instance.buildings,
    };
