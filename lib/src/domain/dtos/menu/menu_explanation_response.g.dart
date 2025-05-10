// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menu_explanation_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MenuExplanationResponse _$MenuExplanationResponseFromJson(
        Map<String, dynamic> json) =>
    MenuExplanationResponse(
      imageLinks: (json['imageLinks'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      name: json['name'] as String,
      description: json['description'] as String,
      ingredients: json['ingredients'] as String,
      whatToBeCareful: json['whatToBeCareful'] as String,
    );

Map<String, dynamic> _$MenuExplanationResponseToJson(
        MenuExplanationResponse instance) =>
    <String, dynamic>{
      'imageLinks': instance.imageLinks,
      'name': instance.name,
      'description': instance.description,
      'ingredients': instance.ingredients,
      'whatToBeCareful': instance.whatToBeCareful,
    };
