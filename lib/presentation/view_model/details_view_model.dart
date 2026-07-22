import 'dart:async';

import 'package:injectable/injectable.dart';
import '../../data/repository/stock_repository.dart';
import 'details_view_ui_state.dart';

@injectable
class DetailsViewModel {
  final StockRepository _repository;
  final StreamController<DetailsViewUIState> _stateController = StreamController<DetailsViewUIState>.broadcast();

  DetailsViewModel(this._repository);

  Stream<DetailsViewUIState> get stateStream => _stateController.stream;

  Future<void> loadStockDetails(String symbol) async {
    _stateController.add(DetailsViewUIState.loading());

    final result = await _repository.getStockDetails(symbol);

    result.fold(
        ifLeft: (error) => _stateController.add(DetailsViewUIState.error(error)),
        ifRight: (stock) => _stateController.add(DetailsViewUIState.success(stock))
    );
  }

  void dispose() {
    _stateController.close();
  }
}
