class Country {
  final String name;
  final String capital;
  final String region;
  final String subregion;
  final String population;
  final String area;

  Country(
      {required this.name,
      required this.capital,
      required this.region,
      required this.subregion,
      required this.population,
      required this.area});

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name'] ?? '',
      capital: json['capital'] ?? '',
      region: json['region'] ?? '',
      subregion: json['subregion'] ?? '',
      population: json['population'] ?? '',
      area: json['area'] ?? '',
    );
  }
}
