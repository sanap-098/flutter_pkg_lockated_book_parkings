import 'package:flutter_pkg_lockated_book_parking/features/models/parking_model/parking_seat_configuration_detail/parking_number_model/parking_number_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'parking_slot_model.g.dart';

@JsonSerializable()
class ParkingSlotModel {
  final int? id;
  @JsonKey(name: 'start_hour')
  final int? startHour;
  @JsonKey(name: 'start_min')
  final int? startMin;
  @JsonKey(name: 'end_hour')
  final int? endHour;
  @JsonKey(name: 'end_min')
  final int? endMin;
  @JsonKey(name: 'parking_numbers')
  List<ParkingNumberModel>? parkingNumbers;
  @JsonKey(name: 'booked_parking_numbers')
  List<ParkingNumberModel>? bookedParkingNumbers;
  @JsonKey(name: 'ampm')
  final String? amPm;
  bool isSelected;
  bool isSelectedBeforeBooking;

  ParkingSlotModel({
    this.id,
    this.startHour,
    this.startMin,
    this.endHour,
    this.endMin,
    this.parkingNumbers,
    this.bookedParkingNumbers,
    this.amPm,
    this.isSelected = false,
    this.isSelectedBeforeBooking = false,
  });

  factory ParkingSlotModel.fromJson(Map<String, dynamic> json) =>
      _$ParkingSlotModelFromJson(json);

  Map<String, dynamic> toJson() => _$ParkingSlotModelToJson(this);
}
