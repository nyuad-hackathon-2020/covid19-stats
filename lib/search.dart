import 'package:covid19stats/api.dart';
import 'package:flutter/material.dart';

class CountrySearchDelegate extends SearchDelegate {
  Api _api;

  CountrySearchDelegate(this._api);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> countries = _api.stats.search(query);

    if (query.length == 0) {
      return Text("");
    }

    return ListView.builder(
      itemCount: countries.length,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            close(context, countries[index]);
          },
          title: Text(countries[index]),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildResults(context);
  }
}
