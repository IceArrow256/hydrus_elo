import 'package:flutter/material.dart';

import 'package:hydrus_elo/pages/authorization.dart';
import 'package:hydrus_elo/pages/processing.dart';

void main() {
  runApp(MaterialApp(initialRoute: '/authorization', routes: {
    '/authorization': (context) => Authorization(),
    '/processing': (context) => Processing(),
    // '/location': (context) => ChooseLocation(),
  }));
}
