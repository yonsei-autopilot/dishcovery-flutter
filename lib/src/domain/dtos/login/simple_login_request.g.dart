// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simple_login_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SimpleLoginRequest _$SimpleLoginRequestFromJson(Map<String, dynamic> json) =>
    SimpleLoginRequest(
      loginId: json['loginId'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$SimpleLoginRequestToJson(SimpleLoginRequest instance) =>
    <String, dynamic>{
      'loginId': instance.loginId,
      'password': instance.password,
    };
