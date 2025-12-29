// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seat_approval_request_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SeatApprovalRequestModelAdapter
    extends TypeAdapter<SeatApprovalRequestModel> {
  @override
  final int typeId = 9;

  @override
  SeatApprovalRequestModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SeatApprovalRequestModel(
      id: fields[0] as int?,
      useId: fields[1] as int?,
      status: fields[2] as String?,
      seatConfigurationId: fields[3] as int?,
      date: fields[4] as String?,
      approvedById: fields[5] as dynamic,
      approvedAt: fields[6] as String?,
      createdAt: fields[7] as String?,
      updatedAt: fields[8] as String?,
      seatCategory: fields[9] as String?,
      approvedByFullName: fields[10] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, SeatApprovalRequestModel obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.useId)
      ..writeByte(2)
      ..write(obj.status)
      ..writeByte(3)
      ..write(obj.seatConfigurationId)
      ..writeByte(4)
      ..write(obj.date)
      ..writeByte(5)
      ..write(obj.approvedById)
      ..writeByte(6)
      ..write(obj.approvedAt)
      ..writeByte(7)
      ..write(obj.createdAt)
      ..writeByte(8)
      ..write(obj.updatedAt)
      ..writeByte(9)
      ..write(obj.seatCategory)
      ..writeByte(10)
      ..write(obj.approvedByFullName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SeatApprovalRequestModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeatApprovalRequestModel _$SeatApprovalRequestModelFromJson(
        Map<String, dynamic> json) =>
    SeatApprovalRequestModel(
      id: (json['id'] as num?)?.toInt(),
      useId: (json['user_id'] as num?)?.toInt(),
      status: json['status'] as String?,
      seatConfigurationId: (json['seat_configuration_id'] as num?)?.toInt(),
      date: json['date'] as String?,
      approvedById: json['approved_by_id'],
      approvedAt: json['approved_at'] as String?,
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
      seatCategory: json['seat_category'] as String?,
      approvedByFullName: json['approved_by_full_name'],
    );

Map<String, dynamic> _$SeatApprovalRequestModelToJson(
        SeatApprovalRequestModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.useId,
      'status': instance.status,
      'seat_configuration_id': instance.seatConfigurationId,
      'date': instance.date,
      'approved_by_id': instance.approvedById,
      'approved_at': instance.approvedAt,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'seat_category': instance.seatCategory,
      'approved_by_full_name': instance.approvedByFullName,
    };
