import 'package:json_annotation/json_annotation.dart';

part 'response_model.g.dart';

@JsonSerializable()
class ResponseModel {
  final int? code;
  final String? message;
  final String? otp;

  ResponseModel({
    this.code,
    this.message,
    this.otp,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseModelToJson(this);
}
