import 'package:json_annotation/json_annotation.dart';

part 'td_quote_dto.g.dart';

@JsonSerializable()
class TdQuoteDto {
  final String symbol;
  final String name;
  final String exchange;
  final String currency;
  final String datetime;
  final String open;
  final String high;
  final String low;
  final String close;
  final String volume;
  @JsonKey(name: 'previous_close')
  final String previousClose;
  final String change;
  @JsonKey(name: 'percent_change')
  final String percentChange;
  @JsonKey(name: 'fifty_two_week')
  final TdFiftyTwoWeekDto fiftyTwoWeek;

  TdQuoteDto({
    required this.symbol,
    required this.name,
    required this.exchange,
    required this.currency,
    required this.datetime,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    required this.volume,
    required this.previousClose,
    required this.change,
    required this.percentChange,
    required this.fiftyTwoWeek,
  });

  factory TdQuoteDto.fromJson(Map<String, dynamic> json) => _$TdQuoteDtoFromJson(json);
  Map<String, dynamic> toJson() => _$TdQuoteDtoToJson(this);
}

@JsonSerializable()
class TdFiftyTwoWeekDto {
  final String low;
  final String high;

  TdFiftyTwoWeekDto({
    required this.low,
    required this.high,
  });

  factory TdFiftyTwoWeekDto.fromJson(Map<String, dynamic> json) => _$TdFiftyTwoWeekDtoFromJson(json);
  Map<String, dynamic> toJson() => _$TdFiftyTwoWeekDtoToJson(this);
}
