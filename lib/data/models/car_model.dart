class Car {
  late final int id;
  late final String model;
  late final String color;
  late final String year;
  late final String origin;
  late final String brand;
  late final String plateNumber;
  late final String image;
  Car(
      {required this.id,
      required this.model,
      required this.year,
      required this.plateNumber,
      required this.color,
      required this.origin,
      required this.brand,
      required this.image});
  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json['id'],
      model: json['model'],
      year: json['year'],
      plateNumber: json['plateNumber'],
      color: json['color'],
      origin: json['origin'],
      brand: json['brand'],
      image: json['image'],
    );
  }
}
