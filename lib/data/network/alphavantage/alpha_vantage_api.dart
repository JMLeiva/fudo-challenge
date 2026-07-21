import 'package:dio/dio.dart';
import 'dto/search/av_search_item_dto.dart';
import 'dto/search/av_search_response_dto.dart';

class AlphaVantageApi {

  final String _apiKey;
  final String _baseUrl;

  static const String pathQuery = "query";
  static const String paramKeyFunction = "function";
  static const String paramSymbolSearch = "SYMBOL_SEARCH";
  static const String paramKeyKeywords = "keywords";
  static const String paramKeyApiKey = "apikey";

  AlphaVantageApi(this._apiKey, this._baseUrl);

  Future<AvSearchResponseDto?> search(String query) async {
    try {
      final response = await Dio().get(
        '$_baseUrl/$pathQuery',
        queryParameters: {
          paramKeyFunction: paramSymbolSearch,
          paramKeyKeywords: query,
          paramKeyApiKey: _apiKey,
        },
      );

      if (response.data == null) return null;

      return AvSearchResponseDto.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to search: $e');
    }
  }
}