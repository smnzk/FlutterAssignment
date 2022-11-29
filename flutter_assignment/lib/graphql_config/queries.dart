import 'package:graphql_flutter/graphql_flutter.dart';

class Queries {

  String getPagesQuery(){
    return "query { episodes { info { pages } } }";
  }

  String getEpisodesQuery(int page){
    return "query { episodes(page: $page) { info { count } results { id name } } }";
  }

  String getCharactersQuery(int episodeId){
    return "query {episode(id: $episodeId) {characters {name image species location { name } } } }";
  }

}