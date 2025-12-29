
import 'package:flutter_pkg_lockated_book_parking/features/models/seat_configuration/seat_configuration_model.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'fixed_booked_available_count_response_model.g.dart';

@HiveType(typeId: 6)
@JsonSerializable()
class FixedBookedAvailableCountResponseModel {
  @HiveField(0)
  @JsonKey(name: 'seat_configurations')
  List<SeatConfigurationModel>? seatConfigurations;
  @HiveField(1)
  final int? code;
  @HiveField(2)
  @JsonKey(name: 'user_roaster_message')
  final String? userRoasterMessage;
  @HiveField(3)
  @JsonKey(name: 'roaster_type')
  final String? roasterType;
  @HiveField(4)
  @JsonKey(name: 'can_book_seat')
  final bool? canBookSeat;
  @HiveField(5)
  @JsonKey(name: 'show_approval_btn')
  final bool? showApprovalBtn;
  @HiveField(6)
  @JsonKey(name: 'available_days_per_week')
  final int? availableDaysPerWeek;
  @HiveField(7)
  @JsonKey(name: 'total_days_per_week')
  final int? totalDaysPerWeek;
  @HiveField(8)
  @JsonKey(name: 'approved_seat_configuration_id')
  final int? approvedSeatConfigurationId;
  @HiveField(9)
  @JsonKey(name: 'booked_days_per_week')
  final int? bookedDaysPerWeek;

  FixedBookedAvailableCountResponseModel({
    this.code,
    this.userRoasterMessage,
    this.roasterType,
    this.canBookSeat,
    this.showApprovalBtn,
    this.availableDaysPerWeek,
    this.totalDaysPerWeek,
    this.approvedSeatConfigurationId,
    this.bookedDaysPerWeek,
  });

  factory FixedBookedAvailableCountResponseModel.fromJson(
          Map<String, dynamic> json) =>
      _$FixedBookedAvailableCountResponseModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$FixedBookedAvailableCountResponseModelToJson(this);
}
