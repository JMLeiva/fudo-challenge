import 'package:fudo_challenge/data/network/alphavantage/alpha_vantage_api.dart';
import 'package:fudo_challenge/data/network/alphavantage/dto/search/av_search_response_dto.dart';
import 'package:fudo_challenge/data/network/alphavantage/dto/quote/av_stock_quote_dto.dart';
import 'package:fudo_challenge/data/network/alphavantage/dto/overview/av_overview_dto.dart';
import 'package:fudo_challenge/data/network/alphavantage/dto/intraday/av_intraday_response_dto.dart';

class MockAlphaVantageApi extends AlphaVantageApi {
  MockAlphaVantageApi() : super('', '');

  AvSearchResponseDto? searchResponse;
  AvStockQuoteDto? quoteResponse;
  AvOverviewDto? overviewResponse;
  AvIntradayResponseDto? intradayResponse;
  Object? error;

  @override
  Future<AvSearchResponseDto> search(String query) async {
    if (error != null) throw error!;
    if (searchResponse == null) throw Exception('Mock searchResponse not set');
    return searchResponse!;
  }

  @override
  Future<AvStockQuoteDto> getStockQuote(String symbol) async {
    if (error != null) throw error!;
    if (quoteResponse == null) throw Exception('Mock quoteResponse not set');
    return quoteResponse!;
  }

  @override
  Future<AvOverviewDto> getOverview(String symbol) async {
    if (error != null) throw error!;
    if (overviewResponse == null) throw Exception('Mock overviewResponse not set');
    return overviewResponse!;
  }

  @override
  Future<AvIntradayResponseDto> getIntradayData(String symbol, String interval) async {
    if (error != null) throw error!;
    if (intradayResponse == null) throw Exception('Mock intradayResponse not set');
    return intradayResponse!;
  }
}
