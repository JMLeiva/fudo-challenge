import 'stock_quote.dart';
import 'stock_overview.dart';
import 'stock_intraday_point.dart';

class Stock {
  final StockQuote quote;
  final StockOverview overview;
  final List<StockIntradayPoint> intraday;

  Stock({
    required this.quote,
    required this.overview,
    required this.intraday,
  });

  String get symbol => quote.symbol;
  String get name => overview.name;
}
