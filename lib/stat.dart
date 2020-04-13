import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Stat extends StatelessWidget {
  final Map<String, dynamic> data;

  Stat(this.data);

  @override
  Widget build(BuildContext context) {
    NumberFormat formatter = NumberFormat('#,###', 'en_US');

    String date = data.containsKey("Date") ? data["Date"] : "Unknown";
    int newConfirmed = data.containsKey("NewConfirmed") ? data["NewConfirmed"] : 0;
    int newRecovered = data.containsKey("NewRecovered") ? data["NewRecovered"] : 0;
    int totalConfirmed = data.containsKey("TotalConfirmed") ? data["TotalConfirmed"] : 0;
    int totalRecovered = data.containsKey("TotalRecovered") ? data["TotalRecovered"] : 0;

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Last updated at: $date"),
          ),
          _buildNumberCard(
              formatter.format(newConfirmed), TextStyle(fontSize: 50), "New Confirmed", TextStyle(fontSize: 30)),
          _buildNumberCard(
              formatter.format(newRecovered), TextStyle(fontSize: 50), "New Recovered", TextStyle(fontSize: 30)),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                _buildNumberCard(formatter.format(totalConfirmed), TextStyle(fontSize: 30), "Total Confirmed",
                    TextStyle(fontSize: 20), false),
                _buildNumberCard(formatter.format(totalRecovered), TextStyle(fontSize: 30), "Total Recovered",
                    TextStyle(fontSize: 20), false),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildNumberCard(String number, TextStyle numberStyle, String label, TextStyle labelStyle,
      [bool stretch = true]) {
    return Expanded(
      child: Card(
        child: Column(
          crossAxisAlignment: stretch ? CrossAxisAlignment.stretch : CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Text(
              number,
              textAlign: TextAlign.center,
              style: numberStyle,
            ),
            Text(
              label,
              textAlign: TextAlign.center,
              style: labelStyle,
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
