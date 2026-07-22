class StockQuote {
  final String symbol;
  final double open;
  final double high;
  final double low;
  final double price;
  final int volume;
  final String latestTradingDay;
  final double previousClose;
  final double change;
  final double changePercent;

  StockQuote({
    required this.symbol,
    required this.open,
    required this.high,
    required this.low,
    required this.price,
    required this.volume,
    required this.latestTradingDay,
    required this.previousClose,
    required this.change,
    required this.changePercent,
  });
}
