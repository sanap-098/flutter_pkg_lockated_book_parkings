
import 'package:flutter_pkg_lockated_book_parking/features/models/parking_model/parking_seat_configuration_detail/parking_seat_configuration_detail_model/parking_seat_configuration_detail_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter_pkg_lockated_book_parking/features/models/seat_configuration_detail_model/seat_configuration_detail_model.dart';
part 'seat_configuration_detail_model.g.dart';

@JsonSerializable()
class SeatConfigurationDetailModel {
  final int? id;
  @JsonKey(name: 'resource_id')
  final int? resourceId;
  @JsonKey(name: 'resource_type')
  final String? resourceType;
  @JsonKey(name: 'no_of_seats')
  final int? noOfSeats;
  @JsonKey(name: 'book_before_min')
  final dynamic bookBeforeMin;
  @JsonKey(name: 'cancel_before_min')
  final dynamic cancelBeforeMin;
  @JsonKey(name: 'advance_min')
  final dynamic advanceMin;
  @JsonKey(name: 'multiple_slots')
  final dynamic multipleSlots;
  @JsonKey(name: 'maximum_slots')
  final dynamic maximumSlots;
  @JsonKey(name: 'start_hour')
  final dynamic startHour;
  @JsonKey(name: 'start_min')
  final dynamic startMin;
  @JsonKey(name: 'end_hour')
  final dynamic endHour;
  @JsonKey(name: 'end_min')
  final dynamic endMin;
  @JsonKey(name: 'break_min')
  final dynamic breakMin;
  @JsonKey(name: 'break_start_hour')
  final dynamic breakStartHour;
  @JsonKey(name: 'break_start_min')
  final dynamic breakStartMin;
  @JsonKey(name: 'break_end_hour')
  final dynamic breakEndHour;
  @JsonKey(name: 'break_end_min')
  final dynamic breakEndMin;
  @JsonKey(name: 'created_by_id')
  final int? createdById;
 // @JsonKey(name: 'seat_details')
  // List<SeatDetail>? seatDetails;
  // @JsonKey(name: 'bb_dhm')
  // final DHMModel? bbDHM;
  // @JsonKey(name: 'ab_dhm')
  // final DHMModel? abDHM;
  // @JsonKey(name: 'cb_dhm')
  // final DHMModel? cbDHM;
  @JsonKey(name: 'opening_timings')
  final String? openingTimings;
  @JsonKey(name: 'break_timings')
  final String? breakTimings;
  @JsonKey(name: 'seat_category')
  final String? seatCategory;
  @JsonKey(name: 'seat_image_url')
  final String? seatImageUrl;

  SeatConfigurationDetailModel({
    this.id,
    this.resourceId,
    this.resourceType,
    this.noOfSeats,
    this.bookBeforeMin,
    this.cancelBeforeMin,
    this.advanceMin,
    this.multipleSlots,
    this.maximumSlots,
    this.startHour,
    this.startMin,
    this.endHour,
    this.endMin,
    this.breakMin,
    this.breakStartHour,
    this.breakStartMin,
    this.breakEndHour,
    this.breakEndMin,
    this.createdById,
    // this.bbDHM,
    // this.abDHM,
    // this.cbDHM,
    this.openingTimings,
    this.breakTimings,
    this.seatCategory,
    this.seatImageUrl,
  });

  factory SeatConfigurationDetailModel.fromJson(Map<String, dynamic> json) =>
      _$SeatConfigurationDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$SeatConfigurationDetailModelToJson(this);
}
