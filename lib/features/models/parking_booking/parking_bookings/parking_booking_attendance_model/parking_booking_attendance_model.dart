import 'package:json_annotation/json_annotation.dart';

part 'parking_booking_attendance_model.g.dart';

@JsonSerializable()
class ParkingBookingAttendanceModel {
  final int? id;

  @JsonKey(name: 'punched_in_at')
  final String? punchedInAt;
  @JsonKey(name: 'punched_out_at')
  final String? punchedOutAt;
  @JsonKey(name: 'parking_booking_id')
  final int? parkingBookingId;

  ParkingBookingAttendanceModel({
    this.id,
    this.punchedInAt,
    this.punchedOutAt,
    this.parkingBookingId,
  });

  factory ParkingBookingAttendanceModel.fromJson(Map<String, dynamic> json) =>
      _$ParkingBookingAttendanceModelFromJson(json);

  Map<String, dynamic> toJson() => _$ParkingBookingAttendanceModelToJson(this);
}
