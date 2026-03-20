import 'package:flutter/material.dart';
import 'package:product_app/presentation/viewmodels/product_viewmodel.dart';
import 'package:product_app/presentation/viewmodels/product_state.dart';
import 'package:product_app/domain/entities/product.dart';
import 'package:product_app/data/repositories/simple_product_repository.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  late ProductViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    // Inicializar o ViewModel
    _viewModel = ProductViewModel(SimpleProductRepository());
    // Carregar os produtos da API
    _viewModel.loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Produtos'),
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        actions: [
          // Botão de refresh
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => _viewModel.loadProducts(),
            tooltip: 'Recarregar produtos',
          ),
          // Contador de favoritos
          ValueListenableBuilder<ProductState>(
            valueListenable: _viewModel.state,
            builder: (context, state, _) {
              return Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.red.withAlpha(100),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '❤️ ${state.favoriteCount}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: ValueListenableBuilder<ProductState>(
        valueListenable: _viewModel.state,
        builder: (context, state, _) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 64,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Erro ao carregar produtos',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    state.error!,
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: () => _viewModel.loadProducts(),
                    icon: const Icon(Icons.refresh),
                    label: const Text('Tentar Novamente'),
                  ),
                ],
              ),
            );
          }

          if (state.products.isEmpty) {
            return const Center(
              child: Text('Nenhum produto disponível'),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(8.0),
            itemCount: state.products.length,
            itemBuilder: (context, index) {
              final product = state.products[index];
              return ProductCard(
                product: product,
                onFavoritePressed: () {
                  _viewModel.toggleFavorite(product.id);
                },
              );
            },
          );
        },
      ),
    );
  }
}

// Widget para exibir cada produto
class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onFavoritePressed;

  const ProductCard({
    super.key,
    required this.product,
    required this.onFavoritePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Informações do produto
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'R\$ ${product.price.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
            ),
            // Botão de favorito
            IconButton(
              onPressed: onFavoritePressed,
              icon: Icon(
                product.favorite ? Icons.favorite : Icons.favorite_border,
                color: product.favorite ? Colors.red : Colors.grey,
                size: 32,
              ),
              tooltip: product.favorite ? 'Remover de favoritos' : 'Adicionar aos favoritos',
            ),
          ],
        ),
      ),
    );
  }
}
