class Address {
  String city;
  String district;
  String street;
  String country;
  String address;

  Address({
    required this.city,
    required this.district,
    required this.street,
    required this.country,
    required this.address,
  });

  Address.fromJson(Map<String, dynamic> json)
      : city = json['city'],
        district = json['district'],
        street = json['street'],
        country = json['country'],
        address = json['address'];

  Map<String, dynamic> toJson() {
    return {
      'city': city,
      'district': district,
      'street': street,
      'country': country,
      'address': address,
    };
  }
}
