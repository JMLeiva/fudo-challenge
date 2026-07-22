import 'package:dart_either/dart_either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fake_async/fake_async.dart';
import 'package:fudo_challenge/domain/model/stock_search_item.dart';
import 'package:fudo_challenge/presentation/view_model/search_view_model.dart';
import 'package:fudo_challenge/presentation/view_model/search_view_ui_state.dart' as ui;
import '../../mocks/mock_stock_repository.dart';

void main() {
  late SearchViewModel viewModel;
  late MockStockRepository mockRepository;

  setUp(() {
    mockRepository = MockStockRepository();
    viewModel = SearchViewModel(mockRepository);
  });

  tearDown(() {
    viewModel.dispose();
  });

  group('SearchViewModel', () {
    final mockSearchItems = [
      StockSearchItem('AAPL', 'Apple Inc.', 'United States'),
      StockSearchItem('MSFT', 'Microsoft Corporation', 'United States'),
    ];

    test('onSearchChanged emits loading then success after debounce when query is valid', () {
      fakeAsync((async) {
        // Arrange
        mockRepository.searchResult = mockSearchItems.right();

        // Act & Assert
        expectLater(
          viewModel.stateStream,
          emitsInOrder([
            isA<ui.Loading>(),
            isA<ui.Success>().having((s) => s.items, 'items', mockSearchItems),
          ]),
        );

        viewModel.onSearchChanged('Apple');
        async.elapse(const Duration(milliseconds: 500));
        async.flushMicrotasks();
      });
    });

    test('onSearchChanged emits empty after debounce when query is empty', () {
       fakeAsync((async) {
        // Act & Assert
        expectLater(
          viewModel.stateStream,
          emits(isA<ui.Empty>()),
        );

        viewModel.onSearchChanged('');
        async.elapse(const Duration(milliseconds: 500));
        async.flushMicrotasks();
      });
    });

    test('onSearchChanged emits error after debounce when repository call fails', () {
      fakeAsync((async) {
        // Arrange
        mockRepository.searchResult = 'API error'.left();

        // Act & Assert
        expectLater(
          viewModel.stateStream,
          emitsInOrder([
            isA<ui.Loading>(),
            isA<ui.Error>().having((s) => s.message, 'message', 'API error'),
          ]),
        );

        viewModel.onSearchChanged('Apple');
        async.elapse(const Duration(milliseconds: 500));
        async.flushMicrotasks();
      });
    });

    test('onStockItemTap emits navigation event', () {
      // Arrange
      final item = mockSearchItems[0];

      // Act & Assert
      expect(viewModel.navigationStream, emits(item));

      viewModel.onStockItemTap(item);
    });
  });
}
