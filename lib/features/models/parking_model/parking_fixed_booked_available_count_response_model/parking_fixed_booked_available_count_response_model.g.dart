// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parking_fixed_booked_available_count_response_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ParkingFixedBookedAvailableCountResponseModelAdapter
    extends TypeAdapter<ParkingFixedBookedAvailableCountResponseModel> {
  @override
  final int typeId = 11;

  @override
  ParkingFixedBookedAvailableCountResponseModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ParkingFixedBookedAvailableCountResponseModel(
      code: fields[1] as int?,
      userRoasterMessage: fields[2] as String?,
      roasterType: fields[3] as String?,
      canBookSeat: fields[4] as bool?,
      showApprovalBtn: fields[5] as bool?,
      availableDaysPerWeek: fields[6] as int?,
      totalDaysPerWeek: fields[7] as int?,
      approvedSeatConfigurationId: fields[8] as int?,
      bookedDaysPerWeek: fields[9] as int?,
    )..parkingConfigurations =
        (fields[0] as List?)?.cast<ParkingSeatConfigurationModel>();
  }

  @override
  void write(
      BinaryWriter writer, ParkingFixedBookedAvailableCountResponseModel obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.parkingConfigurations)
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
      other is ParkingFixedBookedAvailableCountResponseModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParkingFixedBookedAvailableCountResponseModel
    _$ParkingFixedBookedAvailableCountResponseModelFromJson(
            Map<String, dynamic> json) =>
        ParkingFixedBookedAvailableCountResponseModel(
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
        )..parkingConfigurations =
            (json['parking_configurations'] as List<dynamic>?)
                ?.map((e) => ParkingSeatConfigurationModel.fromJson(
                    e as Map<String, dynamic>))
                .toList();

Map<String, dynamic> _$ParkingFixedBookedAvailableCountResponseModelToJson(
        ParkingFixedBookedAvailableCountResponseModel instance) =>
    <String, dynamic>{
      'parking_configurations': instance.parkingConfigurations,
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
