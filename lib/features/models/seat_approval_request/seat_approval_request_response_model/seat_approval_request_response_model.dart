import 'package:flutter_pkg_lockated_book_parking/features/models/seat_approval_request/seat_approval_request_model/seat_approval_request_model.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'seat_approval_request_response_model.g.dart';

@HiveType(typeId: 8)
@JsonSerializable()
class SeatApprovalRequestResponseModel {
  @HiveField(0)
  @JsonKey(name: 'seat_approval_requests')
  final List<SeatApprovalRequestModel>? seatApprovalRequests;

  SeatApprovalRequestResponseModel({this.seatApprovalRequests});

  factory SeatApprovalRequestResponseModel.fromJson(
          Map<String, dynamic> json) =>
      _$SeatApprovalRequestResponseModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$SeatApprovalRequestResponseModelToJson(this);
}
