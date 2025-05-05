import 'package:json_annotation/json_annotation.dart';
import 'api_error.dart';

part 'api_response.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ApiResponse<T> {
  final bool isSuccess;
  final T? data;

  @JsonKey(fromJson: _errorFromJson, toJson: _errorToJson)
  final ApiError? error;

  ApiResponse({
    required this.isSuccess,
    this.data,
    this.error,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$ApiResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$ApiResponseToJson(this, toJsonT);

  static ApiError? _errorFromJson(Object? json) =>
      json == null ? null : ApiError.fromJson(json as Map<String, dynamic>);

  static Map<String, dynamic>? _errorToJson(ApiError? error) =>
      error?.toJson();
}
