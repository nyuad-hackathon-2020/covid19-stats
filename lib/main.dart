import 'package:covid19stats/api.dart';
import 'package:covid19stats/search.dart';
import 'package:covid19stats/stat.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

void main() {
  getIt.registerSingleton<Api>(Api());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'COVID-19 Stats',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Stats _stats;
  Map<String, dynamic> _stat;

  @override
  void initState() {
    super.initState();

    getIt.get<Api>().fetch().then((Stats stats) {
      _stats = stats;

      setState(() {
        _stat = stats.getStat("Global");
      });
    }, onError: (error) {
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_stats == null) {
      return Scaffold(
          appBar: AppBar(title: Text("Global")),
          body: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[CircularProgressIndicator()],
          )));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_stat.containsKey("Country") ? _stat['Country'] : "Global"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: CountrySearchDelegate(getIt.get<Api>()),
              ).then((country) {
                setState(() {
                  _stat = _stats.getStat(country);
                  if (_stat == null) {
                    _stat = _stats.getStat("Global");
                  }
                });
              });
            },
          ),
        ],
      ),
      body: Center(child: Stat(_stat)),
    );
  }
}
