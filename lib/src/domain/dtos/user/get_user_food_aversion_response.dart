import 'package:json_annotation/json_annotation.dart';

part 'get_user_food_aversion_response.g.dart';

@JsonSerializable()
class GetUserFoodAversionResponse {
  @JsonKey(name: 'dislikeFoods')
  final List<String> dislikeFoods;

  GetUserFoodAversionResponse({required this.dislikeFoods});

  factory GetUserFoodAversionResponse.fromJson(Map<String, dynamic> json) =>
      _$GetUserFoodAversionResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetUserFoodAversionResponseToJson(this);
}
