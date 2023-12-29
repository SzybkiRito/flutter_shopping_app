class ShoppingCart {
  final int id;
  final int userId;
  final int productId;
  final int quantity;

  ShoppingCart({
    required this.id,
    required this.userId,
    required this.productId,
    required this.quantity,
  });

  factory ShoppingCart.fromSqflite(Map<String, dynamic> json) {
    return ShoppingCart(
      id: json['id'] as int,
      userId: json['user_id'] as int,
      productId: json['product_id'] as int,
      quantity: json['quantity'] as int,
    );
  }

  factory ShoppingCart.toSqflite(Map<String, dynamic> json) {
    return ShoppingCart(
      id: json['id'] as int,
      userId: json['user_id'] as int,
      productId: json['product_id'] as int,
      quantity: json['quantity'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'product_id': productId,
      'quantity': quantity,
    };
  }
}
