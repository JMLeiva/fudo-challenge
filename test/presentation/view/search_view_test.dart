import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fudo_challenge/di/injection.dart';
import 'package:fudo_challenge/domain/model/stock_search_item.dart';
import 'package:fudo_challenge/l10n/app_localizations.dart';
import 'package:fudo_challenge/presentation/view/search_view.dart';
import 'package:fudo_challenge/presentation/view_model/search_view_model.dart';
import 'package:fudo_challenge/presentation/view_model/search_view_ui_state.dart';
import '../../mocks/mock_search_view_model.dart';

void main() {
  late MockSearchViewModel mockViewModel;

  setUp(() {
    mockViewModel = MockSearchViewModel();
    getIt.allowReassignment = true;
    getIt.registerFactory<SearchViewModel>(() => mockViewModel);
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en')],
      home: const SearchView(),
    );
  }

  testWidgets('should show empty prompt initially', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());
    
    mockViewModel.emit(SearchViewUIState.empty());
    await tester.pump();

    expect(find.text('Try searching something'), findsOneWidget);
  });

  testWidgets('should show loading indicator when state is loading', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());
    
    mockViewModel.emit(SearchViewUIState.loading());
    await tester.pump();

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('should show list of items when state is success', (WidgetTester tester) async {
    final items = [
      StockSearchItem('AAPL', 'Apple Inc.', 'United States'),
      StockSearchItem('MSFT', 'Microsoft Corporation', 'United States'),
    ];

    await tester.pumpWidget(createWidgetUnderTest());
    
    mockViewModel.emit(SearchViewUIState.success(items));
    await tester.pump();

    expect(find.text('AAPL'), findsOneWidget);
    expect(find.text('Apple Inc.'), findsOneWidget);
    expect(find.text('MSFT'), findsOneWidget);
    expect(find.text('Microsoft Corporation'), findsOneWidget);
  });

  testWidgets('should call onSearchChanged when text changes', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());
    
    await tester.enterText(find.byType(TextField), 'Apple');
    
    expect(mockViewModel.lastSearchQuery, 'Apple');
  });

  testWidgets('should call onStockItemTap when an item is tapped', (WidgetTester tester) async {
    final items = [
      StockSearchItem('AAPL', 'Apple Inc.', 'United States'),
    ];

    await tester.pumpWidget(createWidgetUnderTest());
    
    mockViewModel.emit(SearchViewUIState.success(items));
    await tester.pump();

    await tester.tap(find.text('AAPL'));
    
    expect(mockViewModel.lastTappedItem, items[0]);
  });
}
