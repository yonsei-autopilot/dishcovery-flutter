import 'package:json_annotation/json_annotation.dart';

part 'foreign_language_of_menu_request.g.dart';

@JsonSerializable()
class ForeignLanguageOfMenuRequest {
  @JsonKey(name: 'snippetOfForeignLanguage')
  final String snippetOfForeignLanguage;

  ForeignLanguageOfMenuRequest({required this.snippetOfForeignLanguage});

  factory ForeignLanguageOfMenuRequest.fromJson(Map<String, dynamic> json) =>
      _$ForeignLanguageOfMenuRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ForeignLanguageOfMenuRequestToJson(this);
}
