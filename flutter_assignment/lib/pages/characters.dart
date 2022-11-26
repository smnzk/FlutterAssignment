import 'package:flutter/material.dart';
import 'package:flutter_assignment/Models/character_info.dart';
import 'package:flutter_assignment/Services/api_operator.dart';

class CharactersPage extends StatefulWidget {
  const CharactersPage({Key? key}) : super(key: key);

  @override
  State<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {

  int episodeId= 1;
  List<CharacterInfo> allCharacters = [];

  void setCharacters() async {
    ApiOperator operator = ApiOperator();
    List<CharacterInfo> temp = await operator.getCharacters(episodeId);
    setState(() {
      allCharacters = temp;
    });
  }

  @override
  void initState(){
    super.initState();
    setCharacters();
  }

  @override
  Widget build(BuildContext context) {
    print(allCharacters);
    return Scaffold(
      appBar: AppBar(
        title: Text("Characters in this episode"),
        backgroundColor: const Color.fromRGBO(128, 0, 64, 1)
      ),
      body: GridView.count(
        // Create a grid with 2 columns. If you change the scrollDirection to
        // horizontal, this produces 2 rows.
        crossAxisCount: 2,
        // Generate 100 widgets that display their index in the List.
        children: List.generate(100, (index) {
          return Center(
            child: Text(
              'Item $index',
              style: Theme.of(context).textTheme.headline5,
            ),
          );
        }),
      ),
    );
  }
}
