import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smart_menu_flutter/src/data/local/shared_preferences_provider.dart';
import '../../domain/entities/cart_item.dart';
import '../../domain/repositories/cart_repository.dart';

final cartRepositoryProvider = Provider<CartRepository>((ref) {
  return CartRepositoryImpl(ref.read(sharedPreferencesProvider));
});

class CartRepositoryImpl implements CartRepository {
  final SharedPreferences prefs;
  static const _cartKey = 'cart_items';

  CartRepositoryImpl(this.prefs);

  @override
  Future<List<CartItem>> getCart() async {
    final jsonStr = prefs.getString(_cartKey);
    if (jsonStr == null) return [];
    final List decoded = json.decode(jsonStr);
    return decoded.map((e) => CartItem.fromJson(e)).toList();
  }

  @override
  Future<void> addOrUpdateItem(CartItem item) async {
    final cart = await getCart();
    final idx = cart.indexWhere((e) => e.menuName == item.menuName);
    if (idx >= 0) {
      cart[idx] = item;
    } else {
      cart.add(item);
    }
    await prefs.setString(_cartKey, json.encode(cart.map((e) => e.toJson()).toList()));
  }

  @override
  Future<void> removeItem(String menuName) async {
    final cart = await getCart();
    cart.removeWhere((e) => e.menuName == menuName);
    await prefs.setString(_cartKey, json.encode(cart.map((e) => e.toJson()).toList()));
  }

  @override
  Future<void> clearCart() async {
    await prefs.remove(_cartKey);
  }
}