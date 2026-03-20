import '../../domain/entities/product.dart';

class ProductState {
  final bool isLoading;
  final List<Product> products;
  final String? error;

  const ProductState({
    this.isLoading = false,
    this.products = const [],
    this.error,
  });

  // Obter quantidade de favoritos
  int get favoriteCount => products.where((p) => p.favorite).length;

  // Obter lista de produtos favoritos
  List<Product> get favorites => products.where((p) => p.favorite).toList();

  ProductState copyWith({
    bool? isLoading,
    List<Product>? products,
    String? error,
  }) {
    return ProductState(
      isLoading: isLoading ?? this.isLoading,
      products: products ?? this.products,
      error: error,
    );
  }
}
