class HotelDetails {
  final String id;
  final String name;
  final num rating;
  final String address;
  final String whatsAround;
  final String mapUrl;

  HotelDetails({
    required this.id,
    required this.name,
    required this.rating,
    required this.address,
    required this.whatsAround,
    required this.mapUrl,
  });
  factory HotelDetails.fromJson(Map<String, dynamic> json) {
    return HotelDetails(
        id: json['summary']['id'],
        name: json['summary']['name'],
        rating: json['summary']['overview']['propertyRating']['rating'],
        address: json['summary']['location']['address']['addressLine'],
        whatsAround: json['summary']['location']['whatsAround']['editorial']
            ['content'][0],
        mapUrl: json['summary']['staticImage']['url']);
  }

  //TODO implement HotelDetails.fromJson
}
