import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:real_estate/models/address.dart';
import 'address.dart';

class House {
  Address address;
  double squaremeter;
  int numberOfRooms;
  int numberOfHalls;
  int numberOfBaths;
  int buildingAge;
  int numberOfFloors;
  int floorOn;
  double? grossArea;
  double? terraceArea;
  double price;
  List<String> facade;
  List<String> landscape;
  String? heating;
  List<String> opportunities;

  House({
    required this.address,
    required this.squaremeter,
    required this.numberOfRooms,
    required this.numberOfHalls,
    required this.numberOfBaths,
    required this.buildingAge,
    required this.numberOfFloors,
    required this.floorOn,
    this.grossArea,
    this.terraceArea,
    required this.price,
    required this.facade,
    required this.landscape,
    this.heating,
    required this.opportunities,
  });

  House.fromJson(Map<String, dynamic?> json)
      : this(
    address: Address.fromJson(json['address'] as Map<String, dynamic>),
    squaremeter: json['squaremeter']! as double,
    numberOfRooms: json['numberOfRooms']! as int,
    numberOfHalls: json['numberOfHalls']! as int,
    numberOfBaths: json['numberOfBaths']! as int,
    numberOfFloors: json['numberOfFloors']! as int,
    buildingAge: json['buildingAge']! as int,
    floorOn: json['floorOn']! as int,
    grossArea: json['grossArea']! as double?,
    terraceArea: json['terraceArea']! as double?,
    price: json['price']! as double,
    facade: (json['facade'] as List<dynamic>).cast<String>(),
    landscape: (json['landscape'] as List<dynamic>).cast<String>(),
    heating: json['heating'] as String?,
    opportunities: (json['opportunities'] as List<dynamic>).cast<String>(),
  );

  Map<String, dynamic> toJson() {
    return {
      'address': address.toJson(),
      'squaremeter': squaremeter,
      'numberOfRooms': numberOfRooms,
      'numberOfHalls': numberOfHalls,
      'numberOfBaths': numberOfBaths,
      'numberOfFloors': numberOfFloors,
      'buildingAge': buildingAge,
      'floorOn': floorOn,
      'grossArea': grossArea,
      'terraceArea': terraceArea,
      'price': price,
      'facade': facade,
      'landscape': landscape,
      'heating': heating,
      'opportunities': opportunities,
    };
  }
}
