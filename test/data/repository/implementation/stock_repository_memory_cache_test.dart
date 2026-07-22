import 'package:dart_either/dart_either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fudo_challenge/data/network/alphavantage/dto/intraday/av_intraday_response_dto.dart';
import 'package:fudo_challenge/data/network/alphavantage/dto/overview/av_overview_dto.dart';
import 'package:fudo_challenge/data/network/alphavantage/dto/quote/av_stock_quote_dto.dart';
import 'package:fudo_challenge/data/network/alphavantage/dto/search/av_search_item_dto.dart';
import 'package:fudo_challenge/data/network/alphavantage/dto/search/av_search_response_dto.dart';
import 'package:fudo_challenge/data/repository/implementation/stock_repository_av_api.dart';
import 'package:fudo_challenge/data/repository/implementation/stock_repository_memory_cache.dart';
import 'package:memory_cache/memory_cache.dart';
import '../../../mocks/mock_alpha_vantage_api.dart';


void main() {
  late StockRepositoryMemoryCache cacheRepository;
  late StockRepositoryAvApi fallback;
  late MockAlphaVantageApi mockApi;

  setUp(() {
    mockApi = MockAlphaVantageApi();
    fallback = StockRepositoryAvApi(mockApi);
    cacheRepository = StockRepositoryMemoryCache(fallback);
    MemoryCache.instance.invalidate();
  });

  group('StockRepositoryMemoryCache', () {
    test('search should cache results', () async {
      mockApi.searchResponse = AvSearchResponseDto([
        AvSearchItemDto(stockSymbol: 'AAPL', companyName: 'Apple', region: 'USA')
      ]);

      final result1 = await cacheRepository.search('AAPL');
      expect(result1.isRight, true);
      
      mockApi.searchResponse = null;
      mockApi.error = Exception('Should not be called');

      final result2 = await cacheRepository.search('AAPL');
      expect(result2.isRight, true);
      expect(result2.getOrThrow().first.stockSymbol, 'AAPL');
    });

    test('getStockOverview should cache results', () async {
      mockApi.overviewResponse = AvOverviewDto(
        symbol: 'AAPL',
        name: 'Apple Inc.',
        description: '',
        exchange: '',
        currency: '',
        country: '',
        sector: '',
        industry: '',
        marketCapitalization: 0,
        peRatio: 0,
        dividendYield: 0,
        eps: 0,
        fiftyTwoWeekHigh: 0,
        fiftyTwoWeekLow: 0,
      );

      final result1 = await cacheRepository.getStockOverview('AAPL');
      expect(result1.isRight, true);

      mockApi.overviewResponse = null;
      mockApi.error = Exception('Should not be called');

      final result2 = await cacheRepository.getStockOverview('AAPL');
      expect(result2.isRight, true);
      expect(result2.getOrThrow().symbol, 'AAPL');
    });

    test('getStockQuote should cache results', () async {
      mockApi.quoteResponse = AvStockQuoteDto(
        symbol: 'AAPL',
        open: 0,
        high: 0,
        low: 0,
        price: 150.0,
        volume: 0,
        latestTradingDay: '',
        previousClose: 0,
        change: 0,
        changePercent: 0,
      );

      final result1 = await cacheRepository.getStockQuote('AAPL');
      expect(result1.isRight, true);

      mockApi.quoteResponse = null;
      mockApi.error = Exception('Should not be called');

      final result2 = await cacheRepository.getStockQuote('AAPL');
      expect(result2.isRight, true);
      expect(result2.getOrThrow().price, 150.0);
    });

    test('getIntradayData should cache results', () async {
      mockApi.intradayResponse = AvIntradayResponseDto(
        metadata: AvIntradayMetadataDto(symbol: 'AAPL', lastRefreshed: '', interval: '', timeZone: ''),
        timeSeries: [
          AvIntradayPointDto(timestamp: '2023-10-27 15:55:00', open: 0, high: 0, low: 0, close: 152.0, volume: 0)
        ],
      );

      final result1 = await cacheRepository.getIntradayData('AAPL');
      expect(result1.isRight, true);

      mockApi.intradayResponse = null;
      mockApi.error = Exception('Should not be called');

      final result2 = await cacheRepository.getIntradayData('AAPL');
      expect(result2.isRight, true);
      expect(result2.getOrThrow().first.close, 152.0);
    });

    test('expired or missing cache should trigger fallback call', () async {
      mockApi.quoteResponse = AvStockQuoteDto(
        symbol: 'AAPL',
        open: 0,
        high: 0,
        low: 0,
        price: 150.0,
        volume: 0,
        latestTradingDay: '',
        previousClose: 0,
        change: 0,
        changePercent: 0,
      );

      await cacheRepository.getStockQuote('AAPL');

      // Manual invalidation to simulate expiration or cache miss
      MemoryCache.instance.delete('quote_AAPL');
      
      mockApi.quoteResponse = AvStockQuoteDto(
        symbol: 'AAPL',
        open: 0,
        high: 0,
        low: 0,
        price: 200.0,
        volume: 0,
        latestTradingDay: '',
        previousClose: 0,
        change: 0,
        changePercent: 0,
      );
      
      final result = await cacheRepository.getStockQuote('AAPL');
      expect(result.getOrThrow().price, 200.0);
    });
  });
}
