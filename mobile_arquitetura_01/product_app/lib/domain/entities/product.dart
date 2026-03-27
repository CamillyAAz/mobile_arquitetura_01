class Product {
  final int id;
  final String title;
  final double price;
  final String image;
  final String description;
  final String category;
  bool favorite;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
    required this.description,
    required this.category,
    this.favorite = false,
  });

  // Criar uma cópia do produto com campos atualizados
  Product copyWith({
    int? id,
    String? title,
    double? price,
    String? image,
    String? description,
    String? category,
    bool? favorite,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      image: image ?? this.image,
      description: description ?? this.description,
      category: category ?? this.category,
      favorite: favorite ?? this.favorite,
    );
  }

  // Criar produto a partir de JSON da API
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      title: json['title'] as String,
      price: (json['price'] as num).toDouble(),
      image: json['image'] as String,
      description: json['description'] as String? ?? 'Sem descrição',
      category: json['category'] as String? ?? 'Sem categoria',
    );
  }

  // Converter produto para JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'image': image,
      'description': description,
      'category': category,
    };
  }
}
