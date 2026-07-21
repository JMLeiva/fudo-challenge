import 'package:fudo_challenge/di/injections_keys.dart';
import 'package:injectable/injectable.dart';



@module
abstract class MainModule {

  @Named(InjectionKeys.avApiKey)
  String get apiKey => String.fromEnvironment("ALPHA_VANTAGE_API_KEY");

  @Named(InjectionKeys.avBaseUrl)
  String get baseUrl => 'https://alphavantage.co';
}
