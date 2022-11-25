import 'package:graphql_flutter/graphql_flutter.dart';
import '../Models/episode_info.dart';

class ApiOperator {

  Future<List<EpisodeInfo>> getEpisodes() async {

    late int amountOfPages;
    List<dynamic> episodesInfo = [];
    List<EpisodeInfo> episodes = [];

    HttpLink link =
    HttpLink("https://rickandmortyapi.com/graphql");
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

      episodesInfo = queryResult.data!['episodes']['results'];

      for (int k = 0; k < episodesInfo.length; k++) {
        int id = int.parse(queryResult.data!['episodes']['results'][k]['id']);
        String name = queryResult.data!['episodes']['results'][k]['name'];
        episodes.add(EpisodeInfo(id: id, name: name));
      }
    }

    return episodes;
  }

}