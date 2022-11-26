import 'package:flutter/material.dart';
import 'package:flutter_assignment/pages/characters.dart';
import 'package:flutter_assignment/pages/home.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() async{
  await initHiveForFlutter();
  runApp(MaterialApp(
    home: Home(),
    routes: {
      '/home': (context) => Home(),
      '/characters': (context) => CharactersPage(),
    },
  ));
}
