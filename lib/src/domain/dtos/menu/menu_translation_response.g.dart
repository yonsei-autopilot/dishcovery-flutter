// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_translation_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenuTranslationResponse _$MenuTranslationResponseFromJson(
        Map<String, dynamic> json) =>
    MenuTranslationResponse(
      items: (json['items'] as List<dynamic>)
          .map((e) => MenuItemResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MenuTranslationResponseToJson(
        MenuTranslationResponse instance) =>
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
