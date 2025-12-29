// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seat_configuration_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeatConfigurationDetailModel _$SeatConfigurationDetailModelFromJson(
        Map<String, dynamic> json) =>
    SeatConfigurationDetailModel(
      id: (json['id'] as num?)?.toInt(),
      resourceId: (json['resource_id'] as num?)?.toInt(),
      resourceType: json['resource_type'] as String?,
      noOfSeats: (json['no_of_seats'] as num?)?.toInt(),
      bookBeforeMin: json['book_before_min'],
      cancelBeforeMin: json['cancel_before_min'],
      advanceMin: json['advance_min'],
      multipleSlots: json['multiple_slots'],
      maximumSlots: json['maximum_slots'],
      startHour: json['start_hour'],
      startMin: json['start_min'],
      endHour: json['end_hour'],
      endMin: json['end_min'],
      breakMin: json['break_min'],
      breakStartHour: json['break_start_hour'],
      breakStartMin: json['break_start_min'],
      breakEndHour: json['break_end_hour'],
      breakEndMin: json['break_end_min'],
      createdById: (json['created_by_id'] as num?)?.toInt(),
      // bbDHM: json['bb_dhm'] == null
      //     ? null
      //     : DHMModel.fromJson(json['bb_dhm'] as Map<String, dynamic>),
      // abDHM: json['ab_dhm'] == null
      //     ? null
      //     : DHMModel.fromJson(json['ab_dhm'] as Map<String, dynamic>),
      // cbDHM: json['cb_dhm'] == null
      //     ? null
      //     : DHMModel.fromJson(json['cb_dhm'] as Map<String, dynamic>),
      openingTimings: json['opening_timings'] as String?,
      breakTimings: json['break_timings'] as String?,
      seatCategory: json['seat_category'] as String?,
      seatImageUrl: json['seat_image_url'] as String?,
    );

Map<String, dynamic> _$SeatConfigurationDetailModelToJson(
        SeatConfigurationDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'resource_id': instance.resourceId,
      'resource_type': instance.resourceType,
      'no_of_seats': instance.noOfSeats,
      'book_before_min': instance.bookBeforeMin,
      'cancel_before_min': instance.cancelBeforeMin,
      'advance_min': instance.advanceMin,
      'multiple_slots': instance.multipleSlots,
      'maximum_slots': instance.maximumSlots,
      'start_hour': instance.startHour,
      'start_min': instance.startMin,
      'end_hour': instance.endHour,
      'end_min': instance.endMin,
      'break_min': instance.breakMin,
      'break_start_hour': instance.breakStartHour,
      'break_start_min': instance.breakStartMin,
      'break_end_hour': instance.breakEndHour,
      'break_end_min': instance.breakEndMin,
      'created_by_id': instance.createdById,
      // 'seat_details': instance.seatDetails, // Removed this line
      // 'bb_dhm': instance.bbDHM,
      // 'ab_dhm': instance.abDHM,
      // 'cb_dhm': instance.cbDHM,
      'opening_timings': instance.openingTimings,
      'break_timings': instance.breakTimings,
      'seat_category': instance.seatCategory,
      'seat_image_url': instance.seatImageUrl,
    };