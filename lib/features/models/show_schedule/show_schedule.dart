import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'show_schedule.g.dart';

@HiveType(typeId: 5)
@JsonSerializable()
class ShowSchedule {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  @JsonKey(name: 'slot_id')
  final int? slotId;
  @HiveField(2)
  final String? slot;
  @HiveField(3)
  final String? seat;
  @HiveField(4)
  @JsonKey(name: 'slot_status')
  final String? slotStatus;
  @HiveField(5)
  @JsonKey(name: 'slot_cancelled_at')
  final String? slotCancelledAt;
  @HiveField(6)
  bool isChecked;
  @HiveField(7)
  @JsonKey(name: 'parking_number')
  final String? parkingNumber;

  ShowSchedule({
    this.id,
    this.slotId,
    this.slot,
    this.seat,
    this.slotStatus,
    this.slotCancelledAt,
    this.isChecked = false,
    this.parkingNumber,
  });

  factory ShowSchedule.fromJson(Map<String, dynamic> json) =>
      _$ShowScheduleFromJson(json);

  Map<String, dynamic> toJson() => _$ShowScheduleToJson(this);
}
