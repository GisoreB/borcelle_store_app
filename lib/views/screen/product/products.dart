import '../../../controllers/cartController/cartController.dart';
import '../../../controllers/productController/productController.dart';
import '../../../controllers/wishlistController/wishlistController.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'Product.dart';
import '../../utils/showSnackBar.dart';
import '../../../models/product/product.dart';

class Products extends StatefulWidget {
  const Products({super.key});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  final ProductController _controller = ProductController();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Product>>(
      future: _controller.listProducts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error loading data'));
        } else {
          final products = snapshot.data!;
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.6,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return Padding(
                padding: const EdgeInsets.all(5),
                child: Card(
                  elevation: 3,
                  child: Column(
                    children: [
                      Expanded(
                        child: GestureDetector(
                            onTap: () async {
                              final result = await _controller.displayProduct(product.id);
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ViewProduct(result)));
                            },
                            child: Stack(
                              alignment: Alignment.topRight,
                              children: [
                                Stack(
                                  alignment: Alignment.bottomLeft,
                                  children: [
                                    Image.network(product.image, fit: BoxFit.cover),
                                    Row(
                                      children: List.generate(product.rate.toInt(), (star) {
                                        return Padding(
                                          padding: EdgeInsets.only(
                                            bottom: 10,
                                            left: star == 0 ? 10 : 0,
                                          ),
                                          child: GestureDetector(
                                              onTap: (){showSnackBar(context, 'Evaluated Item');},
                                              child: const Icon(Icons.star, color: Colors.yellow, size: 15,)),
                                        );
                                      }),
                                    )

                                  ],
                                ),

                                Consumer(builder: (context, ref, child) {
                                  return StatefulBuilder(
                                    builder: (BuildContext context, StateSetter setState) {
                                      bool isOnWishlist = ref.watch(wishlistControllerProvider.notifier).isOnWishlist(product);

                                      return IconButton(
                                          onPressed:() {
                                            if(!isOnWishlist){
                                              ref.read(wishlistControllerProvider.notifier).addToWishlist(product);
                                              showSnackBar(context, 'Added Wishlist');
                                            }else{
                                              showSnackBar(context, 'Wishlist Already Exists');
                                            }
                                            setState(() {});
                                          },
                                          icon: Image.asset('assets/icons/heart.png', width: 25, color: isOnWishlist ? Colors.red : Colors.white)
                                      );
                                    },
                                  );
                                }),

                              ],
                            )// Adicionado fit: BoxFit.cover para ajustar a imagem
                        ),
                      ),

                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 5, left: 10, right: 10),
                            child: Center(child: Text(product.title, overflow: TextOverflow.ellipsis)),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child:
                                Row(
                                  children: [
                                    Image.asset('assets/icons/brazilian-real-moeda.png', width: 25,),
                                    Text(product.price.toStringAsFixed(2))
                                  ],
                                ),
                              ),
                              Consumer(builder: (context, ref, child) {
                                return StatefulBuilder(
                                  builder: (BuildContext context, StateSetter setState) {
                                    bool isOncart = ref.watch(cartControllerProvider.notifier).isOnCart(product);
                                    return IconButton(
                                      onPressed: () {
                                        if(!isOncart){
                                          ref.read(cartControllerProvider.notifier).addToCart(product);
                                          showSnackBar(context, 'Added to cart');
                                        }else{
                                          showSnackBar(context, 'Already in cart');
                                        }
                                        setState(() {});
                                      },
                                      icon: Image.asset('assets/icons/cart.png', width: 25,),
                                    );
                                  },);
                              }),
                            ],
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }

}