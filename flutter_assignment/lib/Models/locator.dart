import 'package:flutter_assignment/Services/api_operator.dart';
import 'package:flutter_assignment/graphql_config/client_config.dart';
import 'package:get_it/get_it.dart';

import '../graphql_config/queries.dart';

final locator = GetIt.instance;

void setup() {
  locator.registerLazySingleton(() => ApiOperator());
  locator.registerLazySingleton(() => Queries());
  locator.registerLazySingleton(() => GraphClient());
}