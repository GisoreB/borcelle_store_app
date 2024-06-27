import '../../../models/wishlist/wishlist.dart';
import '../../../models/product/product.dart';
import '../../../services/wishlist/wishlist.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final wishlistControllerProvider = StateNotifierProvider<WishlistController, List<Wishlist>>((ref) {
  final wishlistService = ref.watch(wishlistServiceProvider);
  return WishlistController(wishlistService);
});

class WishlistController extends StateNotifier<List<Wishlist>> {
  final WishListService _wishlistService;

  WishlistController(this._wishlistService) : super([]);

  bool isOnWishlist(Product product) {
    return _wishlistService.isOnWishlist(product);
  }

  void addToWishlist(Product product) {
    final wishlist = Wishlist(product: product);
    _wishlistService.addWishlist(wishlist);
    state = [..._wishlistService.listWishes];
  }

  void removeFromWishlist(Product product) {
    final wishlist = state.firstWhere((wishlist) => wishlist.product == product);
    _wishlistService.removeWishlist(wishlist);
    state = [..._wishlistService.listWishes];
  }
}