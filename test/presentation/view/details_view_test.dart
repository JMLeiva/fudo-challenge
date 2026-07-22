import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fudo_challenge/di/injection.dart';
import 'package:fudo_challenge/domain/model/stock.dart';
import 'package:fudo_challenge/domain/model/stock_intraday_point.dart';
import 'package:fudo_challenge/domain/model/stock_overview.dart';
import 'package:fudo_challenge/domain/model/stock_quote.dart';
import 'package:fudo_challenge/domain/model/stock_search_item.dart';
import 'package:fudo_challenge/l10n/app_localizations.dart';
import 'package:fudo_challenge/presentation/view/details_view.dart';
import 'package:fudo_challenge/presentation/view_model/details_view_model.dart';
import 'package:fudo_challenge/presentation/view_model/details_view_ui_state.dart';
import '../../mocks/mock_details_view_model.dart';

void main() {
  late MockDetailsViewModel mockViewModel;

  setUp(() {
    mockViewModel = MockDetailsViewModel();
    getIt.allowReassignment = true;
    getIt.registerFactory<DetailsViewModel>(() => mockViewModel);
  });

  Widget createWidgetUnderTest(StockSearchItem stock) {
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en')],
      home: DetailsView(stock: stock),
    );
  }

  final mockStockItem = StockSearchItem('AAPL', 'Apple Inc.', 'United States');
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
      description: 'Tech company description',
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

  testWidgets('should show loading indicator when state is loading', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest(mockStockItem));
    
    mockViewModel.emit(DetailsViewUIState.loading());
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('should show stock details when state is success', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest(mockStockItem));
    
    mockViewModel.emit(DetailsViewUIState.success(mockStock));
    await tester.pumpAndSettle();

    expect(find.text('AAPL'), findsOneWidget);
    expect(find.text('Apple Inc.'), findsNWidgets(2)); // AppBar and Header
    expect(find.text('Tech company description'), findsOneWidget);
    expect(find.text('\$153.00'), findsOneWidget);
  });

  testWidgets('should show error message and retry button when state is error', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest(mockStockItem));
    
    mockViewModel.emit(DetailsViewUIState.error('Failed to load'));
    await tester.pump();

    expect(find.text('Failed to load'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);

    await tester.tap(find.byType(ElevatedButton));
    expect(mockViewModel.lastLoadedSymbol, 'AAPL');
  });
}
