// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parking_booking_parking_configuration_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParkingBookingParkingConfigurationModel
    _$ParkingBookingParkingConfigurationModelFromJson(
            Map<String, dynamic> json) =>
        ParkingBookingParkingConfigurationModel(
          id: (json['id'] as num?)?.toInt(),
          resourceId: (json['resource_id'] as num?)?.toInt(),
          resourceType: json['resource_type'] as String?,
          noOfParkings: (json['no_of_parkings'] as num?)?.toInt(),
          createdById: (json['created_by_id'] as num?)?.toInt(),
          parkingNumbers: (json['parking_numbers'] as List<dynamic>?)
              ?.map((e) => ParkingBookingParkingNumberModel.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
          parkingCategory: json['parking_category'] as String?,
          parkingImageUrl: json['parking_image_url'] as String?,
          isSelected: json['isSelected'] as bool? ?? false,
        );

Map<String, dynamic> _$ParkingBookingParkingConfigurationModelToJson(
        ParkingBookingParkingConfigurationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'resource_id': instance.resourceId,
      'resource_type': instance.resourceType,
      'no_of_parkings': instance.noOfParkings,
      'created_by_id': instance.createdById,
      'parking_numbers': instance.parkingNumbers,
      'parking_category': instance.parkingCategory,
      'parking_image_url': instance.parkingImageUrl,
      'isSelected': instance.isSelected,
    };
