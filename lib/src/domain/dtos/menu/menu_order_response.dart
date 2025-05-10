import 'package:json_annotation/json_annotation.dart';

part 'menu_order_response.g.dart';

@JsonSerializable()
class MenuOrderResponse {
  @JsonKey(name: 'orderInUserLanguage')
  final String orderInUserLanguage;

  @JsonKey(name: 'orderInForeignLanguage')
  final String orderInForeignLanguage;

  @JsonKey(name: 'inquiryForDislikeFoodsInUserLanguage')
  final String inquiryForDislikeFoodsInUserLanguage;

  @JsonKey(name: 'inquiryForDislikeFoodsInForeignLanguage')
  final String inquiryForDislikeFoodsInForeignLanguage;

  @JsonKey(name: 'orderAudioBase64')
  final String orderAudioBase64;

  @JsonKey(name: 'inquiryAudioBase64')
  final String inquiryAudioBase64;

  MenuOrderResponse({
    required this.orderInUserLanguage,
    required this.orderInForeignLanguage,
    required this.inquiryForDislikeFoodsInUserLanguage,
    required this.inquiryForDislikeFoodsInForeignLanguage,
    required this.orderAudioBase64,
    required this.inquiryAudioBase64,
  });

  factory MenuOrderResponse.fromJson(Map<String, dynamic> json) =>
      _$MenuOrderResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MenuOrderResponseToJson(this);
}
