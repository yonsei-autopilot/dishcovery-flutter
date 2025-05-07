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
  final String originalItemName;
  final String translatedItemName;
  final String label;
  final List<String> availableOptions;
  final double price;
  final List<int> boundingBox;

  MenuItemResponse({
    required this.originalItemName,
    required this.translatedItemName,
    required this.label,
    required this.availableOptions,
    required this.price,
    required this.boundingBox,
  });

  factory MenuItemResponse.fromJson(Map<String, dynamic> json) =>
      _$MenuItemResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MenuItemResponseToJson(this);
}
