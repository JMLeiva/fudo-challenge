// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'av_stock_quote_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AvStockQuoteDto _$AvStockQuoteDtoFromJson(Map<String, dynamic> json) =>
    AvStockQuoteDto(
      symbol: json['01. symbol'] as String,
      open: AvStockQuoteDto._stringToDouble(json['02. open']),
      high: AvStockQuoteDto._stringToDouble(json['03. high']),
      low: AvStockQuoteDto._stringToDouble(json['04. low']),
      price: AvStockQuoteDto._stringToDouble(json['05. price']),
      volume: AvStockQuoteDto._stringToLong(json['06. volume']),
      latestTradingDay: json['07. latest trading day'] as String,
      previousClose: AvStockQuoteDto._stringToDouble(
        json['08. previous close'],
      ),
      change: AvStockQuoteDto._stringToDouble(json['09. change']),
      changePercent: AvStockQuoteDto._percentageToDouble(
        json['10. change percent'],
      ),
    );

Map<String, dynamic> _$AvStockQuoteDtoToJson(AvStockQuoteDto instance) =>
    <String, dynamic>{
      '01. symbol': instance.symbol,
      '02. open': instance.open,
      '03. high': instance.high,
      '04. low': instance.low,
      '05. price': instance.price,
      '06. volume': instance.volume,
      '07. latest trading day': instance.latestTradingDay,
      '08. previous close': instance.previousClose,
      '09. change': instance.change,
      '10. change percent': instance.changePercent,
    };
