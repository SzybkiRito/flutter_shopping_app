class Rating {
  final double rate;
  final int count;

  Rating({required this.rate, required this.count});

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      rate: double.tryParse(json['rate'].toString()) ?? 0.0,
      count: json['count'] as int,
    );
  }
}
