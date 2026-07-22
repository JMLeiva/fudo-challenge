import '../../domain/model/stock.dart';

sealed class DetailsViewUIState {
  const DetailsViewUIState();

  factory DetailsViewUIState.loading() => Loading();
  factory DetailsViewUIState.success(Stock stock) => Success(stock);
  factory DetailsViewUIState.error(String message) => Error(message);
}

class Loading extends DetailsViewUIState {}

class Success extends DetailsViewUIState {
  final Stock stock;
  Success(this.stock);
}

class Error extends DetailsViewUIState {
  final String message;
  Error(this.message);
}
