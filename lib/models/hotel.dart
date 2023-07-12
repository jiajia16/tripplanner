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
        id: json['properties'][0]['id'],
        name: json['properties'][0]['name'],
        propertyImage: json['properties'][0]['propertyImage']['image']['url'],
        price: json['properties'][0]['price']['lead']['formatted']
            ['formattedDisplayPrice'],
        reviewScore: json['properties'][0]['reviews']['score']);
  }

  //TODO implement Hotel.fromJson
}
