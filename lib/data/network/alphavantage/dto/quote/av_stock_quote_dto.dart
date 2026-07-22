import 'package:json_annotation/json_annotation.dart';

part 'av_stock_quote_dto.g.dart';

@JsonSerializable()
class AvStockQuoteDto {
  @JsonKey(name: '01. symbol')
  final String symbol;
  @JsonKey(name: '02. open', fromJson: _stringToDouble)
  final double open;
  @JsonKey(name: '03. high', fromJson: _stringToDouble)
  final double high;
  @JsonKey(name: '04. low', fromJson: _stringToDouble)
  final double low;
  @JsonKey(name: '05. price', fromJson: _stringToDouble)
  final double price;
  @JsonKey(name: '06. volume', fromJson: _stringToLong)
  final int volume;
  @JsonKey(name: '07. latest trading day')
  final String latestTradingDay;
  @JsonKey(name: '08. previous close', fromJson: _stringToDouble)
  final double previousClose;
  @JsonKey(name: '09. change', fromJson: _stringToDouble)
  final double change;
  @JsonKey(name: '10. change percent', fromJson: _percentageToDouble)
  final double changePercent;

  AvStockQuoteDto({
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

  factory AvStockQuoteDto.fromJson(Map<String, dynamic> json) {
    final quote = json['Global Quote'] as Map<String, dynamic>?;
    if (quote == null || quote.isEmpty) {
      throw Exception("Global Quote not found in response");
    }
    return _$AvStockQuoteDtoFromJson(quote);
  }

  Map<String, dynamic> toJson() => {'Global Quote': _$AvStockQuoteDtoToJson(this)};

  static int _stringToLong(dynamic value) => int.tryParse(value.toString()) ?? 0;
  static double _stringToDouble(dynamic value) => double.tryParse(value.toString()) ?? 0.0;
  static double _percentageToDouble(dynamic value) {
    if (value == null) return 0.0;
    final str = value.toString().replaceAll('%', '');
    return double.tryParse(str) ?? 0.0;
  }
}
