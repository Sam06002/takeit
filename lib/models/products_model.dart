class Product {
  final String productId;
  final String name;
  final String description;
  final bool? available;
  final String? category;
  final String? image;
  final int price;

  Product(
      {required this.productId,
      required this.name,
      required this.description,
      required this.available,
      required this.category,
      required this.image,
      required this.price});

  factory Product.fromMap(Map<String, dynamic> json) {
    return Product(
        productId: json['productId'],
        name: json['name'],
        description: json['description'],
        available: json['available'],
        category: json['category'],
        image: json['image'],
        price: json['price']);
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'name': name,
      'description': description,
      'available': available,
      'category': category,
      'image': image,
      'price': price,
    };
  }
}
