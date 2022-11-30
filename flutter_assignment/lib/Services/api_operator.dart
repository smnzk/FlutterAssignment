import 'package:flutter_assignment/Models/character_info.dart';
import 'package:flutter_assignment/Models/locator.dart';
import 'package:flutter_assignment/graphql_config/client_config.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../Models/episode_info.dart';
import '../graphql_config/queries.dart';

class ApiOperator {

  GraphQLClient qlClient = locator.get<GraphClient>().getClient();

  Future<List<EpisodeInfo>> getEpisodes() async {

    late int amountOfPages;
    List<dynamic> episodesTemp = [];
    List<EpisodeInfo> episodes = [];

    QueryResult queryResult = await qlClient.query(
      QueryOptions(
        document: gql(locator.get<Queries>().getPagesQuery()),
      ),
    );

    amountOfPages = queryResult.data!['episodes']['info']['pages'];

    for(int i = 1; i <= amountOfPages; i++) {
      queryResult = await qlClient.query(
        QueryOptions(
          document: gql(locator.get<Queries>().getEpisodesQuery(i)),
        ),
      );

      episodesTemp = queryResult.data!['episodes']['results'];

      for (int k = 0; k < episodesTemp.length; k++) {
        var current = queryResult.data!['episodes']['results'][k];
        episodes.add(EpisodeInfo(
            id: int.parse(current['id']),
            name: current['name'])
        );
      }
    }
    return episodes;
  }

  Future<List<CharacterInfo>> getCharacters(int episodeId) async {

    List<dynamic> charactersTemp = [];
    List<CharacterInfo> characters = [];

    QueryResult queryResult = await qlClient.query(
      QueryOptions(
        document: gql(locator.get<Queries>().getCharactersQuery(episodeId)),
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