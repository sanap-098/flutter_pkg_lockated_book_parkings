
import 'package:flutter_pkg_lockated_book_parking/features/models/seat_configuration_detail_model/seat_configuration_detail_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'seat_configuration_detail_response_model.g.dart';

@JsonSerializable()
class SeatConfigurationDetailResponseModel {
  @JsonKey(name: 'seat_configuration')
  List<SeatConfigurationDetailModel>? seatConfigurations;

  SeatConfigurationDetailResponseModel({this.seatConfigurations});

  factory SeatConfigurationDetailResponseModel.fromJson(
          Map<String, dynamic> json) =>
      _$SeatConfigurationDetailResponseModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SeatConfigurationDetailResponseModelToJson(this);
}
