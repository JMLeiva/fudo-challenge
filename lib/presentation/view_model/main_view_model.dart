import 'dart:async';

import 'package:fudo_challenge/data/model/stock_search_item.dart';
import 'package:fudo_challenge/data/repository/stock_repository.dart';
import 'package:injectable/injectable.dart';

import '../../data/model/result.dart' as res;
import 'search_view_ui_state.dart';

@injectable
class MainViewModel {
  final StockRepository _repository;
  final StreamController<SearchViewUIState> _stateController = StreamController<SearchViewUIState>.broadcast();
  Timer? _debounce;

  MainViewModel(this._repository) {
    _stateController.add(SearchViewUIState.empty());
  }

  Stream<SearchViewUIState> get stateStream => _stateController.stream;

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

    if (result is res.Success<List<StockSearchItem>, String>) {
      _stateController.add(SearchViewUIState.success(result.value));
    } else if (result is res.Failure<List<StockSearchItem>, String>) {
      _stateController.add(SearchViewUIState.error(result.value));
    }
  }

  void dispose() {
    _debounce?.cancel();
    _stateController.close();
  }
}
