import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_menu_flutter/src/data/local/shared_preferences_provider.dart';
import 'package:smart_menu_flutter/src/data/network/api_path.dart';
import 'package:smart_menu_flutter/src/data/network/dio_provider.dart';
import 'package:smart_menu_flutter/src/data/network/http_method.dart';
import 'package:smart_menu_flutter/src/domain/dtos/common/api_response.dart';
import 'package:smart_menu_flutter/src/domain/dtos/user/get_user_food_aversion_response.dart';
import 'package:smart_menu_flutter/src/domain/dtos/user/update_user_food_aversion_request.dart';
import 'package:smart_menu_flutter/src/domain/repositories/food_aversion_repository.dart';

final foodAversionRepositoryProvider = Provider<FoodAversionRepository>((ref) {
  final sharedPref = ref.watch(sharedPreferencesProvider);
  final dioService = ref.read(dioProvider);
  return FoodAversionRepositoryImpl(sharedPref, dioService);
});

class FoodAversionRepositoryImpl implements FoodAversionRepository {
  final SharedPreferences sharedPreferences;
  final DioService dioService;

  FoodAversionRepositoryImpl(this.sharedPreferences, this.dioService);

  @override
  Future<List<String>> getAversions() async {
    return sharedPreferences.getStringList('food_aversions') ?? [];
  }

  @override
  Future<void> updateAversions(List<String> aversions) async {
    await sharedPreferences.setStringList('food_aversions', aversions);
  }

  @override
  Future<List<String>> fetchFromServer() async {
    final response =
        await dioService.request<ApiResponse<GetUserFoodAversionResponse>>(
      path: ApiPath.disLikeFoods,
      method: HttpMethod.GET,
      decoder: (json) => ApiResponse.fromJson(
          json,
          (j) =>
              GetUserFoodAversionResponse.fromJson(j as Map<String, dynamic>)),
    );

    final foodAversion = response.data;

    if (foodAversion == null) {
      throw Exception('FoodAversion is null');
    }
    return foodAversion.dislikeFoods;
  }

  @override
  Future<void> syncToServer(List<String> aversions) async {
    final response = await dioService.request<ApiResponse<void>>(
        path: ApiPath.disLikeFoods,
        method: HttpMethod.PUT,
        body: UpdateUserFoodAversionRequest(dislikeFoods: aversions),
        options: Options(
          contentType: Headers.jsonContentType,
        ),
        decoder: (json) => ApiResponse.fromJson(json, (_) {}));

    if (!response.isSuccess) {
      throw Exception('FoodAversion not saved');
    }
  }
}
