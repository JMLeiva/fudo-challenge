import 'dart:async';
import 'package:fudo_challenge/presentation/view_model/details_view_model.dart';
import 'package:fudo_challenge/presentation/view_model/details_view_ui_state.dart';

class MockDetailsViewModel implements DetailsViewModel {
  final _stateController = StreamController<DetailsViewUIState>.broadcast();

  @override
  Stream<DetailsViewUIState> get stateStream => _stateController.stream;

  String? lastLoadedSymbol;

  @override
  Future<void> loadStockDetails(String symbol) async {
    lastLoadedSymbol = symbol;
  }

  @override
  void dispose() {
    _stateController.close();
  }

  void emit(DetailsViewUIState state) {
    _stateController.add(state);
  }
}
