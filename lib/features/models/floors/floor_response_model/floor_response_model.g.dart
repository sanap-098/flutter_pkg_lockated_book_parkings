// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'floor_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FloorResponseModel _$FloorResponseModelFromJson(Map<String, dynamic> json) =>
    FloorResponseModel(
      code: (json['code'] as num?)?.toInt() ?? 500,
      floors: (json['floors'] as List<dynamic>?)
          ?.map((e) => FloorModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FloorResponseModelToJson(FloorResponseModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'floors': instance.floors,
    };
