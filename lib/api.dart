import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

class Api {
  static const ENDPOINT = "https://api.covid19api.com/summary";

  static const FIXTURE =
      '{"Global":{"NewConfirmed":75176,"TotalConfirmed":1845470,"NewDeaths":5588,"TotalDeaths":114064,"NewRecovered":19595,"TotalRecovered":420872},"Countries":[{"Country":"ALA Aland Islands","CountryCode":"AX","Slug":"ala-aland-islands","NewConfirmed":0,"TotalConfirmed":0,"NewDeaths":0,"TotalDeaths":0,"NewRecovered":0,"TotalRecovered":0,"Date":"2020-04-13T14:02:36Z"}]}';

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

//    _stats = Stats(json.decode(FIXTURE));
//    return _stats;
  }
}

class Stats {
  final Map<String, dynamic> response;

  Stats(this.response);

  /// Search countries by [prefix]
  List<String> search(String prefix) {
    List<String> countries = [];

    prefix = prefix.toLowerCase();

    if ("global".startsWith(prefix)) {
      countries.add("Global");
    }

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

    return response["Countries"].firstWhere((country) {
      if (!country.containsKey("Country")) {
        return false;
      }

      return name == country["Country"];
    });
  }
}
