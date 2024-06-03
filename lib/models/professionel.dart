class Professional {
  final String name;
  final String phone;
  final String photo;
  final String place;
  final int score;
  final String bio;

  Professional({
    required this.name,
    required this.phone,
    required this.photo,
    required this.place,
    required this.score,
    required this.bio,
  });

  factory Professional.fromFirestore(Map<String, dynamic> data) {
    return Professional(
      name: data['name']?.toString() ?? '',
      phone: data['phone']?.toString() ?? '',
      photo: data['photo']?.toString() ?? '',
      place: data['place']?.toString() ?? '',
      score: data['score'] is int
          ? data['score']
          : int.tryParse(data['score']?.toString() ?? '0') ?? 0,
      bio: data['bio']?.toString() ?? '',
    );
  }
}
