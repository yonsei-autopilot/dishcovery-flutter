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
      originalItemName: json['originalItemName'] as String,
      translatedItemName: json['translatedItemName'] as String,
      label: json['label'] as String,
      availableOptions: (json['availableOptions'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      price: (json['price'] as num).toDouble(),
      boundingBox: (json['boundingBox'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$MenuItemResponseToJson(MenuItemResponse instance) =>
    <String, dynamic>{
      'originalItemName': instance.originalItemName,
      'translatedItemName': instance.translatedItemName,
      'label': instance.label,
      'availableOptions': instance.availableOptions,
      'price': instance.price,
      'boundingBox': instance.boundingBox,
    };
