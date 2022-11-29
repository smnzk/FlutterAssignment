import 'package:flutter/material.dart';
import 'package:flutter_assignment/Models/character_info.dart';
import 'package:flutter_assignment/Services/api_operator.dart';

class CharactersPage extends StatefulWidget {
  const CharactersPage({Key? key}) : super(key: key);

  @override
  State<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {

  Map data = {};

  List<CharacterInfo> allCharacters = [];

  void setCharacters(int id) async {
    ApiOperator operator = ApiOperator();
    List<CharacterInfo> temp = await operator.getCharacters(id);
    setState(() {
      allCharacters = temp;
    });
  }


  @override
  Widget build(BuildContext context) {

    data = ModalRoute.of(context)!.settings.arguments as Map;
    setCharacters(data['id']);

    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Center(child: Text("Characters in this episode")),
        backgroundColor: const Color.fromRGBO(128, 0, 64, 1)
      ),
      body: GridView.count(
        padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
        crossAxisCount: 2,
        childAspectRatio: 1/0.7,
        children: List.generate(allCharacters.length, (index) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(7,0,7,15),
          child: Material(
            elevation: 20,
            color: Color.fromRGBO(35, 35, 35, 1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0,10,0,0),
                  child: ListTile(
                    leading: Image(
                      image: NetworkImage(allCharacters[index].image),
                    ),
                    title: Text(
                      allCharacters[index].name,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8,10,0,0),
                  child: Text(
                    'Species: ${allCharacters[index].species}',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8,6,0,0),
                  child: Text(
                    'Last seen: ${allCharacters[index].lastSeen}',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
        }),
      ),
    );
  }
}
