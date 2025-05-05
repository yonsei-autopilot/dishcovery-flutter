import 'package:json_annotation/json_annotation.dart';

part 'google_login_request.g.dart';

@JsonSerializable()
class GoogleLoginRequest {
  @JsonKey(name: 'accessToken')
  final String accessToken;

  GoogleLoginRequest({required this.accessToken});

  factory GoogleLoginRequest.fromJson(Map<String, dynamic> json) => _$GoogleLoginRequestFromJson(json);
  Map<String, dynamic> toJson() => _$GoogleLoginRequestToJson(this);
}
