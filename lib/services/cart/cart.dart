import '../../models/product/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/cart/cart.dart';

final cartServiceProvider = Provider<CartService>((ref) => CartService());

class CartService {
  final List<Cart> _listProducts = [];

  List<Cart> get listProducts => _listProducts;

  void addProduct(Cart cart) {
    _listProducts.add(cart);
  }

  void removeProduct(Cart cart) {
    _listProducts.remove(cart);
  }

  bool isOnCart(Product product) {
    return _listProducts.any((cart) => cart.product!.id == product.id);
  }
}
