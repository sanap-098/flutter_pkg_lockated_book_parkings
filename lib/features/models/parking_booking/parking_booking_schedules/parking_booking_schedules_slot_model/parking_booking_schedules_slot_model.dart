import 'package:json_annotation/json_annotation.dart';

part 'parking_booking_schedules_slot_model.g.dart';

@JsonSerializable()
class ParkingBookingSchedulesSlotModel {
  @JsonKey(name: 'id')
  final int? id;
  @JsonKey(name: 'start_hour')
  final int? startHour;
  @JsonKey(name: 'start_min')
  final int? startMin;
  @JsonKey(name: 'end_hour')
  final int? endHour;
  @JsonKey(name: 'end_min')
  final int? endMin;
  @JsonKey(name: 'ampm')
  final String? ampm;
  bool isSelected;

  ParkingBookingSchedulesSlotModel({
    this.id,
    this.startHour,
    this.startMin,
    this.endHour,
    this.endMin,
    this.ampm,
    this.isSelected = false,
  });

  factory ParkingBookingSchedulesSlotModel.fromJson(
          Map<String, dynamic> json) =>
      _$ParkingBookingSchedulesSlotModelFromJson(json);

  Map<String, dynamic> toJosn() =>
      _$ParkingBookingSchedulesSlotModelToJson(this);
}
