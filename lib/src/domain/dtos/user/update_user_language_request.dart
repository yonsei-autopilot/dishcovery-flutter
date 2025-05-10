import 'package:json_annotation/json_annotation.dart';

part 'update_user_language_request.g.dart';

@JsonSerializable()
class UpdateUserLanguageRequest {
  @JsonKey(name: 'language')
  final String language;

  UpdateUserLanguageRequest({required this.language});

  factory UpdateUserLanguageRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserLanguageRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateUserLanguageRequestToJson(this);
}
