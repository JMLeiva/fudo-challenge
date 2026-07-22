// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'td_intraday_point_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TdIntradayPointDto _$TdIntradayPointDtoFromJson(Map<String, dynamic> json) =>
    TdIntradayPointDto(
      datetime: json['datetime'] as String,
      open: json['open'] as String,
      high: json['high'] as String,
      low: json['low'] as String,
      close: json['close'] as String,
      volume: json['volume'] as String,
    );

Map<String, dynamic> _$TdIntradayPointDtoToJson(TdIntradayPointDto instance) =>
    <String, dynamic>{
      'datetime': instance.datetime,
      'open': instance.open,
      'high': instance.high,
      'low': instance.low,
      'close': instance.close,
      'volume': instance.volume,
    };
