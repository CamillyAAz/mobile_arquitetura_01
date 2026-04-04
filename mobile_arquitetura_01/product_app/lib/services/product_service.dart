import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/product.dart';

class ProductService {
  static const String _baseUrl = 'https://fakestoreapi.com';
  static const String _favoritesKey = 'favorite_product_ids';
  static const String _localProductsKey = 'local_products';

  Future<List<Product>> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/products'));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        final apiProducts = jsonData.map((json) => Product.fromJson(json)).toList();

        // Carregar produtos locais (criados/editados)
        final localProducts = await _getLocalProducts();

        // Combinar produtos da API com locais
        final allProducts = [...apiProducts, ...localProducts];

        // Carregar favoritos
        final favoriteIds = await getFavoriteIds();
        return allProducts.map((product) {
          return product.copyWith(favorite: favoriteIds.contains(product.id));
        }).toList();
      } else {
        throw Exception('Falha ao carregar produtos: ${response.statusCode}');
      }
    } catch (e) {
      // Em caso de erro, tentar retornar apenas produtos locais
      final localProducts = await _getLocalProducts();
      final favoriteIds = await getFavoriteIds();
      return localProducts.map((product) {
        return product.copyWith(favorite: favoriteIds.contains(product.id));
      }).toList();
    }
  }

  Future<Product> addProduct(Product product) async {
    // Simular criação local (já que API não suporta)
    final newProduct = product.copyWith(id: DateTime.now().millisecondsSinceEpoch);
    await _saveLocalProduct(newProduct);
    return newProduct;
  }

  Future<Product> updateProduct(Product product) async {
    // Simular atualização local
    await _updateLocalProduct(product);
    return product;
  }

  Future<void> deleteProduct(int id) async {
    // Simular exclusão local
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
    await prefs.setStringList(_favoritesKey, ids.map((id) => id.toString()).toList());
  }

  // Métodos auxiliares para persistência local
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