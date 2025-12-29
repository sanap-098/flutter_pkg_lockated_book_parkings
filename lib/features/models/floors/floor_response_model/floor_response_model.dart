import 'package:flutter_pkg_lockated_book_parking/features/models/floor_model/floor_model.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/floors/floor_model/floor_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'floor_response_model.g.dart';

@JsonSerializable()
class FloorResponseModel {
  final int code;
  final List<FloorModel>? floors;

  FloorResponseModel({
    this.code = 500,
    this.floors,
  });

  factory FloorResponseModel.fromJson(Map<String, dynamic> json) =>
      _$FloorResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$FloorResponseModelToJson(this);
}
