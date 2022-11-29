

import 'package:graphql_flutter/graphql_flutter.dart';

class GraphClient {
  static final HttpLink link = HttpLink("https://rickandmortyapi.com/graphql");

  GraphQLClient getClient() {
    return GraphQLClient(
      link: link,
      cache: GraphQLCache(
        store:
        HiveStore(),
      ),
    );
  }
}