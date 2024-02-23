import 'package:auto_care/data/models/product.dart';
import 'package:auto_care/data/models/workshop.dart';

import 'car_model.dart';

class User {
  late final int id;
  late final String fullName;
  late final String phoneNumber;
  late final String password;
  late final String email;
  late final int age;
  late final String city;
  late final String address;
  late final String location;
  User(
      {required this.city,
      required this.id,
      required this.fullName,
      required this.phoneNumber,
      required this.password,
      required this.email,
      required this.age,
      required this.address,
      required this.location});
}

class CarOwner extends User {
  late final List<Car> userCars;
  late final List<Workshop> favorites;
  CarOwner({
    required super.id,
    required super.fullName,
    required super.phoneNumber,
    required super.password,
    required super.email,
    required super.age,
    required this.userCars,
    required super.location,
    required super.city,
    required super.address,
    required this.favorites,
  });
  factory CarOwner.fromJson(Map<String, dynamic> json) {
    return CarOwner(
      id: json['id'],
      fullName: json['fullName'],
      phoneNumber: json['phoneNumber'],
      password: json['password'],
      email: json['email'],
      age: json['age'],
      userCars: json['userCars'],
      location: json['location'],
      city: json['city'],
      address: json['address'],
      favorites: json['favorites'],
    );
  }
}

class TowCarOwner extends User {
  late final Car car;

  TowCarOwner({
    required super.id,
    required super.fullName,
    required super.phoneNumber,
    required super.email,
    required super.age,
    required this.car,
    required super.location,
    required super.password,
    required super.city,
    required super.address,
  });
  factory TowCarOwner.fromJson(Map<String, dynamic> json) {
    return TowCarOwner(
      id: json['id'],
      fullName: json['fullName'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      age: json['age'],
      car: json['car'],
      location: json['location'],
      password: json['password'],
      city: json['city'],
      address: json['address'],
    );
  }
}

class WorkshopOwner extends User {
  late final Workshop workshop;

  WorkshopOwner(
      {required super.id,
      required super.fullName,
      required super.phoneNumber,
      required super.email,
      required super.age,
      required super.location,
      required this.workshop,
      required super.password,
      required super.city,
      required super.address});
  factory WorkshopOwner.fromJson(Map<String, dynamic> json) {
    return WorkshopOwner(
      id: json['id'],
      fullName: json['fullName'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      age: json['age'],
      location: json['location'],
      workshop: json['workshop'],
      password: json['password'],
      city: json['city'],
      address: json['address'],
    );
  }
}

class PartsSupplier extends User {
  late final List<Product> products;
  PartsSupplier(
      {required super.id,
      required super.fullName,
      required super.phoneNumber,
      required super.email,
      required super.age,
      required super.location,
      required super.password,
      required super.city,
      required super.address,
      required this.products});
  factory PartsSupplier.fromJson(Map<String, dynamic> json) {
    return PartsSupplier(
      id: json['id'],
      fullName: json['fullName'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      age: json['age'],
      location: json['location'],
      password: json['password'],
      city: json['city'],
      address: json['address'],
      products: json['products'],
    );
  }
}
