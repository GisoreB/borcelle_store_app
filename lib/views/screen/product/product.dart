import '../../../controllers/cartController/cartController.dart';
import '../../utils/showSnackBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ViewProduct extends StatefulWidget {
  final dynamic result;
  const ViewProduct(this.result, {super.key});

  @override
  State<ViewProduct> createState() => _ViewProductState();
}

class _ViewProductState extends State<ViewProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.redAccent,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "Borcelle Store",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.network(widget.result.image),
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Text(
                  widget.result.title,
                  style: const TextStyle(
                      fontSize: 15,
                      color: Colors.indigo,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 5, bottom: 15, left: 30, right: 30),
                child: Text(widget.result.description,
                    textAlign: TextAlign.justify),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/icons/brazilian-real-moeda.png',
                          width: 30,
                        ),
                        Text(
                          '${widget.result.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54),
                        ),
                      ],
                    ),
                    Consumer(builder: (context, ref, child) {
                      return StatefulBuilder(
                        builder: (BuildContext context, StateSetter setState) {
                          bool isOncart = ref
                              .watch(cartControllerProvider.notifier)
                              .isOnCart(widget.result);
                          return IconButton(
                            onPressed: () {
                              if (!isOncart) {
                                ref
                                    .read(cartControllerProvider.notifier)
                                    .addToCart(widget.result);
                                showSnackBar(context, 'Added to cart');
                              } else {
                                showSnackBar(context, 'Already in cart');
                              }
                              setState(() {});
                            },
                            icon: Image.asset(
                              'assets/icons/cart.png',
                              width: 25,
                            ),
                          );
                        },
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
