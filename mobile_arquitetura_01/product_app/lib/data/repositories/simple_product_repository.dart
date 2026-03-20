import 'package:product_app/domain/entities/product.dart';
import 'package:product_app/domain/repositories/product_repository.dart';

class SimpleProductRepository implements ProductRepository {
  @override
  Future<List<Product>> getProducts() async {
    // Simulando uma chamada assíncrona
    await Future.delayed(const Duration(milliseconds: 500));
    return [];
  }
}
