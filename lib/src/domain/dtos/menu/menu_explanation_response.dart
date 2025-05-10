import 'package:json_annotation/json_annotation.dart';

part 'menu_explanation_response.g.dart';

@JsonSerializable()
class MenuExplanationResponse {
  @JsonKey(name: 'imageLinks')
  final List<String> imageLinks;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'description')
  final String description;

  @JsonKey(name: 'ingredients')
  final String ingredients;

  @JsonKey(name: 'whatToBeCareful')
  final String whatToBeCareful;

  MenuExplanationResponse(
      {required this.imageLinks,
      required this.name,
      required this.description,
      required this.ingredients,
      required this.whatToBeCareful});

  factory MenuExplanationResponse.fromJson(Map<String, dynamic> json) =>
      _$MenuExplanationResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MenuExplanationResponseToJson(this);
}
