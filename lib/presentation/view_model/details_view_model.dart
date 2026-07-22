import 'dart:async';

import 'package:injectable/injectable.dart';
import '../../data/repository/stock_repository.dart';
import '../../data/model/result.dart' as res;
import '../../domain/model/stock.dart';
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

    if (result is res.Success<Stock, String>) {
      _stateController.add(DetailsViewUIState.success(result.value));
    } else if (result is res.Failure<Stock, String>) {
      _stateController.add(DetailsViewUIState.error(result.value));
    }
  }

  void dispose() {
    _stateController.close();
  }
}
