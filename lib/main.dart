import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Country Info App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Country Info'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final searchController = TextEditingController();
  var countryData;
  var countryCode;
  var flagUrl;

  void fetchCountryData(String countryName) async {
    var url = Uri.parse('https://restcountries.com/v3.1/name/$countryName');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      setState(() {
        countryData = jsonResponse[0];
        var countryCode = countryData['cca2'].toUpperCase();
        flagUrl = 'https://flagsapi.com/$countryCode/flat/64.png';
      });
    } else {
      setState(() {
        countryData = null;
        print(countryCode);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TextField(
              controller: searchController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter country name',
              ),
            ),
            const SizedBox(height: 16.0),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  fetchCountryData(searchController.text);
                },
                child: const Text('Search'),
              ),
            ),
            const SizedBox(height: 16.0),
            if (countryData != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  if (flagUrl != null)
                    Image.network(
                      flagUrl,
                      width: 100.0,
                      height: 60.0,
                      fit: BoxFit.contain,
                    ),
                  Text('Name: ${countryData['name']['common']}'),
                  Text('Capital: ${countryData['capital'][0]}'),
                  Text('Region: ${countryData['region']}'),
                  Text('Subregion: ${countryData['subregion']}'),
                  Text('Population: ${countryData['population']}'),
                  Text('Area: ${countryData['area']} km²'),
                ],
              ),
            if (countryData == null)
              const Text('No country found with that name'),
          ],
        ),
      ),
    );
  }
}
