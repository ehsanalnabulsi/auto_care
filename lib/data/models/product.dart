class Product {
  late final int id;
  late final String title;
  late final String description;
  late final String image;
  late final String category;
  late final String code;
  late final double price;
  late final double rate;

  Product(
      {required this.category,
      required this.code,
      required this.description,
      required this.price,
      required this.id,
      required this.image,
      required this.title,
      required this.rate});
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
        category: json['category'],
        code: json['code'],
        description: json['description'],
        price: json['price'],
        id: json['id'],
        image: json['image'],
        title: json['title'],
        rate: json['rate']);
  }
}
