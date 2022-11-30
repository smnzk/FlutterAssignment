import 'package:flutter/material.dart';
import 'package:flutter_assignment/Models/episode_info.dart';
import 'package:flutter_assignment/Services/api_operator.dart';

import '../Models/locator.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<EpisodeInfo> allEpisodes = [];

  void setEpisodes() async{
    List<EpisodeInfo> temp = await locator.get<ApiOperator>().getEpisodes();
    setState((){
      allEpisodes = temp;
    });
  }

  @override
  void initState(){
    super.initState();
    setEpisodes();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Center(
            child: Text('Rick and Morty wiki',)
        ),
        backgroundColor: const Color.fromRGBO(128, 0, 64, 1),
      ),
      body: ListView.builder(
        itemBuilder: (context, i) {
          String title = allEpisodes[i].name;
          int episodeId = allEpisodes[i].id;
          return Padding(
            padding: const EdgeInsets.fromLTRB(13, 0, 13, 0),
              child: Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 1.2,
                      color: Color.fromRGBO(128, 0, 64, 1),
                    ),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0,6,0,6),
                  child: ListTile(
                    trailing: const Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.grey,
                    ),
                    tileColor: Colors.grey[900],
                      title: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18.3,
                          letterSpacing: 0,
                          color: Colors.grey
                        ),
                      ),
                    subtitle: Padding(
                      padding: const EdgeInsets.fromLTRB(0,10,0,0),
                      child: Text(
                        "Episode $episodeId",
                        style: const TextStyle(
                          color: Colors.blueGrey
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/characters',
                        arguments: {
                          'id': episodeId
                        }
                      );
                    },
                  ),
                ),
              ),
          );
        },
        itemCount: allEpisodes.length,
      ),
    );
  }
}
