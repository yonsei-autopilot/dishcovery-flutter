import 'package:json_annotation/json_annotation.dart';

part 'update_user_food_aversion_request.g.dart';

@JsonSerializable()
class UpdateUserFoodAversionRequest {
  @JsonKey(name: 'dislikeFoods')
  final List<String> dislikeFoods;

  UpdateUserFoodAversionRequest({required this.dislikeFoods});

  factory UpdateUserFoodAversionRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserFoodAversionRequestFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateUserFoodAversionRequestToJson(this);
}
