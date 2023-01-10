class Country {
  final dynamic name;
  final dynamic alpha3Code;
  final dynamic capital;
  final dynamic flag;

  Country({required this.name,required this.alpha3Code,required this.capital, required this.flag});

  static Country fromJson(Map json) {
    return Country(
      name: json['name'],
      alpha3Code: json['alpha3Code'],
      capital: json['capital'],
      flag: json['flag'],
    );
  }
  @override
  String toString() {
    return 'Intance of Country: $name';
  }
} 
