import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String name;
  String lastName;
  bool isAdmin;
  Timestamp? createdOn;
  String? phoneNumber;
  String email;
  Object id;

  User({
    required this.id,
    required this.email,
    required this.name,
    required this.lastName,
    required this.isAdmin,
    this.createdOn,
    this.phoneNumber,
  });

  User.fromJson(Map<String, Object?> json)
      : this(
          id: json['id']! as Object,
          email: json['email']! as String,
          name: json['name']! as String,
          lastName: json['lastName']! as String,
          createdOn: json['createdOn']! as Timestamp,
          isAdmin: json['isAdmin']! as bool,
          phoneNumber: json['phoneNumber']! as String,
        );

  User copyWith({
    String? name,
    String? lastName,
    bool? isAdmin,
    Timestamp? createdOn,
    String? phoneNumber,
    String? email,
    Object? id,
  }) {
    return User(
        id: id ?? this.id,
        email: email ?? this.email,
        name: name ?? this.email,
        lastName: lastName ?? this.lastName,
        isAdmin: isAdmin ?? this.isAdmin);
  }

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'lastName': lastName,
      'isAdmin': isAdmin,
      'createdOn': createdOn,
      'phoneNumber': phoneNumber,
    };
  }
}
