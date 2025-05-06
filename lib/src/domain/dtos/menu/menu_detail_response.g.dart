// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenuDetailResponse _$MenuDetailResponseFromJson(Map<String, dynamic> json) =>
    MenuDetailResponse(
      item: (json['items'] as List<dynamic>)
          .map((e) => MenuResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MenuDetailResponseToJson(MenuDetailResponse instance) =>
    <String, dynamic>{
      'items': instance.item,
    };

MenuResponse _$MenuResponseFromJson(Map<String, dynamic> json) => MenuResponse(
      imageUrl: json['imageUrl'] as String,
      menuName: json['menuName'] as String,
      menuDescription: json['menuDescription'] as String,
      foodAversion: json['foodAversion'] as String,
    );

Map<String, dynamic> _$MenuResponseToJson(MenuResponse instance) =>
    <String, dynamic>{
      'imageUrl': instance.imageUrl,
      'menuName': instance.menuName,
      'menuDescription': instance.menuDescription,
      'foodAversion': instance.foodAversion,
    };
