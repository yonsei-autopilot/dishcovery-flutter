import 'package:json_annotation/json_annotation.dart';

part 'language_code_for_google_tts_request.g.dart';

@JsonSerializable()
class ForeignLanguageOfMenuRequest {
  @JsonKey(name: 'snippetOfForeignLanguage')
  final String snippetOfForeignLanguage;

  ForeignLanguageOfMenuRequest({required this.snippetOfForeignLanguage});

  factory ForeignLanguageOfMenuRequest.fromJson(Map<String, dynamic> json) =>
      _$LanguageCodeForGoogleTtsRequestFromJson(json);
  Map<String, dynamic> toJson() => _$LanguageCodeForGoogleTtsRequestToJson(this);
}
