import 'package:json_annotation/json_annotation.dart';

part 'language_code_for_google_tts_response.g.dart';

@JsonSerializable()
class ForeignLanguageOfMenuResponse {
  @JsonKey(name: 'languageCode')
  final String languageCode;

  @JsonKey(name: 'languageName')
  final String languageName;

  ForeignLanguageOfMenuResponse({required this.languageCode, required this.languageName});

  factory ForeignLanguageOfMenuResponse.fromJson(Map<String, dynamic> json) =>
      _$LanguageCodeForGoogleTtsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LanguageCodeForGoogleTtsResponseToJson(this);
}
