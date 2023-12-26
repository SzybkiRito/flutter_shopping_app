import 'package:shopping_app/api/models/rating.dart';

class Product {
  final int id;
  final String title;
  final double price;
  final String description;
  final String image;
  final String category;
  final Rating rating;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.image,
    required this.category,
    required this.rating,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      title: json['title'] as String,
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      description: json['description'] as String,
      image: json['image'] as String,
      category: json['category'] as String,
      rating: Rating.fromJson(json['rating']),
    );
  }
}
