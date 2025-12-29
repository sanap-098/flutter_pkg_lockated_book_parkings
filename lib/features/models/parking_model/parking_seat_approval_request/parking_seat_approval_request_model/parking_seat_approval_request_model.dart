import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'parking_seat_approval_request_model.g.dart';

@HiveType(typeId: 16)
@JsonSerializable()
class ParkingSeatApprovalRequestModel {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  @JsonKey(name: 'user_id')
  final int? useId;
  @HiveField(2)
  final String? status;
  @HiveField(3)
  @JsonKey(name: 'parking_configuration_id')
  final int? parkingConfigurationId;
  @HiveField(4)
  @JsonKey(name: 'date')
  final String? date;
  @HiveField(5)
  @JsonKey(name: 'approved_by_id')
  final dynamic approvedById;
  @HiveField(6)
  @JsonKey(name: 'approved_at')
  final int? approvedAt;
  @HiveField(7)
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @HiveField(8)
  @JsonKey(name: 'updated_at')
  final String? updatedAt;
  @HiveField(9)
  @JsonKey(name: 'parking_category')
  final String? parkingCategory;
  @HiveField(10)
  @JsonKey(name: 'approved_by_full_name')
  final dynamic approvedByFullName;

  ParkingSeatApprovalRequestModel({
    this.id,
    this.useId,
    this.status,
    this.parkingConfigurationId,
    this.date,
    this.approvedById,
    this.approvedAt,
    this.createdAt,
    this.updatedAt,
    this.parkingCategory,
    this.approvedByFullName,
  });

  factory ParkingSeatApprovalRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ParkingSeatApprovalRequestModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ParkingSeatApprovalRequestModelToJson(this);
}
