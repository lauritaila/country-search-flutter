import 'package:country_search/models/country.dart';
import 'package:country_search/search/country_search.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Country? paisSeleccionado;

  List<Country> historial = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (paisSeleccionado != null) Text(paisSeleccionado?.name),
            MaterialButton(
                color: Colors.pink,
                shape: const StadiumBorder(),
                elevation: 0,
                splashColor: Colors.transparent,
                child:
                    const Text('Buscar', style: TextStyle(color: Colors.white)),
                onPressed: () async {
                  final pais = await showSearch(
                      context: context,
                      delegate: CountrySearchDelegate(
                          searchFieldLabel: 'Buscar pais ...', historial: historial));
                  setState(() {
                    paisSeleccionado = pais;
                    historial.insert(0, pais!);
                  });
                })
          ],
        ),
      ),
    );
  }
}
