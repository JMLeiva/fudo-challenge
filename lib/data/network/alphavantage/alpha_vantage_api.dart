import 'package:dio/dio.dart';
import 'package:fudo_challenge/di/injections_keys.dart';
import 'package:injectable/injectable.dart';
import '../../../di/main_module.dart';
import 'dto/search/av_search_response_dto.dart';

@injectable
class AlphaVantageApi {

  final String _apiKey;
  final String _baseUrl;

  static const String pathQuery = "query";
  static const String paramKeyFunction = "function";
  static const String paramSymbolSearch = "SYMBOL_SEARCH";
  static const String paramKeyKeywords = "keywords";
  static const String paramKeyApiKey = "apikey";

  AlphaVantageApi(
      @Named(InjectionKeys.avApiKey) this._apiKey,
      @Named(InjectionKeys.avBaseUrl) this._baseUrl
  );

  Future<AvSearchResponseDto> search(String query) async {
    try {
      final response = await Dio().get(
        '$_baseUrl/$pathQuery',
        queryParameters: {
          paramKeyFunction: paramSymbolSearch,
          paramKeyKeywords: query,
          paramKeyApiKey: _apiKey,
        },
      );

      if (response.data == null) {
        throw Exception('Response data is null');
      }

      return AvSearchResponseDto.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to search: $e');
    }
  }
}