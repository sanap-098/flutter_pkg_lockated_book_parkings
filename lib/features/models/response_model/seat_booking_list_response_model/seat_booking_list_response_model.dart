
import 'package:flutter_pkg_lockated_book_parking/features/models/seat_booking.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'seat_booking_list_response_model.g.dart';

@HiveType(typeId: 2)
@JsonSerializable()
class SeatBookingListResponseModel {
  @HiveField(0)
  final int code;
  @HiveField(1)
  @JsonKey(name: 'seat_bookings')
  final List<SeatBooking>? seatBookings;

  SeatBookingListResponseModel({this.seatBookings, this.code = 500});

  factory SeatBookingListResponseModel.fromJson(Map<String, dynamic> json) =>
      _$SeatBookingListResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$SeatBookingListResponseModelToJson(this);
}
