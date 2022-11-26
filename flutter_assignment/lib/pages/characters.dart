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
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text("Characters in this episode"),
        backgroundColor: const Color.fromRGBO(128, 0, 64, 1)
      ),
      body: GridView.count(
        padding: EdgeInsets.fromLTRB(0, 25, 0, 0),
        crossAxisCount: 2,
        childAspectRatio: 1/0.5,
        children: List.generate(allCharacters.length, (index) {
        return ListTile(
          leading: Image(
            image: NetworkImage(allCharacters[index].image),
          ),
          title: Text(
            allCharacters[index].name,
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey
            ),
          ),
        );
        }),
      ),
    );
  }
}
