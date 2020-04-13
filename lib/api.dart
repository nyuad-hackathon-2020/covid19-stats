import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

class Api {
  static const ENDPOINT = "https://api.covid19api.com/summary";

  /// The stats
  Stats _stats;

  Stats get stats => _stats;

  /// Fetch the data
  Future<Stats> fetch() async {
    final response = await http.get(ENDPOINT);

    if (response.statusCode == 200) {
      _stats = Stats(json.decode(response.body));
      return _stats;
    } else {
      throw Exception('Failed to load stats');
    }
  }
}

class Stats {
  final Map<String, dynamic> response;

  Stats(this.response);

  /// Search countries by [prefix]
  List<String> search(String prefix) {
    List<String> countries = [];

    prefix = prefix.toLowerCase();

    if (response.containsKey("Countries")) {
      response["Countries"].forEach((country) {
        if (!country.containsKey("Country")) {
          return;
        }

        String name = country["Country"];
        if (name.toLowerCase().startsWith(prefix)) {
          countries.add(name);
        }
      });
    }

    return countries;
  }

  /// Get stat by country name
  Map<String, dynamic> getStat(String name) {
    if (name == "Global" && response.containsKey("Global")) {
      return response["Global"];
    }

    if (!response.containsKey("Countries")) {
      return null;
    }

    return response["Countries"].where((country) {
      if (!country.containsKey("Country")) {
        return false;
      }

      return name == country["Country"];
    });
  }
}
