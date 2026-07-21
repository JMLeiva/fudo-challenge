import 'package:fudo_challenge/domain/model/stock.dart';
import 'package:fudo_challenge/domain/model/stock_intraday_point.dart';
import 'package:fudo_challenge/domain/model/stock_overview.dart';
import 'package:fudo_challenge/domain/model/stock_quote.dart';
import 'package:fudo_challenge/domain/model/stock_search_item.dart';

import '../model/result.dart';

abstract interface class StockRepository {
  Future<Result<List<StockSearchItem>, String>> search(String query);
  Future<Result<Stock, String>> getStockDetails(String symbol);
  Future<Result<StockQuote, String>> getStockQuote(String symbol);
  Future<Result<StockOverview, String>> getStockOverview(String symbol);
  Future<Result<List<StockIntradayPoint>, String>> getIntradayData(String symbol);
}
