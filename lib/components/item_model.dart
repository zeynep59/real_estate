class Item{
  String? title;
  String? category;
  String? thumb_url;
  String? location;
  double? price;

  Item(this.title, this.category, this.location, this.price, this.thumb_url);

  static List<Item> recommendatiton = [
    Item("Modern House for Renting", "House", "Georgia, USA", 2500,
    "https://images.pexels.com/photos/106399/pexels-photo-106399.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
    Item("Big Villa", "Villa", "Miami, Usa", 3000,
    "https://images.pexels.com/photos/5563472/pexels-photo-5563472.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
    Item("Small House", "House", "Wesex, London", 1500,
    "https://images.pexels.com/photos/1029599/pexels-photo-1029599.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
    Item("Luxios Apartment", "Apartment", "New York, Usa", 800,
    "https://images.pexels.com/photos/19168623/pexels-photo-19168623/free-photo-of-balconies-in-an-apartment-building.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1")
  ];
  static List<Item> nearby = [
    Item("Student Apartment", "Apartment", "Georgia, USA", 2500,
        "https://images.pexels.com/photos/129494/pexels-photo-129494.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
    Item("Small Villa", "Villa", "Miami, Usa", 3000,
        "https://images.pexels.com/photos/5563472/pexels-photo-5563472.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
    Item("Family House", "House", "Wesex, London", 1500,
        "https://images.pexels.com/photos/1029599/pexels-photo-1029599.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
    Item("Provience House", "House", "New York, Usa", 800,
        "https://images.pexels.com/photos/19168623/pexels-photo-19168623/free-photo-of-balconies-in-an-apartment-building.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1")
  ];



}