
import 'package:dart_either/dart_either.dart';
import 'package:fudo_challenge/data/repository/stock_repository.dart';
import 'package:fudo_challenge/domain/model/stock_intraday_point.dart';
import 'package:fudo_challenge/domain/model/stock_overview.dart';
import 'package:fudo_challenge/domain/model/stock_quote.dart';
import 'package:fudo_challenge/domain/model/stock_search_item.dart';

class StockRepositoryMemoryCache extends StockRepository {

  StockRepository _fallback;

  StockRepositoryMemoryCache(this._fallback);

  @override
  Future<Either<String, List<StockIntradayPoint>>> getIntradayData(String symbol) {
    // TODO: implement getIntradayData
    throw UnimplementedError();
  }

  @override
  Future<Either<String, StockOverview>> getStockOverview(String symbol) {
    // TODO: implement getStockOverview
    throw UnimplementedError();
  }

  @override
  Future<Either<String, StockQuote>> getStockQuote(String symbol) {
    // TODO: implement getStockQuote
    throw UnimplementedError();
  }

  @override
  Future<Either<String, List<StockSearchItem>>> search(String query) {
    // TODO: implement search
    throw UnimplementedError();
  }

}
