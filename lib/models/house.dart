import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:real_estate/models/address.dart';

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
  Object id;
  String? facade;
  String? landscape;
  String? heating;
  String? opportunities;

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
    required this.id,
    this.facade,
    this.landscape,
    this.heating,
    this.opportunities,
  });

  House.fromJson(Map<String, Object?> json)
      : this(
          address: json['address'] as Address,
          squaremeter: json['squaremeter']! as double,
          numberOfRooms: json['numberOfRooms'] as int,
          numberOfHalls: json['numberOfHalls'] as int,
          numberOfBaths: json['numberOfBaths'] as int,
          numberOfFloors: json['numberOfFloors'] as int,
          buildingAge: json['buildingAge'] as int,
          floorOn: json['floorOn'] as int,
          grossArea: json['grossArea'] as double,
          terraceArea: json['terraceArea'] as double,
          price: json['price'] as double,
          id: json['id'] as Object,
          facade: json['facade'] as String,
          landscape: json['landscape'] as String,
          heating: json['heating'] as String,
          opportunities: json['opportunities'] as String,
        );

  House copyWith({
    Address? address,
    double? squaremeter,
    int? numberOfRooms,
    int? numberOfHalls,
    int? numberOfBaths,
    int? buildingAge,
    int? floorOn,
    double? grossArea,
    double? terraceArea,
    double? price,
    Object? id,
    String? facade,
    String? landscape,
    String? heating,
    String? opportunities,
  }) {
    return House(
        address: address ?? this.address,
        squaremeter: squaremeter ?? this.squaremeter,
        numberOfRooms: numberOfRooms ?? this.numberOfRooms,
        numberOfHalls: numberOfHalls ?? this.numberOfHalls,
        numberOfBaths: numberOfBaths ?? this.numberOfBaths,
        buildingAge: buildingAge ?? this.buildingAge,
        numberOfFloors: numberOfFloors ?? this.numberOfFloors,
        floorOn: floorOn ?? this.floorOn,
        price: price ?? this.price,
        id: id ?? this.id,
        grossArea: grossArea ?? this.grossArea,
        terraceArea: terraceArea ?? this.terraceArea,
        facade: facade ?? this.facade,
        landscape: landscape ?? this.landscape,
        heating: heating ?? this.heating,
        opportunities: opportunities ?? this.opportunities);
  }

  Map<String, Object?> toJson() {
    return {
      'address': address,
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
      'id': id,
      'facade': facade,
      'landscape': landscape,
      'heating': heating,
      'opportunities': opportunities,
    };
  }
}
