import 'package:flutter/material.dart';
import 'package:flutter_assignment/pages/home.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() async{
  await initHiveForFlutter();
  runApp(const MaterialApp(
    home: Home(),
  ));
}
