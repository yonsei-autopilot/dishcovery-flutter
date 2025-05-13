import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smart_menu_flutter/src/data/repositories/cart_repo.dart';
import 'package:smart_menu_flutter/src/domain/repositories/cart_repository.dart';
import '../entities/cart_item.dart';

final cartUseCaseProvider = Provider<CartUseCase> ((ref) {
  final repo = ref.read(cartRepositoryProvider);
  return CartUseCase(repo);
});

class CartUseCase {
  final CartRepository repo;
  CartUseCase(this.repo);

  Future<List<CartItem>> getCart() => repo.getCart();
  Future<void> addOrUpdate(CartItem item) => repo.addOrUpdateItem(item);
  Future<void> remove(String menuName) => repo.removeItem(menuName);
  Future<void> clear() => repo.clearCart();
}