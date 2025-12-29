import 'package:flutter_pkg_lockated_book_parking/features/models//show_schedule/show_schedule.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'seat_booking_attendance.g.dart';

@HiveType(typeId: 4)
@JsonSerializable()
class SeatBookingAttendance {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  @JsonKey(name: 'punched_in_at')
  final String? punchedInAt;
  @HiveField(2)
  @JsonKey(name: 'punched_out_at')
  final String? punchedOutAt;
  @HiveField(3)
  @JsonKey(name: 'seat_booking_slot_id')
  final int? seatBookingSlotId;
  @HiveField(4)
  @JsonKey(name: 'show_schedule')
  final List<ShowSchedule>? showSchedule;

  SeatBookingAttendance({
    this.id,
    this.punchedInAt,
    this.punchedOutAt,
    this.seatBookingSlotId,
    this.showSchedule,
  });

  factory SeatBookingAttendance.fromJson(Map<String, dynamic> json) =>
      _$SeatBookingAttendanceFromJson(json);

  Map<String, dynamic> toJson() => _$SeatBookingAttendanceToJson(this);
}
