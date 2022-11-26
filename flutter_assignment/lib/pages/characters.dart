import 'package:flutter/material.dart';
import 'package:flutter_assignment/Models/character_info.dart';

class CharactersPage extends StatefulWidget {
  const CharactersPage({Key? key}) : super(key: key);

  @override
  State<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {

  List<CharacterInfo> allCharacters = [];

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Characters in this episode"),
        backgroundColor: const Color.fromRGBO(128, 0, 64, 1)
      ),
    );
  }
}
