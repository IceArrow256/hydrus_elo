import 'package:flutter/material.dart';
import 'package:hydrus_dart/hydrus_dart.dart';

void main() => runApp(
      MaterialApp(home: Home()),
    );

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String apiVersion = 'loading';

  void setupHydrus() async {
    var hydrus = Hydrus('');
    var result = await hydrus.getApiVersion();
    setState(() {
      apiVersion = result['version'].toString();
    });
  }

  @override
  void initState() {
    super.initState();
    setupHydrus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hydrus Elo'),
        centerTitle: true,
      ),
      body: Text('Hydrus Client API version: $apiVersion'),
    );
  }
}
