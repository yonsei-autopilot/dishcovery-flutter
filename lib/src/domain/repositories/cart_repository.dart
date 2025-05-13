import 'package:smart_menu_flutter/src/domain/entities/cart_item.dart';

abstract class CartRepository {
  Future<List<CartItem>> getCart();
  Future<void> addOrUpdateItem(CartItem item);
  Future<void> removeItem(String menuName);
  Future<void> clearCart();
}