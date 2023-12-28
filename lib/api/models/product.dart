import 'package:shopping_app/api/models/rating.dart';

class Product {
  final int id;
  final String title;
  final double price;
  final String description;
  final String image;
  final String category;
  final Rating rating;
  final bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.image,
    required this.category,
    required this.rating,
    required this.isFavorite,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    bool parseBoolFromNumber(int number) {
      return number == 1;
    }

    return Product(
      id: json['id'] as int,
      title: json['title'] as String,
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      description: json['description'] as String,
      image: json['image'] as String,
      category: json['category'] as String,
      rating: Rating.fromJson(json['rating']),
      isFavorite: json.containsKey('isFavorite') ? parseBoolFromNumber(json['isFavorite']) : false,
    );
  }

  factory Product.fromSqflite(Map<String, dynamic> json) {
    bool parseBoolFromNumber(int number) {
      return number == 1;
    }

    return Product(
      id: json['id'] as int,
      title: json['title'] as String,
      price: double.tryParse(json['price'].toString()) ?? 0.0,
      description: json['description'] as String,
      image: json['image'] as String,
      category: json['category'] as String,
      rating: Rating(rate: json['ratingRate'] as double, count: json['ratingCount'] as int),
      isFavorite: json.containsKey('isFavorite') ? parseBoolFromNumber(json['isFavorite']) : false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'image': image,
      'category': category,
      'ratingRate': rating.rate,
      'ratingCount': rating.count,
      'isFavorite': isFavorite,
    };
  }
}
