import 'package:flutter/material.dart';
import 'package:flutter_assignment/Models/episode_info.dart';
import 'package:flutter_assignment/Services/api_operator.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {


  List<EpisodeInfo> allEpisodes = [];

  void setEpisodes() async{
    ApiOperator operator = ApiOperator();
    List<EpisodeInfo> temp = await operator.getEpisodes();
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
      backgroundColor: const Color.fromRGBO(115, 115, 115, 1),
      appBar: AppBar(
        title: const Center(
            child: Text('Rick and Morty character wiki',)
        ),
        backgroundColor: const Color.fromRGBO(128, 0, 64, 1),
      ),
    );
  }

}
