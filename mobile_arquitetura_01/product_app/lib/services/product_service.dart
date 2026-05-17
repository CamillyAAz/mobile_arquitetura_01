import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/product.dart';

class ProductService {
  static const String _baseUrl = 'https://dummyjson.com/products';
  static const String _favoritesKey = 'favorite_product_ids';
  static const String _localProductsKey = 'local_products';

  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> productsJson = data['products'];
      final apiProducts = productsJson
          .map((json) => Product.fromJson(json))
          .toList();
      final favoriteIds = await getFavoriteIds();

      return apiProducts.map((product) {
        return product.copyWith(favorite: favoriteIds.contains(product.id));
      }).toList();
    }

    throw Exception('Falha ao carregar produtos: ${response.statusCode}');
  }

  Future<Product> getProductById(int id) async {
    final response = await http.get(Uri.parse('$_baseUrl/$id'));

    if (response.statusCode == 200) {
      final product = Product.fromJson(json.decode(response.body));
      final favoriteIds = await getFavoriteIds();
      return product.copyWith(favorite: favoriteIds.contains(product.id));
    }

    throw Exception('Falha ao carregar produto: ${response.statusCode}');
  }

  Future<Product> addProduct(Product product) async {
    final newProduct = product.copyWith(
      id: DateTime.now().millisecondsSinceEpoch,
    );
    await _saveLocalProduct(newProduct);
    return newProduct;
  }

  Future<Product> updateProduct(Product product) async {
    await _updateLocalProduct(product);
    return product;
  }

  Future<void> deleteProduct(int id) async {
    await _deleteLocalProduct(id);
  }

  Future<List<Product>> searchProducts(String query) async {
    final allProducts = await fetchProducts();
    if (query.isEmpty) return allProducts;

    final lowerQuery = query.toLowerCase();
    return allProducts.where((product) {
      return product.title.toLowerCase().contains(lowerQuery) ||
          product.description.toLowerCase().contains(lowerQuery) ||
          product.category.toLowerCase().contains(lowerQuery);
    }).toList();
  }

  Future<List<int>> getFavoriteIds() async {
    final prefs = await SharedPreferences.getInstance();
    final ids = prefs.getStringList(_favoritesKey);
    return ids?.map(int.parse).toList() ?? [];
  }

  Future<void> saveFavoriteIds(List<int> ids) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      _favoritesKey,
      ids.map((id) => id.toString()).toList(),
    );
  }

  Future<List<Product>> _getLocalProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final productsJson = prefs.getStringList(_localProductsKey) ?? [];
    return productsJson.map((json) {
      final map = jsonDecode(json);
      return Product.fromJson(map);
    }).toList();
  }

  Future<void> _saveLocalProduct(Product product) async {
    final localProducts = await _getLocalProducts();
    localProducts.add(product);
    await _saveLocalProductsList(localProducts);
  }

  Future<void> _updateLocalProduct(Product product) async {
    final localProducts = await _getLocalProducts();
    final index = localProducts.indexWhere((p) => p.id == product.id);
    if (index != -1) {
      localProducts[index] = product;
      await _saveLocalProductsList(localProducts);
    }
  }

  Future<void> _deleteLocalProduct(int id) async {
    final localProducts = await _getLocalProducts();
    localProducts.removeWhere((p) => p.id == id);
    await _saveLocalProductsList(localProducts);
  }

  Future<void> _saveLocalProductsList(List<Product> products) async {
    final prefs = await SharedPreferences.getInstance();
    final productsJson = products.map((p) => jsonEncode(p.toJson())).toList();
    await prefs.setStringList(_localProductsKey, productsJson);
  }
}
