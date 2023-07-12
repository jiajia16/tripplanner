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
    print(json['hierarchyInfo']['country']['name']);
    return Region(
        regionId: json['gaiaId'],
        regionName: json['regionNames']['shortName'],
        country: json['hierarchyInfo']['country']['name']);
  }

  //TODO implement Region.fromJson
}
