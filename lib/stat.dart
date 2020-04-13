import 'package:flutter/material.dart';

class Stat extends StatelessWidget {
  final Map<String, dynamic> data;

  Stat(this.data);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text("New Confirmed: " + (data.containsKey("NewConfirmed") ? data["NewConfirmed"] : 0).toString()),
        Text("TotalConfirmed: " + (data.containsKey("TotalConfirmed") ? data["TotalConfirmed"] : 0).toString()),
      ],
    );
  }
}
