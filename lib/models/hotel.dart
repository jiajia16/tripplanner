class Hotel {
  final String id;
  final String name;
  final String propertyImage;
  final String price;
  final num reviewScore;

  Hotel({
    required this.id,
    required this.name,
    required this.propertyImage,
    required this.price,
    required this.reviewScore,
  });

  factory Hotel.fromJson(Map<String, dynamic> json) {
    return Hotel(
        id: json['id'],
        name: json['name'],
        propertyImage: json['propertyImage']['image']['url'],
        price: json['price']['lead']['formatted'],
        reviewScore: json['reviews']['score']);
  }

  //TODO implement Hotel.fromJson
}
