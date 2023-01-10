import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:country_search/services/country.dart';

import '../models/country.dart';

class CountrySearchDelegate extends SearchDelegate<Country?> {
  @override
  // ignore: overridden_fields
  final String searchFieldLabel;
  final List<Country> historial;
  CountrySearchDelegate(
      {required this.searchFieldLabel, required this.historial});

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () => query = '', icon: const Icon(Icons.clear_outlined))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => close(context, null),
        icon: const Icon(Icons.arrow_back_ios));
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query.trim().isEmpty) {
      return const Text('no hay valor en el query');
    } else {
      final countryService = CountryService();
      return FutureBuilder(
        future: countryService.getCountryByName(query),
        builder: (_, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return _showCountries(snapshot.data);
          } else {
            return const Center(
                child: CircularProgressIndicator(strokeWidth: 4));
          }
        },
      );
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _showCountries(historial);
  }

  Widget _showCountries(List<Country> countries) {
    return ListView.builder(
      itemBuilder: (context, i) {
        final pais = countries[i];
        return ListTile(
          leading: Flag(
            flag: pais.flag,
          ),
          // leading: (pais.flag == null) ? SvgPicture.network(pais.flag, width: 45): const Text(''),
          title: Text(pais.name),
          subtitle: Text(pais.capital),
          trailing: Text(pais.alpha3Code),
          onTap: () => {close(context, pais)},
        );
      },
      itemCount: countries.length,
    );
  }
}

class Flag extends StatelessWidget {
  final dynamic flag;

  const Flag({super.key, this.flag});
  @override
  Widget build(BuildContext context) {
    if (flag != null) {
      return SvgPicture.network(flag, width: 45);
    } else {
      return const Text('');
    }
  }
}
