import 'dart:math';

import 'package:dio/dio.dart';
import 'package:fudo_challenge/di/injections_keys.dart';
import 'package:injectable/injectable.dart';
import 'dto/search/td_search_response_dto.dart';
import 'dto/quote/td_quote_dto.dart';
import 'dto/intraday/td_intraday_response_dto.dart';
import 'dto/profile/td_profile_dto.dart';

@injectable
class TwelveDataApi {
  final String _apiKey;
  final String _baseUrl;

  static const String pathSymbolSearch = "symbol_search";
  static const String pathQuote = "quote";
  static const String pathTimeSeries = "time_series";
  static const String pathProfile = "profile";

  static const String paramKeySymbol = "symbol";
  static const String paramKeyInterval = "interval";
  static const String paramKeyApiKey = "apikey";

  TwelveDataApi(
      @Named(InjectionKeys.tdApiKey) this._apiKey,
      @Named(InjectionKeys.tdBaseUrl) this._baseUrl
  );

  Future<TdSearchResponseDto> search(String query) async {
    try {
      final response = await Dio().get(
        '$_baseUrl/$pathSymbolSearch',
        queryParameters: {
          paramKeySymbol: query,
          paramKeyApiKey: _apiKey,
        },
      );

      if (response.data == null) {
        throw Exception('Response data is null');
      }

      return TdSearchResponseDto.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to search: $e');
    }
  }

  Future<TdQuoteDto> getQuote(String symbol) async {
    try {
      final response = await Dio().get(
        '$_baseUrl/$pathQuote',
        queryParameters: {
          paramKeySymbol: symbol,
          paramKeyApiKey: _apiKey,
        },
      );

      if (response.data == null) {
        throw Exception('Response data is null');
      }

      return TdQuoteDto.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to get quote: $e');
    }
  }

  Future<TdIntradayResponseDto> getIntradayData(String symbol, String interval) async {
    try {
      final response = await Dio().get(
        '$_baseUrl/$pathTimeSeries',
        queryParameters: {
          paramKeySymbol: symbol,
          paramKeyInterval: interval,
          paramKeyApiKey: _apiKey,
        },
      );

      if (response.data == null) {
        throw Exception('Response data is null');
      }

      return TdIntradayResponseDto.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to get intraday data: $e');
    }
  }

  Future<TdProfileDto> getProfile(String symbol) async {

    /*try {
      final response = await Dio().get(
        '$_baseUrl/$pathProfile',
        queryParameters: {
          paramKeySymbol: symbol,
          paramKeyApiKey: _apiKey,
        },
      );

      if (response.data == null) {
        throw Exception('Response data is null');
      }

      return TdProfileDto.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to get profile: $e');
    }*/
    /**
     * Profile ENDPOINT requires a paid subscription.
     */

    final random = Random();
    const exchanges = ['NYSE', 'NASDAQ', 'AMEX', 'BATS'];
    const sectors = ['Technology', 'Financial Services', 'Healthcare', 'Energy', 'Consumer Defensive'];
    const industries = ['Software - Infrastructure', 'Banks - Regional', 'Drug Manufacturers', 'Oil & Gas E&P', 'Discount Stores'];
    const countries = ['United States', 'Canada', 'United Kingdom', 'Germany', 'France'];

    return TdProfileDto(
        symbol: symbol,
        name: symbol,
        exchange: exchanges[random.nextInt(exchanges.length)],
        sector: sectors[random.nextInt(sectors.length)],
        industry: industries[random.nextInt(industries.length)],
        description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
            'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. '
            'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris '
            'nisi ut aliquip ex ea commodo consequat.',
        country: countries[random.nextInt(countries.length)]
    );
  }
}
