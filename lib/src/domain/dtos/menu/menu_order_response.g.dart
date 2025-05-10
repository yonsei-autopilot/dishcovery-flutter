// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_order_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenuOrderResponse _$MenuOrderResponseFromJson(Map<String, dynamic> json) =>
    MenuOrderResponse(
      orderInUserLanguage: json['orderInUserLanguage'] as String,
      orderInForeignLanguage: json['orderInForeignLanguage'] as String,
      inquiryForDislikeFoodsInUserLanguage:
          json['inquiryForDislikeFoodsInUserLanguage'] as String,
      inquiryForDislikeFoodsInForeignLanguage:
          json['inquiryForDislikeFoodsInForeignLanguage'] as String,
      orderAudioBase64: json['orderAudioBase64'] as String,
      inquiryAudioBase64: json['inquiryAudioBase64'] as String,
    );

Map<String, dynamic> _$MenuOrderResponseToJson(MenuOrderResponse instance) =>
    <String, dynamic>{
      'orderInUserLanguage': instance.orderInUserLanguage,
      'orderInForeignLanguage': instance.orderInForeignLanguage,
      'inquiryForDislikeFoodsInUserLanguage':
          instance.inquiryForDislikeFoodsInUserLanguage,
      'inquiryForDislikeFoodsInForeignLanguage':
          instance.inquiryForDislikeFoodsInForeignLanguage,
      'orderAudioBase64': instance.orderAudioBase64,
      'inquiryAudioBase64': instance.inquiryAudioBase64,
    };
