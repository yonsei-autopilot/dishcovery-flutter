import 'package:json_annotation/json_annotation.dart';

part 'menu_translation_response.g.dart';

@JsonSerializable()
class MenuTranslationResponse {
  @JsonKey(name: 'items')
  final List<MenuItemResponse> items;

  MenuTranslationResponse({required this.items});

  factory MenuTranslationResponse.fromJson(Map<String, dynamic> json) =>
      _$MenuTranslationResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MenuTranslationResponseToJson(this);
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
