import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:searchcountry/country.dart';

class ApiService {
  static const String _baseUrl = 'https://api-ninjas.com/api/country';

  Future<Country> getCountryByName(String name) async {
    final response = await http.get(Uri.parse('$_baseUrl/$name'));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return Country.fromJson(json);
    } else {
      throw Exception('Failed to load country');
    }
  }
}
