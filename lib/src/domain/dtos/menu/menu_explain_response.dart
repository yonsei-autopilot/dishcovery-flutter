import 'package:json_annotation/json_annotation.dart';

part 'menu_explain_response.g.dart';

@JsonSerializable()
class MenuExplainResponse {
  @JsonKey(name: 'items')
  final List<MenuItemResponse> items;

  MenuExplainResponse({required this.items});

  factory MenuExplainResponse.fromJson(Map<String, dynamic> json) =>
      _$MenuExplainResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MenuExplainResponseToJson(this);
}

@JsonSerializable()
class MenuItemResponse {
  final String name;
  final String description;
  final int price;

  MenuItemResponse({
    required this.name,
    required this.description,
    required this.price,
  });

  factory MenuItemResponse.fromJson(Map<String, dynamic> json) =>
      _$MenuItemResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MenuItemResponseToJson(this);
}
