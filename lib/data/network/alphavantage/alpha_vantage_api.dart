import 'package:dio/dio.dart';
import 'package:fudo_challenge/di/injections_keys.dart';
import 'package:injectable/injectable.dart';
import 'dto/search/av_search_response_dto.dart';
import 'dto/overview/av_overview_dto.dart';
import 'dto/quote/av_stock_quote_dto.dart';
import 'dto/intraday/av_intraday_response_dto.dart';

@injectable
class AlphaVantageApi {

  final String _apiKey;
  final String _baseUrl;

  static const String pathQuery = "query";
  static const String paramKeyFunction = "function";
  static const String paramSymbolSearch = "SYMBOL_SEARCH";
  static const String paramFunctionOverview = "OVERVIEW";
  static const String paramFunctionGlobalQuote = "GLOBAL_QUOTE";
  static const String paramFunctionIntraday = "TIME_SERIES_INTRADAY";

  static const String paramKeyKeywords = "keywords";
  static const String paramKeySymbol = "symbol";
  static const String paramKeyInterval = "interval";
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

  Future<AvOverviewDto> getOverview(String symbol) async {
    try {
      final response = await Dio().get(
        '$_baseUrl/$pathQuery',
        queryParameters: {
          paramKeyFunction: paramFunctionOverview,
          paramKeySymbol: symbol,
          paramKeyApiKey: _apiKey,
        },
      );

      if (response.data == null) {
        throw Exception('Response data is null');
      }

      return AvOverviewDto.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to get overview: $e');
    }
  }

  Future<AvStockQuoteDto> getStockQuote(String symbol) async {
    try {
      final response = await Dio().get(
        '$_baseUrl/$pathQuery',
        queryParameters: {
          paramKeyFunction: paramFunctionGlobalQuote,
          paramKeySymbol: symbol,
          paramKeyApiKey: _apiKey,
        },
      );

      if (response.data == null) {
        throw Exception('Response data is null');
      }

      return AvStockQuoteDto.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to get stock quote: $e');
    }
  }

  Future<AvIntradayResponseDto> getIntradayData(String symbol, String interval) async {
    try {
      final response = await Dio().get(
        '$_baseUrl/$pathQuery',
        queryParameters: {
          paramKeyFunction: paramFunctionIntraday,
          paramKeySymbol: symbol,
          paramKeyInterval: interval,
          paramKeyApiKey: _apiKey,
        },
      );

      if (response.data == null) {
        throw Exception('Response data is null');
      }

      return AvIntradayResponseDto.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to get intraday data: $e');
    }
  }
}
