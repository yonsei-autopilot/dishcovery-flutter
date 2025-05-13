import 'package:json_annotation/json_annotation.dart';

part 'foreign_language_of_menu_response.g.dart';

@JsonSerializable()
class ForeignLanguageOfMenuResponse {
  @JsonKey(name: 'languageCode')
  final String languageCode;

  @JsonKey(name: 'languageName')
  final String languageName;

  ForeignLanguageOfMenuResponse({required this.languageCode, required this.languageName});

  factory ForeignLanguageOfMenuResponse.fromJson(Map<String, dynamic> json) =>
      _$ForeignLanguageOfMenuResponseFromJson(json);
  Map<String, dynamic> toJson() => _$ForeignLanguageOfMenuResponseToJson(this);
}
