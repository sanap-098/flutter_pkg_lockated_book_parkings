// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parking_seat_approval_request_response_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ParkingSeatApprovalRequestResponseModelAdapter
    extends TypeAdapter<ParkingSeatApprovalRequestResponseModel> {
  @override
  final int typeId = 17;

  @override
  ParkingSeatApprovalRequestResponseModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ParkingSeatApprovalRequestResponseModel(
      parkingApprovalRequests:
          (fields[0] as List?)?.cast<ParkingSeatApprovalRequestModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, ParkingSeatApprovalRequestResponseModel obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.parkingApprovalRequests);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ParkingSeatApprovalRequestResponseModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParkingSeatApprovalRequestResponseModel
    _$ParkingSeatApprovalRequestResponseModelFromJson(
            Map<String, dynamic> json) =>
        ParkingSeatApprovalRequestResponseModel(
          parkingApprovalRequests:
              (json['parking_approval_requests'] as List<dynamic>?)
                  ?.map((e) => ParkingSeatApprovalRequestModel.fromJson(
                      e as Map<String, dynamic>))
                  .toList(),
        );

Map<String, dynamic> _$ParkingSeatApprovalRequestResponseModelToJson(
        ParkingSeatApprovalRequestResponseModel instance) =>
    <String, dynamic>{
      'parking_approval_requests': instance.parkingApprovalRequests,
    };
