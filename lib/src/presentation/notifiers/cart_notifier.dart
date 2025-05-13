import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/cart_item.dart';
import '../../domain/usecases/cart_usecase.dart';

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItem>>((ref) {
  final useCase = ref.watch(cartUseCaseProvider);
  return CartNotifier(useCase);
});

class CartNotifier extends StateNotifier<List<CartItem>> {
  final CartUseCase useCase;

  CartNotifier(this.useCase) : super([]) {
    loadCart();
  }

  Future<void> loadCart() async {
    state = await useCase.getCart();
  }

  Future<void> addOrUpdateItem(CartItem item) async {
    await useCase.addOrUpdate(item);
    await loadCart();
  }

  Future<void> removeItem(String menuName) async {
    await useCase.remove(menuName);
    await loadCart();
  }

  Future<void> clearCart() async {
    await useCase.clear();
    state = [];
  }
}
