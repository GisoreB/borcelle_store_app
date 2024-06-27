import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../controllers/productController/productController.dart';
import '../../../views/screen/product/product.dart';
import '../../../controllers/cartController/cartController.dart';

class CartView extends ConsumerWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartControllerProvider);
    final ProductController controller = ProductController();

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: cart.length,
      itemBuilder: (context, index) {
        final product = cart[index].product!;
        return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () async {
                final result = await controller.displayProduct(product.id);
                Navigator.push(context, MaterialPageRoute(builder: (context) => ViewProduct(result)));
              },
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
                      ref.read(cartControllerProvider.notifier).removeFromCart(product);
                    },
                  ),
                ),
              ),
            )
        );
      },
    );
  }

}