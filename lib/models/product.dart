class Product {
  final int id;
  final String title;
  final String? description;
  final double price;

  final String? thumbnail;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,

    required this.thumbnail,
  });

  // Factory method to create a Product from JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],

      description: json['description'],
      price: json['price'].toDouble(),

      thumbnail: json['thumbnail'],
    );
  }

  // Method to convert Product to JSON (if needed)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'price': price,

      'thumbnail': thumbnail,
    };
  }
}
