import 'dart:async';
import 'package:flutter/material.dart';
import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import 'product_state.dart';

class ProductViewModel {
  final ProductRepository repository;
  final ValueNotifier<ProductState> state = ValueNotifier(const ProductState());

  ProductViewModel(this.repository);

  Future<void> loadProducts() async {
    state.value = state.value.copyWith(isLoading: true, error: null);
    try {
      final products = await repository.getProducts();
      state.value = state.value.copyWith(isLoading: false, products: products);
    } catch (e) {
      state.value = state.value.copyWith(isLoading: false, error: e.toString());
    }
  }

  // Carregar produtos iniciais com dados mock
  void loadInitialProducts() {
    final initialProducts = [
      Product(
        id: 1,
        title: 'Notebook',
        price: 3500,
        image: 'assets/notebook.png',
        description: 'Notebook rápido e leve para tarefas diárias.',
        category: 'Eletrônicos',
      ),
      Product(
        id: 2,
        title: 'Mouse',
        price: 120,
        image: 'assets/mouse.png',
        description: 'Mouse ergonômico com alta precisão.',
        category: 'Periféricos',
      ),
      Product(
        id: 3,
        title: 'Teclado',
        price: 250,
        image: 'assets/keyboard.png',
        description: 'Teclado mecânico com iluminação RGB.',
        category: 'Periféricos',
      ),
      Product(
        id: 4,
        title: 'Monitor',
        price: 900,
        image: 'assets/monitor.png',
        description: 'Monitor 24" Full HD com cores vibrantes.',
        category: 'Eletrônicos',
      ),
    ];
    state.value = state.value.copyWith(products: initialProducts);
  }

  // Alternar favorito de um produto
  void toggleFavorite(int productId) {
    final updatedProducts = state.value.products.map((product) {
      if (product.id == productId) {
        return product.copyWith(favorite: !product.favorite);
      }
      return product;
    }).toList();
    state.value = state.value.copyWith(products: updatedProducts);
  }

  // Marcar produto como favorito
  void setFavorite(int productId, bool isFavorite) {
    final updatedProducts = state.value.products.map((product) {
      if (product.id == productId) {
        return product.copyWith(favorite: isFavorite);
      }
      return product;
    }).toList();
    state.value = state.value.copyWith(products: updatedProducts);
  }

  // Adicionar novo produto
  void addProduct(Product product) {
    final updatedProducts = [...state.value.products, product];
    state.value = state.value.copyWith(products: updatedProducts);
  }

  // Remover produto
  void removeProduct(int productId) {
    final updatedProducts =
        state.value.products.where((p) => p.id != productId).toList();
    state.value = state.value.copyWith(products: updatedProducts);
  }
}
