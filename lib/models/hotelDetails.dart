class HotelDetails {
  final String id;
  final String name;
  final num rating;
  final String address;
  final String whatsAround;
  final String mapUrl;
  final String tagline;
  final String propertyImageTwo;
  final String propertyImageThree;
  final String propertyImageFour;
  final String propertyImageFive;

  HotelDetails({
    required this.id,
    required this.name,
    required this.rating,
    required this.address,
    required this.whatsAround,
    required this.mapUrl,
    required this.tagline,
    required this.propertyImageTwo,
    required this.propertyImageThree,
    required this.propertyImageFour,
    required this.propertyImageFive,
  });
  factory HotelDetails.fromJson(Map<String, dynamic> json) {
    bool flag = false;
    if (json['summary']['overview']['propertyRating'] == null) flag = true;

    return HotelDetails(
      id: json['summary']['id'],
      name: json['summary']['name'],
      rating:
          flag ? 0.0 : json['summary']['overview']['propertyRating']['rating'],
      address: json['summary']['location']['address']['addressLine'],
      whatsAround: json['summary']['location']['whatsAround']['editorial']
          ['content'][0],
      mapUrl: json['summary']['location']['staticImage']['url'],
      tagline: json['summary']['tagline'],
      propertyImageTwo: json['propertyGallery']['images'][3]['image']['url'],
      propertyImageThree: json['propertyGallery']['images'][2]['image']['url'],
      propertyImageFour: json['propertyGallery']['images'][6]['image']['url'],
      propertyImageFive: json['propertyGallery']['images'][8]['image']['url'],
    );
  }

  //TODO implement HotelDetails.fromJson
}
