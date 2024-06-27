import '../../../models/product/product.dart';
import '../../../services/product/product.dart';

class ProductController{
  final ProductService _service = ProductService();

  Future<List<Product>> listProducts() async{
    return _service.listProducts();
  }


  Future<Product> displayProduct(int productId) async {
    try {
      final product = await _service.displayProduct(productId);
      return product;
    } catch (e) {
      throw Exception('Error $e');
    }
  }
}