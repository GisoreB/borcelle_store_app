import '../../../models/cart/cart.dart';
import '../../../models/product/product.dart';
import '../../../services/cart/cart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final cartControllerProvider = StateNotifierProvider<CartController, List<Cart>>((ref) {
  final cartService = ref.watch(cartServiceProvider);
  return CartController(cartService);
});

class CartController extends StateNotifier<List<Cart>> {
  final CartService _cartService;

  CartController(this._cartService) : super([]);

  bool isOnCart(Product product){
    return _cartService.isOnCart(product);
  }

  void addToCart(Product product) {
    final item = Cart(product: product);
    _cartService.addProduct(item);
    state = [..._cartService.listProducts];
  }

  void removeFromCart(Product product) {
    final item = state.firstWhere((item) => item.product == product);
    _cartService.removeProduct(item);
    state = [..._cartService.listProducts];
  }
}