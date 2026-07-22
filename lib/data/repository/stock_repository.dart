import 'package:dart_either/dart_either.dart';
import 'package:fudo_challenge/domain/model/stock.dart';
import 'package:fudo_challenge/domain/model/stock_intraday_point.dart';
import 'package:fudo_challenge/domain/model/stock_overview.dart';
import 'package:fudo_challenge/domain/model/stock_quote.dart';
import 'package:fudo_challenge/domain/model/stock_search_item.dart';
import 'package:meta/meta.dart';

abstract class StockRepository {
  Future<Either<String, List<StockSearchItem>>> search(String query);

  Future<Either<String, Stock>> getStockDetails(String symbol) async {
    try {
      return Either.futureBinding((e) async {
        final StockQuote stockQuote = await getStockQuote(symbol).bind(e);
        final StockOverview stockOverview = await getStockOverview(symbol).bind(e);
        final List<StockIntradayPoint> stockIntraday = await getIntradayData(symbol).bind(e);

        return Stock(
            quote: stockQuote,
            overview: stockOverview,
            intraday: stockIntraday);
      });
    } catch (e) {
      return e.toString().left();
    }
  }

  @protected
  Future<Either<String, StockQuote>> getStockQuote(String symbol);

  @protected
  Future<Either<String, StockOverview>> getStockOverview(String symbol);

  @protected
  Future<Either<String, List<StockIntradayPoint>>> getIntradayData(String symbol);
}
