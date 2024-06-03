import 'package:cloud_firestore/cloud_firestore.dart';

class Favorites {
  Object id;
  Object userId;
  Object estateId;

  Favorites({
    required this.estateId,
    required this.userId,
    required this.id,
  });

  Favorites.fromJson(Map<String, Object?> json)
      : this(
            estateId: json['estateId'] as Object,
            id: json['id'] as Object,
            userId: json['userId'] as Object);

  Favorites copyWith({
    Object? estateId,
    Object? id,
    Object? userId,
  }) {
    return Favorites(
        estateId: estateId ?? this.estateId,
        userId: userId ?? this.userId,
        id: id ?? this.id);
  }

  Map<String, Object?> toJson() {
    return {
      'estateId': estateId,
      'id': id,
      'userId': userId,
    };
  }
}
