import 'package:flutter_test/flutter_test.dart';
import 'package:fudo_challenge/data/model/result.dart';
import 'package:fudo_challenge/data/model/stock_search_item.dart';
import 'package:fudo_challenge/data/network/alphavantage/alpha_vantage_api.dart';
import 'package:fudo_challenge/data/network/alphavantage/dto/search/av_search_item_dto.dart';
import 'package:fudo_challenge/data/network/alphavantage/dto/search/av_search_response_dto.dart';
import 'package:fudo_challenge/data/repository/implementation/stock_repository_av_api.dart';

class MockAlphaVantageApi extends AlphaVantageApi {
  MockAlphaVantageApi() : super('', '');

  AvSearchResponseDto? response;
  Object? error;

  @override
  Future<AvSearchResponseDto> search(String query) async {
    if (error != null) {
      throw error!;
    }
    if (response == null) {
      throw Exception('Mock response not set');
    }
    return response!;
  }
}

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
      expect(result, isA<Success<List<StockSearchItem>, String>>());
      final successResult = result as Success<List<StockSearchItem>, String>;
      expect(successResult.value, isEmpty);
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
      mockApi.response = mockResponse;

      // Act
      final result = await repository.search('Apple');

      // Assert
      expect(result, isA<Success<List<StockSearchItem>, String>>());
      final successResult = result as Success<List<StockSearchItem>, String>;
      expect(successResult.value.length, 2);
      expect(successResult.value[0].stockSymbol, 'AAPL');
      expect(successResult.value[0].companyName, 'Apple Inc.');
      expect(successResult.value[0].region, 'United States');
      expect(successResult.value[1].stockSymbol, 'MSFT');
      expect(successResult.value[1].companyName, 'Microsoft Corporation');
      expect(successResult.value[1].region, 'United States');
    });

    test('should return failure when API call throws an exception', () async {
      // Arrange
      mockApi.error = Exception('Network error');

      // Act
      final result = await repository.search('Apple');

      // Assert
      expect(result, isA<Failure<List<StockSearchItem>, String>>());
      final failureResult = result as Failure<List<StockSearchItem>, String>;
      expect(failureResult.value, contains('Network error'));
    });
  });
}
