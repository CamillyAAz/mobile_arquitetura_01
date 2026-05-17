class Product {
  final int id;
  final String title;
  final double price;
  final String thumbnail;
  final String description;
  final String category;
  final double rating;
  final int stock;
  bool favorite;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    String? thumbnail,
    String? image,
    this.rating = 0,
    this.stock = 0,
    this.favorite = false,
  }) : thumbnail = thumbnail ?? image ?? 'https://via.placeholder.com/300';

  String get image => thumbnail;

  Product copyWith({
    int? id,
    String? title,
    double? price,
    String? thumbnail,
    String? description,
    String? category,
    double? rating,
    int? stock,
    bool? favorite,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      thumbnail: thumbnail ?? this.thumbnail,
      description: description ?? this.description,
      category: category ?? this.category,
      rating: rating ?? this.rating,
      stock: stock ?? this.stock,
      favorite: favorite ?? this.favorite,
    );
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      title: json['title'] as String,
      price: (json['price'] as num).toDouble(),
      thumbnail: (json['thumbnail'] ?? json['image']) as String? ?? '',
      description: json['description'] as String? ?? 'Sem descricao',
      category: json['category'] as String? ?? 'Sem categoria',
      rating: (json['rating'] as num?)?.toDouble() ?? 0,
      stock: json['stock'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'thumbnail': thumbnail,
      'image': thumbnail,
      'description': description,
      'category': category,
      'rating': rating,
      'stock': stock,
    };
  }
}
