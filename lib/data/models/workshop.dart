import 'package:auto_care/data/models/car_model.dart';

class Workshop {
  late final int workshopId;
  late final String workshopName;
  late final String workshopImage;
  late final List<Car> currentCars;
  late final String contactNumber;
  late final String specialist;
  late final String origin;
  late final List<String> brands;
  late final String workshopLocation;

  Workshop(
      {required this.workshopId,
      required this.workshopLocation,
      required this.brands,
      required this.contactNumber,
      required this.currentCars,
      required this.origin,
      required this.specialist,
      required this.workshopName,
      required this.workshopImage});
  factory Workshop.fromJson(Map<String, dynamic> json) {
    return Workshop(
        workshopId: json['workshopId'],
        brands: json['brands'],
        contactNumber: json['contactNumber'],
        currentCars: json['currentCars'],
        origin: json['origin'],
        specialist: json['specialist'],
        workshopName: json['workshopName'],
        workshopImage: json['workshopImage'],
        workshopLocation: json['workshopLocation']);
  }
}
