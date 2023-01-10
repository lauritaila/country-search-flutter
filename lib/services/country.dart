import 'package:country_search/models/country.dart';
import 'package:dio/dio.dart';

class CountryService {
  Future getCountryByName(String name) async {
    try {
      var resp = await Dio().get('https://restcountries.com/v2/name/$name');

      final List<dynamic> countryList = resp.data;
      return countryList.map((obj) => Country.fromJson(obj)).toList();
    } catch (e) {
      // ignore: avoid_print
      print(e);
      return [];
    }
  }
}
