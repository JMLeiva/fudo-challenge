// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'td_quote_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TdQuoteDto _$TdQuoteDtoFromJson(Map<String, dynamic> json) => TdQuoteDto(
  symbol: json['symbol'] as String,
  name: json['name'] as String,
  exchange: json['exchange'] as String,
  currency: json['currency'] as String,
  datetime: json['datetime'] as String,
  open: json['open'] as String,
  high: json['high'] as String,
  low: json['low'] as String,
  close: json['close'] as String,
  volume: json['volume'] as String,
  previousClose: json['previous_close'] as String,
  change: json['change'] as String,
  percentChange: json['percent_change'] as String,
  fiftyTwoWeek: TdFiftyTwoWeekDto.fromJson(
    json['fifty_two_week'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$TdQuoteDtoToJson(TdQuoteDto instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'name': instance.name,
      'exchange': instance.exchange,
      'currency': instance.currency,
      'datetime': instance.datetime,
      'open': instance.open,
      'high': instance.high,
      'low': instance.low,
      'close': instance.close,
      'volume': instance.volume,
      'previous_close': instance.previousClose,
      'change': instance.change,
      'percent_change': instance.percentChange,
      'fifty_two_week': instance.fiftyTwoWeek,
    };

TdFiftyTwoWeekDto _$TdFiftyTwoWeekDtoFromJson(Map<String, dynamic> json) =>
    TdFiftyTwoWeekDto(low: json['low'] as String, high: json['high'] as String);

Map<String, dynamic> _$TdFiftyTwoWeekDtoToJson(TdFiftyTwoWeekDto instance) =>
    <String, dynamic>{'low': instance.low, 'high': instance.high};
