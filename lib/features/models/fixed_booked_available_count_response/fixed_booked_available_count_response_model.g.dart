// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fixed_booked_available_count_response_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FixedBookedAvailableCountResponseModelAdapter
    extends TypeAdapter<FixedBookedAvailableCountResponseModel> {
  @override
  final int typeId = 6;

  @override
  FixedBookedAvailableCountResponseModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FixedBookedAvailableCountResponseModel(
      code: fields[1] as int?,
      userRoasterMessage: fields[2] as String?,
      roasterType: fields[3] as String?,
      canBookSeat: fields[4] as bool?,
      showApprovalBtn: fields[5] as bool?,
      availableDaysPerWeek: fields[6] as int?,
      totalDaysPerWeek: fields[7] as int?,
      approvedSeatConfigurationId: fields[8] as int?,
      bookedDaysPerWeek: fields[9] as int?,
    )..seatConfigurations =
        (fields[0] as List?)?.cast<SeatConfigurationModel>();
  }

  @override
  void write(BinaryWriter writer, FixedBookedAvailableCountResponseModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.seatConfigurations)
      ..writeByte(1)
      ..write(obj.code)
      ..writeByte(2)
      ..write(obj.userRoasterMessage)
      ..writeByte(3)
      ..write(obj.roasterType)
      ..writeByte(4)
      ..write(obj.canBookSeat)
      ..writeByte(5)
      ..write(obj.showApprovalBtn)
      ..writeByte(6)
      ..write(obj.availableDaysPerWeek)
      ..writeByte(7)
      ..write(obj.totalDaysPerWeek)
      ..writeByte(8)
      ..write(obj.approvedSeatConfigurationId)
      ..writeByte(9)
      ..write(obj.bookedDaysPerWeek);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FixedBookedAvailableCountResponseModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FixedBookedAvailableCountResponseModel
    _$FixedBookedAvailableCountResponseModelFromJson(
            Map<String, dynamic> json) =>
        FixedBookedAvailableCountResponseModel(
          code: (json['code'] as num?)?.toInt(),
          userRoasterMessage: json['user_roaster_message'] as String?,
          roasterType: json['roaster_type'] as String?,
          canBookSeat: json['can_book_seat'] as bool?,
          showApprovalBtn: json['show_approval_btn'] as bool?,
          availableDaysPerWeek:
              (json['available_days_per_week'] as num?)?.toInt(),
          totalDaysPerWeek: (json['total_days_per_week'] as num?)?.toInt(),
          approvedSeatConfigurationId:
              (json['approved_seat_configuration_id'] as num?)?.toInt(),
          bookedDaysPerWeek: (json['booked_days_per_week'] as num?)?.toInt(),
        )..seatConfigurations = (json['seat_configurations'] as List<dynamic>?)
            ?.map((e) =>
                SeatConfigurationModel.fromJson(e as Map<String, dynamic>))
            .toList();

Map<String, dynamic> _$FixedBookedAvailableCountResponseModelToJson(
        FixedBookedAvailableCountResponseModel instance) =>
    <String, dynamic>{
      'seat_configurations': instance.seatConfigurations,
      'code': instance.code,
      'user_roaster_message': instance.userRoasterMessage,
      'roaster_type': instance.roasterType,
      'can_book_seat': instance.canBookSeat,
      'show_approval_btn': instance.showApprovalBtn,
      'available_days_per_week': instance.availableDaysPerWeek,
      'total_days_per_week': instance.totalDaysPerWeek,
      'approved_seat_configuration_id': instance.approvedSeatConfigurationId,
      'booked_days_per_week': instance.bookedDaysPerWeek,
    };
