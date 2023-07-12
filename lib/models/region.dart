class Region {
  final String regionId;
  final String regionName;
  final String country;

  Region({
    required this.regionId,
    required this.regionName,
    required this.country,
  });

  factory Region.fromJson(Map<String, dynamic> json) {
    return Region(
        regionId: json['data'][0]['gaiaId'],
        regionName: json['data']['0']['regionNames']['shortName'],
        country: json['data'][0]['hierarchyInfo']['country']['name']);
  }

  //TODO implement Region.fromJson
}
