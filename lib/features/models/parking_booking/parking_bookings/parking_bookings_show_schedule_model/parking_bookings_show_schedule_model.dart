import 'package:json_annotation/json_annotation.dart';

part 'parking_bookings_show_schedule_model.g.dart';

@JsonSerializable()
class ParkingBookingsShowScheduleModel {
  @JsonKey(name: 'slot_id')
  final dynamic slotId;
  @JsonKey(name: 'slot')
  final String? slot;
  @JsonKey(name: 'parking_number')
  final String? parkingNumber;

  ParkingBookingsShowScheduleModel({
    this.slotId,
    this.slot,
    this.parkingNumber,
  });

  factory ParkingBookingsShowScheduleModel.fromJson(
          Map<String, dynamic> json) =>
      _$ParkingBookingsShowScheduleModelFromJson(json);

  Map<String, dynamic> toJosn() =>
      _$ParkingBookingsShowScheduleModelToJson(this);
}
