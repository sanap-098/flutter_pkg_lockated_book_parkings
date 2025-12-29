// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parking_seat_configuration_detail_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ParkingSeatConfigurationDetailModelAdapter
    extends TypeAdapter<ParkingSeatConfigurationDetailModel> {
  @override
  final int typeId = 12;

  @override
  ParkingSeatConfigurationDetailModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ParkingSeatConfigurationDetailModel(
      id: fields[0] as int?,
      resourceId: fields[1] as int?,
      resourceType: fields[2] as String?,
      noOfParkings: fields[3] as int?,
      createdById: fields[4] as int?,
      parkingNumbers: (fields[5] as List?)?.cast<ParkingNumberModel>(),
      parkingCategory: fields[6] as String?,
      parkingImageUrl: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ParkingSeatConfigurationDetailModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.resourceId)
      ..writeByte(2)
      ..write(obj.resourceType)
      ..writeByte(3)
      ..write(obj.noOfParkings)
      ..writeByte(4)
      ..write(obj.createdById)
      ..writeByte(5)
      ..write(obj.parkingNumbers)
      ..writeByte(6)
      ..write(obj.parkingCategory)
      ..writeByte(7)
      ..write(obj.parkingImageUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ParkingSeatConfigurationDetailModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParkingSeatConfigurationDetailModel
    _$ParkingSeatConfigurationDetailModelFromJson(Map<String, dynamic> json) =>
        ParkingSeatConfigurationDetailModel(
          id: (json['id'] as num?)?.toInt(),
          resourceId: (json['resource_id'] as num?)?.toInt(),
          resourceType: json['resource_type'] as String?,
          noOfParkings: (json['no_of_parkings'] as num?)?.toInt(),
          createdById: (json['created_by_id'] as num?)?.toInt(),
          parkingNumbers: (json['parking_numbers'] as List<dynamic>?)
              ?.map(
                  (e) => ParkingNumberModel.fromJson(e as Map<String, dynamic>))
              .toList(),
          parkingCategory: json['parking_category'] as String?,
          parkingImageUrl: json['parking_image_url'] as String?,
        );

Map<String, dynamic> _$ParkingSeatConfigurationDetailModelToJson(
        ParkingSeatConfigurationDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'resource_id': instance.resourceId,
      'resource_type': instance.resourceType,
      'no_of_parkings': instance.noOfParkings,
      'created_by_id': instance.createdById,
      'parking_numbers': instance.parkingNumbers,
      'parking_category': instance.parkingCategory,
      'parking_image_url': instance.parkingImageUrl,
    };
