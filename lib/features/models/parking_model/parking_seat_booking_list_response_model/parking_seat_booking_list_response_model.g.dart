// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parking_seat_booking_list_response_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ParkingSeatBookingListResponseModelAdapter
    extends TypeAdapter<ParkingSeatBookingListResponseModel> {
  @override
  final int typeId = 15;

  @override
  ParkingSeatBookingListResponseModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ParkingSeatBookingListResponseModel(
      parkingBookings: (fields[1] as List?)?.cast<ParkingSeatBooking>(),
      code: fields[0] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ParkingSeatBookingListResponseModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.code)
      ..writeByte(1)
      ..write(obj.parkingBookings);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ParkingSeatBookingListResponseModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParkingSeatBookingListResponseModel
    _$ParkingSeatBookingListResponseModelFromJson(Map<String, dynamic> json) =>
        ParkingSeatBookingListResponseModel(
          parkingBookings: (json['parking_bookings'] as List<dynamic>?)
              ?.map(
                  (e) => ParkingSeatBooking.fromJson(e as Map<String, dynamic>))
              .toList(),
          code: (json['code'] as num?)?.toInt() ?? 500,
        );

Map<String, dynamic> _$ParkingSeatBookingListResponseModelToJson(
        ParkingSeatBookingListResponseModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'parking_bookings': instance.parkingBookings,
    };
