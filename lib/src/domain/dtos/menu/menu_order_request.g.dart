// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_order_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenuOrderRequest _$MenuOrderRequestFromJson(Map<String, dynamic> json) =>
    MenuOrderRequest(
      foreignLanguage: json['foreignLanguage'] as String,
      foreignLanguageCode: json['foreignLanguageCode'] as String,
      menus: (json['menus'] as List<dynamic>)
          .map((e) => MenuOrderItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MenuOrderRequestToJson(MenuOrderRequest instance) =>
    <String, dynamic>{
      'foreignLanguage': instance.foreignLanguage,
      'foreignLanguageCode': instance.foreignLanguageCode,
      'menus': instance.menus,
    };

MenuOrderItem _$MenuOrderItemFromJson(Map<String, dynamic> json) =>
    MenuOrderItem(
      name: json['name'] as String,
      count: json['count'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$MenuOrderItemToJson(MenuOrderItem instance) =>
    <String, dynamic>{
      'name': instance.name,
      'count': instance.count,
      'description': instance.description,
    };
