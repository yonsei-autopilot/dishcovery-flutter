import 'package:json_annotation/json_annotation.dart';

part 'menu_order_request.g.dart';

@JsonSerializable()
class MenuOrderRequest {
  final String foreignLanguage;
  final String foreignLanguageCode;
  final List<MenuOrderItem> menus;

  MenuOrderRequest({
    required this.foreignLanguage,
    required this.foreignLanguageCode,
    required this.menus,
  });

  factory MenuOrderRequest.fromJson(Map<String, dynamic> json) =>
      _$MenuOrderRequestFromJson(json);
  Map<String, dynamic> toJson() => _$MenuOrderRequestToJson(this);
}

@JsonSerializable()
class MenuOrderItem {
  final String name;
  final String count;
  final String description;

  MenuOrderItem({
    required this.name,
    required this.count,
    required this.description,
  });

  factory MenuOrderItem.fromJson(Map<String, dynamic> json) =>
      _$MenuOrderItemFromJson(json);
  Map<String, dynamic> toJson() => _$MenuOrderItemToJson(this);
}
