// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApiError _$ApiErrorFromJson(Map<String, dynamic> json) => ApiError(
      errorCode: (json['errorCode'] as num).toInt(),
      errorDescription: json['errorDescription'] as String,
    );

Map<String, dynamic> _$ApiErrorToJson(ApiError instance) => <String, dynamic>{
      'errorCode': instance.errorCode,
      'errorDescription': instance.errorDescription,
    };
