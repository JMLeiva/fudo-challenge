import 'package:fudo_challenge/domain/model/stock_search_item.dart';

sealed class SearchViewUIState {
  const SearchViewUIState();

  factory SearchViewUIState.empty() => Empty();
  factory SearchViewUIState.loading() => Loading();
  factory SearchViewUIState.success(List<StockSearchItem> items) => Success(items);
  factory SearchViewUIState.error(String message) => Error(message);
}

class Empty extends SearchViewUIState {}

class Loading extends SearchViewUIState {}

class Success extends SearchViewUIState {
  final List<StockSearchItem> items;
  Success(this.items);
}

class Error extends SearchViewUIState {
  final String message;
  Error(this.message);
}
