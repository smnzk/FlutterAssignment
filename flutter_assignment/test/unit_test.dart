import 'package:flutter_assignment/Models/character_info.dart';
import 'package:flutter_assignment/Models/episode_info.dart';
import 'package:flutter_assignment/Models/locator.dart';
import 'package:flutter_assignment/Services/api_operator.dart';
import 'package:flutter_assignment/graphql_config/client_config.dart';
import 'package:flutter_assignment/graphql_config/queries.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

main() async {

  await initHiveForFlutter();

  locator.registerLazySingleton(() => ApiOperator());
  locator.registerLazySingleton(() => Queries());
  locator.registerLazySingleton(() => GraphClient());

  test('Correct episodes query with parameter is returned', () {
    Queries queries = Queries();

    String episodesQuery = queries.getEpisodesQuery(5);

    expect(episodesQuery, "query { episodes(page: 5) { info { count } results { id name } } }");
  });

  test('Correct characters query with parameter is returned', () {
    Queries queries = Queries();

    String charactersQuery = queries.getCharactersQuery(3);

    expect(charactersQuery, "query {episode(id: 3) {characters {name image species location { name } } } }");
  });

  test('Correct pages query', () {
    Queries queries = Queries();

    String pagesQuery = queries.getPagesQuery();

    expect(pagesQuery, "query { episodes { info { pages } } }");
  });

  test('Episode structure is correct', () async {
    //not testing all the episodes list because the external API might change and add more episodes
    //but for each episode information will stay the same
    List<EpisodeInfo> episodes = await locator.get<ApiOperator>().getEpisodes();
    EpisodeInfo episodeResult = episodes[0];
    EpisodeInfo episode = EpisodeInfo(id: 1, name: 'Pilot');

    bool same = episodeResult.id == episode.id && episodeResult.name == episode.name;

    expect(same, true);
  });

  test('Character structure is correct', () async {
    List<CharacterInfo> characters = await locator.get<ApiOperator>().getCharacters(1);
    CharacterInfo characterResult = characters[0];
    CharacterInfo character = CharacterInfo(name: 'Rick Sanchez', image: 'https://rickandmortyapi.com/api/character/avatar/1.jpeg', lastSeen: "Citadel of Ricks", species: "Human");

    bool same = characterResult.name == character.name && characterResult.image == character.image
        && characterResult.species == character.species && characterResult.lastSeen == character.lastSeen;

    expect(same, true);
  });

}