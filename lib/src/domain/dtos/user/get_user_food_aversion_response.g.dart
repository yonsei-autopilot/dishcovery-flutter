// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_user_food_aversion_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetUserFoodAversionResponse _$GetUserFoodAversionResponseFromJson(
        Map<String, dynamic> json) =>
    GetUserFoodAversionResponse(
      dislikeFoods: (json['dislikeFoods'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$GetUserFoodAversionResponseToJson(
        GetUserFoodAversionResponse instance) =>
    <String, dynamic>{
      'dislikeFoods': instance.dislikeFoods,
    };
