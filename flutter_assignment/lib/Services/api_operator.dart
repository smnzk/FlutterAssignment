import 'package:flutter_assignment/Models/character_info.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../Models/episode_info.dart';

class ApiOperator {

  HttpLink link = HttpLink("https://rickandmortyapi.com/graphql");

  Future<List<EpisodeInfo>> getEpisodes() async {

    late int amountOfPages;
    List<dynamic> episodesTemp = [];
    List<EpisodeInfo> episodes = [];


    GraphQLClient qlClient = GraphQLClient(
      link: link,
      cache: GraphQLCache(
        store:
        HiveStore(),
      ),
    );

    QueryResult queryResult = await qlClient.query(
      QueryOptions(
        document: gql("""query { episodes { info { pages } } }""",),
      ),
    );

    amountOfPages = queryResult.data!['episodes']['info']['pages'];

    for(int i = 1; i <= amountOfPages; i++) {
      queryResult = await qlClient.query(
        QueryOptions(
          document: gql("""query { episodes(page: $i) { info { count } results { id name } } }""",),
        ),
      );

      episodesTemp = queryResult.data!['episodes']['results'];

      for (int k = 0; k < episodesTemp.length; k++) {
        int id = int.parse(queryResult.data!['episodes']['results'][k]['id']);
        String name = queryResult.data!['episodes']['results'][k]['name'];
        episodes.add(EpisodeInfo(id: id, name: name));
      }
    }

    return episodes;
  }

  Future<List<CharacterInfo>> getCharacters(int episodeId) async {

    List<dynamic> charactersTemp = [];
    List<CharacterInfo> characters = [];


    GraphQLClient qlClient = GraphQLClient(
      link: link,
      cache: GraphQLCache(
        store:
        HiveStore(),
      ),
    );

    QueryResult queryResult = await qlClient.query(
      QueryOptions(
        document: gql("""query { episode(id: $episodeId) { characters { name image }}}""",),
      ),
    );

    charactersTemp = queryResult.data!['episode']['characters'];

    for(int i = 0; i < charactersTemp.length; i++) {
      String name = queryResult.data!['episode']['characters'][i]['name'];
      String image = queryResult.data!['episode']['characters'][i]['image'];
      characters.add(CharacterInfo(name: name, image: image));
    }

    return characters;

  }

}