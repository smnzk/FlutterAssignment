import 'package:flutter_assignment/Models/character_info.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../Models/episode_info.dart';

class ApiOperator {

  final HttpLink link = HttpLink("https://rickandmortyapi.com/graphql");

  late GraphQLClient qlClient;

  final String pagesQuery = "query { episodes { info { pages } } }";


  Future<List<EpisodeInfo>> getEpisodes() async {

    late int amountOfPages;
    List<dynamic> episodesTemp = [];
    List<EpisodeInfo> episodes = [];

    qlClient = GraphQLClient(
      link: link,
      cache: GraphQLCache(
        store:
        HiveStore(),
      ),
    );


    QueryResult queryResult = await qlClient.query(
      QueryOptions(
        document: gql(pagesQuery),
      ),
    );

    amountOfPages = queryResult.data!['episodes']['info']['pages'];

    for(int i = 1; i <= amountOfPages; i++) {
      queryResult = await qlClient.query(
        QueryOptions(
          document: gql("""query { episodes(page: $i) { info { count } results { id name } } }"""),
        ),
      );

      episodesTemp = queryResult.data!['episodes']['results'];

      for (int k = 0; k < episodesTemp.length; k++) {
        var current = queryResult.data!['episodes']['results']['k'];
        episodes.add(EpisodeInfo(
            id: current['id'],
            name: current['name'])
        );
      }
    }
    return episodes;
  }

  Future<List<CharacterInfo>> getCharacters(int episodeId) async {

    List<dynamic> charactersTemp = [];
    List<CharacterInfo> characters = [];

    qlClient = GraphQLClient(
      link: link,
      cache: GraphQLCache(
        store:
        HiveStore(),
      ),
    );

    QueryResult queryResult = await qlClient.query(
      QueryOptions(
        document: gql("""query {episode(id: $episodeId) {characters {name image species location { name } } } }""",),
      ),
    );

    charactersTemp = queryResult.data!['episode']['characters'];

    for(int i = 0; i < charactersTemp.length; i++) {
      var current = queryResult.data!['episode']['characters'][i];
      characters.add(CharacterInfo(
          name: current['name'],
          image: current['image'],
          species: current['species'],
          lastSeen: current['location']['name'])
      );
    }
    return characters;
  }

}