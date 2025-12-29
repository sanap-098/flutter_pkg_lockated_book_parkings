import 'package:flutter_pkg_lockated_book_parking/features/models/parking_model/parking_seat_configuration_detail/parking_seat_configuration_detail_model/parking_seat_configuration_detail_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'parking_seat_configuration_detail_response_model.g.dart';

@JsonSerializable()
class ParkingSeatConfigurationDetailResponseModel {
  @JsonKey(name: 'parking_configuration')
  List<ParkingSeatConfigurationDetailModel>? seatConfigurations;

  ParkingSeatConfigurationDetailResponseModel({this.seatConfigurations});

  factory ParkingSeatConfigurationDetailResponseModel.fromJson(
          Map<String, dynamic> json) =>
      _$ParkingSeatConfigurationDetailResponseModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ParkingSeatConfigurationDetailResponseModelToJson(this);
}
