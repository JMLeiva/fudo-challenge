import 'dart:async';

import 'package:fudo_challenge/domain/model/stock_search_item.dart';
import 'package:fudo_challenge/data/repository/stock_repository.dart';
import 'package:injectable/injectable.dart';

import 'search_view_ui_state.dart';

@injectable
class SearchViewModel {
  final StockRepository _repository;
  final StreamController<SearchViewUIState> _stateController = StreamController<SearchViewUIState>.broadcast();
  final StreamController<StockSearchItem> _navigationController = StreamController<StockSearchItem>.broadcast();
  Timer? _debounce;

  SearchViewModel(this._repository) {
    _stateController.add(SearchViewUIState.empty());
  }

  Stream<SearchViewUIState> get stateStream => _stateController.stream;
  Stream<StockSearchItem> get navigationStream => _navigationController.stream;

  void onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _search(query);
    });
  }

  Future<void> _search(String query) async {
    if (query.trim().isEmpty) {
      _stateController.add(SearchViewUIState.empty());
      return;
    }

    _stateController.add(SearchViewUIState.loading());

    final result = await _repository.search(query);

    result.fold(
      ifLeft: (error) => _stateController.add(SearchViewUIState.error(error)),
      ifRight: (items) => _stateController.add(SearchViewUIState.success(items)),
    );
  }

  void onStockItemTap(StockSearchItem item) {
    _navigationController.add(item);
  }

  void dispose() {
    _debounce?.cancel();
    _stateController.close();
    _navigationController.close();
  }
}
