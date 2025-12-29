import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'seat_approval_request_model.g.dart';

@HiveType(typeId: 9)
@JsonSerializable()
class SeatApprovalRequestModel {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  @JsonKey(name: 'user_id')
  final int? useId;
  @HiveField(2)
  final String? status;
  @HiveField(3)
  @JsonKey(name: 'seat_configuration_id')
  final int? seatConfigurationId;
  @HiveField(4)
  @JsonKey(name: 'date')
  final String? date;
  @HiveField(5)
  @JsonKey(name: 'approved_by_id')
  final dynamic approvedById;
  @HiveField(6)
  @JsonKey(name: 'approved_at')
  final String? approvedAt;
  @HiveField(7)
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @HiveField(8)
  @JsonKey(name: 'updated_at')
  final String? updatedAt;
  @HiveField(9)
  @JsonKey(name: 'seat_category')
  final String? seatCategory;
  @HiveField(10)
  @JsonKey(name: 'approved_by_full_name')
  final dynamic approvedByFullName;

  SeatApprovalRequestModel({
    this.id,
    this.useId,
    this.status,
    this.seatConfigurationId,
    this.date,
    this.approvedById,
    this.approvedAt,
    this.createdAt,
    this.updatedAt,
    this.seatCategory,
    this.approvedByFullName,
  });

  factory SeatApprovalRequestModel.fromJson(Map<String, dynamic> json) =>
      _$SeatApprovalRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$SeatApprovalRequestModelToJson(this);
}
