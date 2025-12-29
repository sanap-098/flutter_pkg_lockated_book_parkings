import 'package:json_annotation/json_annotation.dart';

part 'parking_booking_book_parking_show_schedule_model.g.dart';

@JsonSerializable()
class ParkingBookingBookParkingShowScheduleModel {
  @JsonKey(name: 'slot_id')
  final List<int>? slotId;
  @JsonKey(name: 'slot')
  final String? slot;
  @JsonKey(name: 'parking_number')
  final String? parkingNumber;

  ParkingBookingBookParkingShowScheduleModel({
    this.slotId,
    this.slot,
    this.parkingNumber,
  });

  factory ParkingBookingBookParkingShowScheduleModel.fromJson(Map<String, dynamic> json) =>
      _$ParkingBookingBookParkingShowScheduleModelFromJson(json);

  Map<String, dynamic> toJosn() => _$ParkingBookingBookParkingShowScheduleModelToJson(this);
}
