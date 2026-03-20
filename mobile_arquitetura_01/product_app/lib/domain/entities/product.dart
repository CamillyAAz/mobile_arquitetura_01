class Product {
  final int id;
  final String title;
  final double price;
  final String image;
  bool favorite;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
    this.favorite = false,
  });

  // Criar uma cópia do produto com campos atualizados
  Product copyWith({
    int? id,
    String? title,
    double? price,
    String? image,
    bool? favorite,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      image: image ?? this.image,
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
    );
  }

  // Converter produto para JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'image': image,
    };
  }
}
