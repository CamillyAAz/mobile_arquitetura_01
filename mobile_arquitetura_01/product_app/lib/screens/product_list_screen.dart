import 'package:flutter/material.dart';

import '../models/product.dart';
import '../services/product_service.dart';
import '../session/session_controller.dart';
import '../widgets/product_card.dart';
import 'login_screen.dart';
import 'product_detail_screen.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final ProductService _service = ProductService();
  final TextEditingController _searchController = TextEditingController();
  List<Product> _products = [];
  List<Product> _filteredProducts = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);

    if (!SessionController.instance.isLoggedIn) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _goToLogin());
      return;
    }

    _loadProducts();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _goToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  Future<void> _loadProducts() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final products = await _service.fetchProducts();
      if (!mounted) return;
      setState(() {
        _products = products;
        _applySearch();
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  void _onSearchChanged() {
    setState(_applySearch);
  }

  void _applySearch() {
    final query = _searchController.text.toLowerCase();
    if (query.isEmpty) {
      _filteredProducts = _products;
      return;
    }

    _filteredProducts = _products.where((product) {
      return product.title.toLowerCase().contains(query) ||
          product.description.toLowerCase().contains(query) ||
          product.category.toLowerCase().contains(query);
    }).toList();
  }

  Future<void> _toggleFavorite(Product product) async {
    final updatedProducts = _products.map((p) {
      if (p.id == product.id) {
        return p.copyWith(favorite: !p.favorite);
      }
      return p;
    }).toList();

    setState(() {
      _products = updatedProducts;
      _applySearch();
    });

    final favoriteIds = updatedProducts
        .where((p) => p.favorite)
        .map((p) => p.id)
        .toList();
    await _service.saveFavoriteIds(favoriteIds);
  }

  void _logout() {
    SessionController.instance.logout();
    _goToLogin();
  }

  int get _favoriteCount => _products.where((p) => p.favorite).length;

  @override
  Widget build(BuildContext context) {
    final user = SessionController.instance.user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Produtos'),
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadProducts,
            tooltip: 'Recarregar produtos',
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Center(
              child: Text(
                'Favoritos: $_favoriteCount',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          if (user != null) ...[
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Center(
                child: Text(
                  user.fullName.isEmpty ? user.username : user.fullName,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 4),
              child: CircleAvatar(
                radius: 16,
                backgroundImage: user.image.isNotEmpty
                    ? NetworkImage(user.image)
                    : null,
                child: user.image.isEmpty
                    ? const Icon(Icons.person, size: 18)
                    : null,
              ),
            ),
          ],
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _logout,
            tooltip: 'Sair',
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Pesquisar produtos...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 64),
              const SizedBox(height: 16),
              Text(
                'Erro ao carregar produtos',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                _error!,
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: _loadProducts,
                icon: const Icon(Icons.refresh),
                label: const Text('Tentar novamente'),
              ),
            ],
          ),
        ),
      );
    }

    if (_filteredProducts.isEmpty) {
      return Center(
        child: Text(
          _searchController.text.isEmpty
              ? 'Nenhum produto disponivel'
              : 'Nenhum produto encontrado para "${_searchController.text}"',
          textAlign: TextAlign.center,
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadProducts,
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: _filteredProducts.length,
        itemBuilder: (context, index) {
          final product = _filteredProducts[index];
          return ProductCard(
            product: product,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ProductDetailScreen(productId: product.id),
                ),
              );
            },
            onFavoritePressed: () => _toggleFavorite(product),
          );
        },
      ),
    );
  }
}
