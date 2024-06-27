import '../../models/product/product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../models/wishlist/wishlist.dart';

final wishlistServiceProvider = Provider<WishListService>((ref) => WishListService());

class WishListService {
  final List<Wishlist> _listWishes = [];

  List<Wishlist> get listWishes => _listWishes;

  void addWishlist(Wishlist wishlist) {
    _listWishes.add(wishlist);
  }

  void removeWishlist(Wishlist wishlist) {
    _listWishes.remove(wishlist);
  }

  bool isOnWishlist(Product product) {
    return _listWishes.any((wishlist) => wishlist.product.id == product.id);
  }
}

