import 'package:flutter/material.dart';
import 'package:flutter_assignment/pages/characters.dart';
import 'package:flutter_assignment/pages/home.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'Models/locator.dart';

void main() async{
  await initHiveForFlutter();
  setup();
  runApp(MaterialApp(
    home: Home(),
    routes: {
      '/home': (context) => Home(),
      '/characters': (context) => CharactersPage(),
    },
  ));
}
