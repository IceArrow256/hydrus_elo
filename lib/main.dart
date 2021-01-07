import 'package:flutter/material.dart';

import 'package:hydrus_elo/pages/authorization.dart';

void main() {
  runApp(MaterialApp(initialRoute: '/authorization', routes: {
    '/authorization': (context) => Authorization(),
    // '/home': (context) => Home(),
    // '/location': (context) => ChooseLocation(),
  }));
}
