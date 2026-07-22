
import 'package:flutter_test/flutter_test.dart';
import 'package:fudo_challenge/data/network/alphavantage/dto/search/av_search_item_dto.dart';
import 'package:fudo_challenge/data/network/alphavantage/dto/search/av_search_response_dto.dart';
import 'package:fudo_challenge/data/network/alphavantage/dto/quote/av_stock_quote_dto.dart';
import 'package:fudo_challenge/data/network/alphavantage/dto/overview/av_overview_dto.dart';
import 'package:fudo_challenge/data/network/alphavantage/dto/intraday/av_intraday_response_dto.dart';
import 'package:fudo_challenge/data/repository/implementation/stock_repository_av_api.dart';
import '../../../mocks/mock_alpha_vantage_api.dart';

void main() {
  late StockRepositoryAvApi repository;
  late MockAlphaVantageApi mockApi;

  setUp(() {
    mockApi = MockAlphaVantageApi();
    repository = StockRepositoryAvApi(mockApi);
  });

  group('StockRepositoryAvApi search', () {
    test('should return empty list when query is empty', () async {
      // Act
      final result = await repository.search('');

      // Assert
      expect(result.isRight, isTrue);
      result.fold(
        ifLeft: (l) => fail('Should be right'),
        ifRight: (r) => expect(r, isEmpty),
      );
    });

    test('should return list of StockSearchItem when API call is successful', () async {
      // Arrange
      final mockResponse = AvSearchResponseDto([
        AvSearchItemDto(
          stockSymbol: 'AAPL',
          companyName: 'Apple Inc.',
          region: 'United States',
        ),
        AvSearchItemDto(
          stockSymbol: 'MSFT',
          companyName: 'Microsoft Corporation',
          region: 'United States',
        ),
      ]);
      mockApi.searchResponse = mockResponse;

      // Act
      final result = await repository.search('Apple');

      // Assert
      expect(result.isRight, isTrue);
      result.fold(
        ifLeft: (l) => fail('Should be right'),
        ifRight: (r) => {
          expect(r.length, 2),
          expect(r[0].stockSymbol, 'AAPL'),
          expect(r[0].companyName, 'Apple Inc.'),
          expect(r[0].region, 'United States'),
          expect(r[1].stockSymbol, 'MSFT'),
          expect(r[1].companyName, 'Microsoft Corporation'),
          expect(r[1].region, 'United States'),
        },
      );
    });

    test('should return failure when API call throws an exception', () async {
      // Arrange
      mockApi.error = Exception('Network error');

      // Act
      final result = await repository.search('Apple');

      // Assert
      expect(result.isLeft, isTrue);
      result.fold(
        ifLeft: (l) => expect(l, contains('Network error')),
        ifRight: (r) => fail('Should be left'),
      );
    });
  });

  group('StockRepositoryAvApi getStockDetails', () {
    test('should return Stock when all API calls are successful', () async {
      // Arrange
      final mockQuote = AvStockQuoteDto(
        symbol: 'AAPL',
        open: 150.0,
        high: 155.0,
        low: 149.0,
        price: 153.0,
        volume: 1000000,
        latestTradingDay: '2023-10-27',
        previousClose: 152.0,
        change: 1.0,
        changePercent: 0.65,
      );
      final mockOverview = AvOverviewDto(
        symbol: 'AAPL',
        name: 'Apple Inc.',
        description: 'Tech company',
        exchange: 'NASDAQ',
        currency: 'USD',
        country: 'USA',
        sector: 'Technology',
        industry: 'Consumer Electronics',
        marketCapitalization: 2000000000000,
        peRatio: 30.0,
        dividendYield: 0.01,
        eps: 5.0,
        fiftyTwoWeekHigh: 180.0,
        fiftyTwoWeekLow: 120.0,
      );
      final mockIntraday = AvIntradayResponseDto(
        metadata: AvIntradayMetadataDto(
          symbol: 'AAPL',
          lastRefreshed: '2023-10-27 16:00:00',
          interval: '5min',
          timeZone: 'US/Eastern',
        ),
        timeSeries: [
          AvIntradayPointDto(
            timestamp: '2023-10-27 15:55:00',
            open: 152.5,
            high: 152.6,
            low: 152.4,
            close: 152.55,
            volume: 50000,
          ),
        ],
      );

      mockApi.quoteResponse = mockQuote;
      mockApi.overviewResponse = mockOverview;
      mockApi.intradayResponse = mockIntraday;

      // Act
      final result = await repository.getStockDetails('AAPL');

      // Assert
      expect(result.isRight, isTrue);
      result.fold(
        ifLeft: (l) => fail('Should be right'),
        ifRight: (r) => {
          expect(r.quote.symbol, 'AAPL'),
          expect(r.overview.name, 'Apple Inc.'),
          expect(r.intraday.length, 1),
          expect(r.intraday[0].close, 152.55),
        },
      );
    });

    test('should return failure when any API call fails', () async {
      // Arrange
      mockApi.error = Exception('API Error');

      // Act
      final result = await repository.getStockDetails('AAPL');

      // Assert
      expect(result.isLeft, isTrue);
      result.fold(
        ifLeft: (l) => expect(l, contains('API Error')),
        ifRight: (r) => fail('Should be left'),
      );
    });
  });
}
