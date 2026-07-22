import 'package:dart_either/dart_either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fudo_challenge/domain/model/stock.dart';
import 'package:fudo_challenge/domain/model/stock_intraday_point.dart';
import 'package:fudo_challenge/domain/model/stock_overview.dart';
import 'package:fudo_challenge/domain/model/stock_quote.dart';
import 'package:fudo_challenge/presentation/view_model/details_view_model.dart';
import 'package:fudo_challenge/presentation/view_model/details_view_ui_state.dart' as ui;
import '../../mocks/mock_stock_repository.dart';

void main() {
  late DetailsViewModel viewModel;
  late MockStockRepository mockRepository;

  setUp(() {
    mockRepository = MockStockRepository();
    viewModel = DetailsViewModel(mockRepository);
  });

  tearDown(() {
    viewModel.dispose();
  });

  group('DetailsViewModel', () {
    final mockStock = Stock(
      quote: StockQuote(
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
      ),
      overview: StockOverview(
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
      ),
      intraday: [
        StockIntradayPoint(
          dateTime: DateTime.parse('2023-10-27 15:55:00'),
          open: 152.5,
          high: 152.6,
          low: 152.4,
          close: 152.55,
          volume: 50000,
        ),
      ],
    );

    test('loadStockDetails emits loading then success when repository call is successful', () async {
      // Arrange
      mockRepository.stockDetailsResult = mockStock.right();

      // Act & Assert
      expect(
        viewModel.stateStream,
        emitsInOrder([
          isA<ui.Loading>(),
          isA<ui.Success>().having((s) => s.stock, 'stock', mockStock),
        ]),
      );

      await viewModel.loadStockDetails('AAPL');
    });

    test('loadStockDetails emits loading then error when repository call fails', () async {
      // Arrange
      mockRepository.stockDetailsResult = 'API error'.left();

      // Act & Assert
      expect(
        viewModel.stateStream,
        emitsInOrder([
          isA<ui.Loading>(),
          isA<ui.Error>().having((s) => s.message, 'message', 'API error'),
        ]),
      );

      await viewModel.loadStockDetails('AAPL');
    });
  });
}
