import 'package:json_annotation/json_annotation.dart';

part 'put_cancel_slots_request_parameters.g.dart';

@JsonSerializable()
class PutCancelSlotSRequestParameters {
  @JsonKey(name: 'slot_ids')
  List<int>? slotIds;
  @JsonKey(name: 'status')
  String? status;

  PutCancelSlotSRequestParameters({
    this.slotIds,
    this.status,
  });

  factory PutCancelSlotSRequestParameters.fromJson(Map<String, dynamic> json) =>
      _$PutCancelSlotSRequestParametersFromJson(json);

  Map<String, dynamic> toJson() =>
      _$PutCancelSlotSRequestParametersToJson(this);
}
