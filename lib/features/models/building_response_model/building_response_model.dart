import 'package:flutter_pkg_lockated_book_parking/features/models/building_model/building_model.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'building_response_model.g.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class BuildingResponseModel {
  @HiveField(0)
  final int code;
  @HiveField(1)
  final List<BuildingModel>? buildings;

  BuildingResponseModel({this.code = 500, this.buildings});

  factory BuildingResponseModel.fromJson(Map<String, dynamic> json) =>
      _$BuildingResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$BuildingResponseModelToJson(this);
}
