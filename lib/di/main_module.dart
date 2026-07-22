import 'package:fudo_challenge/data/repository/implementation/stock_repository_twelve_data_api.dart';
import 'package:fudo_challenge/data/repository/stock_repository.dart';
import 'package:fudo_challenge/di/injections_keys.dart';
import 'package:injectable/injectable.dart';



@module
abstract class MainModule {

  @Named(InjectionKeys.avApiKey)
  String get apiKey => const String.fromEnvironment("ALPHA_VANTAGE_API_KEY");

  @Named(InjectionKeys.avBaseUrl)
  String get baseUrl => 'https://alphavantage.co';

  @Named(InjectionKeys.tdApiKey)
  String get tdApiKey => const String.fromEnvironment("TWELVE_DATA_API_KEY");

  @Named(InjectionKeys.tdBaseUrl)
  String get tdBaseUrl => 'https://api.twelvedata.com';

  @Named(InjectionKeys.remoteRepository)
  StockRepository remoteRepository(StockRepositoryTwelveDataApi impl) => impl;
}
