// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_user_food_aversion_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateUserFoodAversionRequest _$UpdateUserFoodAversionRequestFromJson(
        Map<String, dynamic> json) =>
    UpdateUserFoodAversionRequest(
      dislikeFoods: (json['dislikeFoods'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$UpdateUserFoodAversionRequestToJson(
        UpdateUserFoodAversionRequest instance) =>
    <String, dynamic>{
      'dislikeFoods': instance.dislikeFoods,
    };
