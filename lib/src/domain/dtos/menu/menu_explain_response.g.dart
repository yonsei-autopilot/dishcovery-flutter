// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_explain_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenuExplainResponse _$MenuExplainResponseFromJson(Map<String, dynamic> json) =>
    MenuExplainResponse(
      items: (json['items'] as List<dynamic>)
          .map((e) => MenuItemResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MenuExplainResponseToJson(
        MenuExplainResponse instance) =>
    <String, dynamic>{
      'items': instance.items,
    };

MenuItemResponse _$MenuItemResponseFromJson(Map<String, dynamic> json) =>
    MenuItemResponse(
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toInt(),
    );

Map<String, dynamic> _$MenuItemResponseToJson(MenuItemResponse instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
    };
