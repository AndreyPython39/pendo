class Gift {
  final int id;
  final String name;
  final String description;
  final String imageUrl;
  final int price;
  final bool isPremium;
  final bool isAnimated;

  Gift({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.isPremium,
    required this.isAnimated,
  });

  factory Gift.fromJson(Map<String, dynamic> json) {
    return Gift(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['image_url'],
      price: json['price'],
      isPremium: json['is_premium'],
      isAnimated: json['is_animated'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image_url': imageUrl,
      'price': price,
      'is_premium': isPremium,
      'is_animated': isAnimated,
    };
  }
}
