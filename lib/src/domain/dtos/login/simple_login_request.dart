import 'package:json_annotation/json_annotation.dart';

part 'simple_login_request.g.dart';

@JsonSerializable()
class SimpleLoginRequest {
  @JsonKey(name: 'loginId')
  final String loginId;

  @JsonKey(name: 'password')
  final String password;

  SimpleLoginRequest({required this.loginId, required this.password});

  factory SimpleLoginRequest.fromJson(Map<String, dynamic> json) => _$SimpleLoginRequestFromJson(json);
  Map<String, dynamic> toJson() => _$SimpleLoginRequestToJson(this);
}
