import 'package:json_annotation/json_annotation.dart';

part 'get_user_language_response.g.dart';

@JsonSerializable()
class GetUserLanguageResponse {
  @JsonKey(name: 'language')
  final String language;

  GetUserLanguageResponse({required this.language});

  factory GetUserLanguageResponse.fromJson(Map<String, dynamic> json) =>
      _$GetUserLanguageResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetUserLanguageResponseToJson(this);
}
