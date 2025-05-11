import 'package:json_annotation/json_annotation.dart';

part 'menu_explanation_request.g.dart';

@JsonSerializable()
class MenuExplanationRequest {
  @JsonKey(name: 'name')
  final String name;

  MenuExplanationRequest({required this.name});

  factory MenuExplanationRequest.fromJson(Map<String, dynamic> json) =>
      _$MenuExplanationRequestFromJson(json);
  Map<String, dynamic> toJson() => _$MenuExplanationRequestToJson(this);
}
