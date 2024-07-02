// ignore_for_file: null_check_always_fails, prefer_final_fields, avoid_print, body_might_complete_normally_catch_error, unnecessary_null_comparison

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/http_exception.dart';
import './product.dart';

class ProductProvider with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'Sweatshrit',
    //   description: 'Chic Maroon Block Sweatshrit',
    //   price: 20.91,
    //   imageUrl: 'https://iili.io/JyrsZyG.png',
    // ),
    // Product(
    //   id: 'p5',
    //   title: 'Air Jordan',
    //   description: 'Air jorden 1x off-white NRG',
    //   price: 50.00,
    //   imageUrl: 'https://iili.io/JyriBHb.png',
    // ),
    // Product(
    //   id: 'p6',
    //   title: 'Denim jacket',
    //   description: 'Collar Fur Denim jacket',
    //   price: 37.99,
    //   imageUrl: 'https://iili.io/JyrL38u.png',
    // ),
    // Product(
    //   id: 'p7',
    //   title: 'Denim jacket',
    //   description: 'simple black Denim jacket (unisex)',
    //   price: 28.99,
    //   imageUrl: 'https://iili.io/Jyrsyn2.png',
    // ),
    // Product(
    //   id: 'p8',
    //   title: 'Ring',
    //   description: 'A Golden Ring With White Diamonds',
    //   price: 99.99,
    //   imageUrl: 'https://iili.io/fR9Vvn.jpg',
    // ),
    // Product(
    //   id: 'p9',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoriteItems {
    return _items.where((prodItem) => prodItem.isFavorite).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  Future<void> fetchAndSetProduct() async {
    const url =
        'https://myshop-915a2-default-rtdb.firebaseio.com/products.json';
    try {
      final response = await http.get(Uri.parse(url));
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      final List<Product> loadedProduct = [];
      extractedData.forEach((prodId, prodData) {
        loadedProduct.add(
          Product(
            id: prodId,
            title: prodData['title'],
            description: prodData['description'],
            price: prodData['price'],
            imageUrl: prodData['imageUrl'],
            isFavorite: prodData['isFavorite'],
          ),
        );
      });
      _items = loadedProduct;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> addProduct(Product product) async {
    const url =
        'https://myshop-915a2-default-rtdb.firebaseio.com/products.json';
    await http
        .post(Uri.parse(url),
            body: json.encode({
              'title': product.title,
              'description': product.description,
              'price': product.price,
              'imageUrl': product.imageUrl,
              'isFavorite': product.isFavorite,
            }))
        .then((response) {
      final newProduct = Product(
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
        id: json.decode(response.body)['name'],
      );
      _items.add(newProduct);

      notifyListeners();
    }).catchError((error) {
      print(error);
      throw error;
    });
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);

    if (prodIndex >= 0) {
      final url =
          'https://myshop-915a2-default-rtdb.firebaseio.com/products/$id.json';
      await http
          .patch(Uri.parse(url),
              body: json.encode({
                'title': newProduct.title,
                'description': newProduct.description,
                'price': newProduct.price,
                'imageUrl': newProduct.imageUrl,
              }))
          .catchError((error) {
        print(error);
        throw error;
      });
      _items[prodIndex] = newProduct;
      notifyListeners();
    }
  }

  void deleteProduct(String id) async {
    final url =
        'https://myshop-915a2-default-rtdb.firebaseio.com/products/$id.json';
    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    if (existingProductIndex < 0) {
      return;
    }
    var existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();
    try {
      final response = await http.delete(Uri.parse(url));
      if (response.statusCode >= 400) {
        throw HttpException('Could not delete product!');
      }
    } catch (error) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      rethrow;
    }
  }
}
