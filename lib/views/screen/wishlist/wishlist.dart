import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../controllers/productController/productController.dart';
import '../../../views/screen/product/product.dart';
import '../../../controllers/wishlistController/wishlistController.dart';

class WishList extends ConsumerWidget {
  const WishList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listWishes = ref.watch(wishlistControllerProvider);
    final ProductController controller = ProductController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Wishlist'),
      ),
      body: ListView.builder(
        itemCount: listWishes.length,
        itemBuilder: (context, index) {
          final product = listWishes[index].product;
          return GestureDetector(
            onTap: () async {
              final result = await controller.displayProduct(product.id);
              Navigator.push(context, MaterialPageRoute(builder: (context) => ViewProduct(result)));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black12),
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black12,
                ),
                child: ListTile(
                  leading: Image.network(product.image),
                  title: Text(product.title),
                  subtitle: Text('\$ ${product.price}',
                    style: const TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                  trailing: IconButton(
                    icon: Image.asset("assets/icons/delete.png", width: 30),
                    onPressed: () {
                      ref.read(wishlistControllerProvider.notifier).removeFromWishlist(product);
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

