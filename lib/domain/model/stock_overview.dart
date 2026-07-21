class StockOverview {
  final String symbol;
  final String name;
  final String description;
  final String exchange;
  final String currency;
  final String country;
  final String sector;
  final String industry;
  final int marketCapitalization;
  final double peRatio;
  final double dividendYield;
  final double eps;
  final double fiftyTwoWeekHigh;
  final double fiftyTwoWeekLow;

  StockOverview({
    required this.symbol,
    required this.name,
    required this.description,
    required this.exchange,
    required this.currency,
    required this.country,
    required this.sector,
    required this.industry,
    required this.marketCapitalization,
    required this.peRatio,
    required this.dividendYield,
    required this.eps,
    required this.fiftyTwoWeekHigh,
    required this.fiftyTwoWeekLow,
  });
}
