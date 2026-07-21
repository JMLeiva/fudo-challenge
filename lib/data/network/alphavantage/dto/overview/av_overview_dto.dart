import 'package:json_annotation/json_annotation.dart';

part 'av_overview_dto.g.dart';

@JsonSerializable()
class AvOverviewDto {
  @JsonKey(name: 'Symbol')
  final String symbol;
  @JsonKey(name: 'Name')
  final String name;
  @JsonKey(name: 'Description')
  final String description;
  @JsonKey(name: 'Exchange')
  final String exchange;
  @JsonKey(name: 'Currency')
  final String currency;
  @JsonKey(name: 'Country')
  final String country;
  @JsonKey(name: 'Sector')
  final String sector;
  @JsonKey(name: 'Industry')
  final String industry;
  @JsonKey(name: 'MarketCapitalization', fromJson: _stringToLong)
  final int marketCapitalization;
  @JsonKey(name: 'PERatio', fromJson: _stringToDouble)
  final double peRatio;
  @JsonKey(name: 'DividendYield', fromJson: _stringToDouble)
  final double dividendYield;
  @JsonKey(name: 'EPS', fromJson: _stringToDouble)
  final double eps;
  @JsonKey(name: '52WeekHigh', fromJson: _stringToDouble)
  final double fiftyTwoWeekHigh;
  @JsonKey(name: '52WeekLow', fromJson: _stringToDouble)
  final double fiftyTwoWeekLow;

  AvOverviewDto({
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

  factory AvOverviewDto.fromJson(Map<String, dynamic> json) => _$AvOverviewDtoFromJson(json);
  Map<String, dynamic> toJson() => _$AvOverviewDtoToJson(this);

  static int _stringToLong(dynamic value) => int.tryParse(value.toString()) ?? 0;
  static double _stringToDouble(dynamic value) => double.tryParse(value.toString()) ?? 0.0;
}
