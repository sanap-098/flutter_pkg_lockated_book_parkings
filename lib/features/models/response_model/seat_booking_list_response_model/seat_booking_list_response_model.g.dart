// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seat_booking_list_response_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SeatBookingListResponseModelAdapter
    extends TypeAdapter<SeatBookingListResponseModel> {
  @override
  final int typeId = 2;

  @override
  SeatBookingListResponseModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SeatBookingListResponseModel(
      seatBookings: (fields[1] as List?)?.cast<SeatBooking>(),
      code: fields[0] as int,
    );
  }

  @override
  void write(BinaryWriter writer, SeatBookingListResponseModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.code)
      ..writeByte(1)
      ..write(obj.seatBookings);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SeatBookingListResponseModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeatBookingListResponseModel _$SeatBookingListResponseModelFromJson(
        Map<String, dynamic> json) =>
    SeatBookingListResponseModel(
      seatBookings: (json['seat_bookings'] as List<dynamic>?)
          ?.map((e) => SeatBooking.fromJson(e as Map<String, dynamic>))
          .toList(),
      code: (json['code'] as num?)?.toInt() ?? 500,
    );

Map<String, dynamic> _$SeatBookingListResponseModelToJson(
        SeatBookingListResponseModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'seat_bookings': instance.seatBookings,
    };
