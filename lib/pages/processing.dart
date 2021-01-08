import 'package:flutter/material.dart';

import 'package:hydrus_dart/hydrus_dart.dart';

class Processing extends StatefulWidget {
  @override
  _ProcessingState createState() => _ProcessingState();
}

class _ProcessingState extends State<Processing> {
  Map data = {};
  Hydrus client;

  @override
  void initState() {
    super.initState();
  }

  void searchFiles() async {
    print(data);
    client = Hydrus(data['accessKey'], data['address']);
    print(await client.searchFiles(tags: []));
  }

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    searchFiles();
    return Container();
  }
}
