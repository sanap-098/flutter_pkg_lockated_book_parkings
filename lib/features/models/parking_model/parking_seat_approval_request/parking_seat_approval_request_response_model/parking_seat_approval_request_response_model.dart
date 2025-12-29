import 'package:flutter_pkg_lockated_book_parking/features/models/parking_model/parking_seat_approval_request/parking_seat_approval_request_model/parking_seat_approval_request_model.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'parking_seat_approval_request_response_model.g.dart';

@HiveType(typeId: 17)
@JsonSerializable()
class ParkingSeatApprovalRequestResponseModel {
  @HiveField(0)
  @JsonKey(name: 'parking_approval_requests')
  final List<ParkingSeatApprovalRequestModel>? parkingApprovalRequests;

  ParkingSeatApprovalRequestResponseModel({this.parkingApprovalRequests});

  factory ParkingSeatApprovalRequestResponseModel.fromJson(
          Map<String, dynamic> json) =>
      _$ParkingSeatApprovalRequestResponseModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ParkingSeatApprovalRequestResponseModelToJson(this);
}
