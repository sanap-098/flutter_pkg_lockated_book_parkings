// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seat_approval_request_response_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SeatApprovalRequestResponseModelAdapter
    extends TypeAdapter<SeatApprovalRequestResponseModel> {
  @override
  final int typeId = 8;

  @override
  SeatApprovalRequestResponseModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SeatApprovalRequestResponseModel(
      seatApprovalRequests:
          (fields[0] as List?)?.cast<SeatApprovalRequestModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, SeatApprovalRequestResponseModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.seatApprovalRequests);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SeatApprovalRequestResponseModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeatApprovalRequestResponseModel _$SeatApprovalRequestResponseModelFromJson(
        Map<String, dynamic> json) =>
    SeatApprovalRequestResponseModel(
      seatApprovalRequests: (json['seat_approval_requests'] as List<dynamic>?)
          ?.map((e) =>
              SeatApprovalRequestModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SeatApprovalRequestResponseModelToJson(
        SeatApprovalRequestResponseModel instance) =>
    <String, dynamic>{
      'seat_approval_requests': instance.seatApprovalRequests,
    };
