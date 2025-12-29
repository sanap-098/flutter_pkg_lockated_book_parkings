// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'put_cancel_slots_request_parameters.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PutCancelSlotSRequestParameters _$PutCancelSlotSRequestParametersFromJson(
        Map<String, dynamic> json) =>
    PutCancelSlotSRequestParameters(
      slotIds: (json['slot_ids'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      status: json['status'] as String?,
    );

Map<String, dynamic> _$PutCancelSlotSRequestParametersToJson(
        PutCancelSlotSRequestParameters instance) =>
    <String, dynamic>{
      'slot_ids': instance.slotIds,
      'status': instance.status,
    };
