import 'package:fudo_challenge/data/model/result.dart' as res;
import 'package:fudo_challenge/data/repository/stock_repository.dart';
import 'package:fudo_challenge/domain/model/stock.dart';
import 'package:fudo_challenge/domain/model/stock_intraday_point.dart';
import 'package:fudo_challenge/domain/model/stock_overview.dart';
import 'package:fudo_challenge/domain/model/stock_quote.dart';
import 'package:fudo_challenge/domain/model/stock_search_item.dart';

class MockStockRepository implements StockRepository {
  res.Result<List<StockSearchItem>, String>? searchResult;
  res.Result<Stock, String>? stockDetailsResult;

  @override
  Future<res.Result<List<StockSearchItem>, String>> search(String query) async {
    return searchResult!;
  }

  @override
  Future<res.Result<Stock, String>> getStockDetails(String symbol) async {
    return stockDetailsResult!;
  }

  @override
  Future<res.Result<List<StockIntradayPoint>, String>> getIntradayData(String symbol) {
    throw UnimplementedError();
  }

  @override
  Future<res.Result<StockOverview, String>> getStockOverview(String symbol) {
    throw UnimplementedError();
  }

  @override
  Future<res.Result<StockQuote, String>> getStockQuote(String symbol) {
    throw UnimplementedError();
  }
}
