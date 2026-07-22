import 'dart:async';
import 'package:fudo_challenge/domain/model/stock_search_item.dart';
import 'package:fudo_challenge/presentation/view_model/search_view_model.dart';
import 'package:fudo_challenge/presentation/view_model/search_view_ui_state.dart';

class MockSearchViewModel implements SearchViewModel {
  final _stateController = StreamController<SearchViewUIState>.broadcast();
  final _navigationController = StreamController<StockSearchItem>.broadcast();

  @override
  Stream<SearchViewUIState> get stateStream => _stateController.stream;

  @override
  Stream<StockSearchItem> get navigationStream => _navigationController.stream;

  String? lastSearchQuery;
  StockSearchItem? lastTappedItem;

  @override
  void onSearchChanged(String query) {
    lastSearchQuery = query;
  }

  @override
  void onStockItemTap(StockSearchItem item) {
    lastTappedItem = item;
    _navigationController.add(item);
  }

  @override
  void dispose() {
    _stateController.close();
    _navigationController.close();
  }

  void emit(SearchViewUIState state) {
    _stateController.add(state);
  }
}
