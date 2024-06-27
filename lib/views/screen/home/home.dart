import '../../../views/screen/product/product.dart';
import '../../../views/screen/wishlist/wishlist.dart';
import '../../../views/screen/cart/cart.dart';
import 'package:flutter/material.dart';
import '../../../views/screen/account/account.dart';
import '../../../views/utils/CarouselSlider.dart' as Carousel;
import '../product/products.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _paginaAtual = 1;
  final List _telas = [
    const Account(),
    const Products(),
    const CartView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          backgroundColor: Colors.white70,
          elevation: 3,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topRight: Radius.circular(50), bottomRight: Radius.circular(50)),
          ),
          child: Column(
            children: [
              Expanded(child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    decoration: const BoxDecoration(
                      color: Colors.deepPurple,
                    ),
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset('assets/icons/man.png'),
                      ),
                    ),
                  ),
                  ListTile(leading: const Icon(Icons.account_circle), title: const Text('Account'),onTap: (){setState(() {
                    _paginaAtual = 0;
                  }); Navigator.pop(context); },),
                  ListTile(leading: const Icon(Icons.home_filled), title: const Text('Home'),onTap: (){setState(() {
                    _paginaAtual = 1;
                  }); Navigator.pop(context); }),
                  ListTile(leading: const Icon(Icons.shopping_cart_rounded), title: const Text('Cart'),onTap: (){setState(() {
                    _paginaAtual = 2;
                  }); Navigator.pop(context); }),
                  ListTile(
                      leading: Image.asset('assets/icons/heart.png', color: Colors.black54, width: 25,),
                      title: const Text('Wishlist'),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const WishList()));
                      })
                ],
              ),),

              Container(
                child: const Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Text('https://kazungudev-317784.web.app/#/', style: TextStyle(color: Colors.black54),),
                ),
              )
            ],
          )
      ),

      appBar: AppBar(
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Image.asset("assets/icons/menu.png", width: 30,), // Mude a cor aqui
                onPressed: () { Scaffold.of(context).openDrawer(); },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
          title: Title(
              color: Colors.grey,
              child: const Text("Borcelle Store", style: TextStyle(color: Colors.white),)),
          actions: [
            IconButton(
                onPressed: (){},
                icon: const Icon(Icons.search, color: Colors.white,)
            )
          ],
          backgroundColor: Colors.redAccent
      ),
      body: _paginaAtual == 0 ? _telas[_paginaAtual] : SingleChildScrollView(
        child: Column(
          children: [
            const Carousel.CarouselWidget(
              images: [
                'assets/images/banner01.png',
                'assets/images/banner02.png',
                'assets/images/banner03.png'
              ],
              icon: [],
              text: [],
            ),
            _telas[_paginaAtual],
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _paginaAtual,
          onTap: (index){
            setState(() {
              _paginaAtual = index;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.account_circle, color: Colors.redAccent), label: 'Account'),
            BottomNavigationBarItem(icon: Icon(Icons.home_filled, color: Colors.redAccent), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_sharp, color: Colors.redAccent), label: 'Cart'),
          ]
      ),
    );
  }
}
