import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../../models/product/product.dart';

class ProductService {
  final String baseUrl = 'https://fakestoreapi.com';

  Future<List<Product>> listProducts() async {
    final url = '$baseUrl/products';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        return List<Product>.from(jsonData.map(
              (product) => Product(
            id: product['id'] ?? 0,
            title: product['title'] ?? '',
            price: product['price']?.toDouble() ?? 0.0,
            description: product['description'] ?? '',
            category: product['category'] ?? '',
            image: product['image'] ?? '',
            rate: product['rating']?['rate']?.toDouble() ?? 0.0,
            count: product['rating']?['count'] ?? 0,
          ),
        ));
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
      return [];
    }
  }


  Future<Product> displayProduct(int productId) async{
    final url = '$baseUrl/products/$productId';
    try{
      final response = await http.get(Uri.parse(url));
      if(response.statusCode == 200){
        final jsonBody = json.decode(response.body);
        final product = Product(
          id: jsonBody['id'] ?? 0,
          title: jsonBody['title'] ?? '',
          price: jsonBody['price']?.toDouble() ?? 0.0,
          description: jsonBody['description'] ?? '',
          category: jsonBody['category'] ?? '',
          image: jsonBody['image'] ?? '',
          rate: jsonBody['rating']?['rate']?.toDouble() ?? 0.0,
          count: jsonBody['rating']?['count'] ?? 0,
        );

        return product;
      }else{
        throw Exception('Error fetching data from API');
      }
    }catch(e){throw Exception('Request error: $e');}
  }


}