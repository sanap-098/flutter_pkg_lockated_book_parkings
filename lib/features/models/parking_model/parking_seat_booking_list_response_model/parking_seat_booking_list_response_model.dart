import 'package:flutter_pkg_lockated_book_parking/features/models/parking_model/parking_seat_booking/parking_seat_booking.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'parking_seat_booking_list_response_model.g.dart';

@HiveType(typeId: 15)
@JsonSerializable()
class ParkingSeatBookingListResponseModel {
  @HiveField(0)
  final int code;
  @HiveField(1)
  @JsonKey(name: 'parking_bookings')
  final List<ParkingSeatBooking>? parkingBookings;

  ParkingSeatBookingListResponseModel({this.parkingBookings, this.code = 500});

  factory ParkingSeatBookingListResponseModel.fromJson(
          Map<String, dynamic> json) =>
      _$ParkingSeatBookingListResponseModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ParkingSeatBookingListResponseModelToJson(this);
}
