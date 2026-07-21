// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'av_intraday_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AvIntradayResponseDto _$AvIntradayResponseDtoFromJson(
  Map<String, dynamic> json,
) => AvIntradayResponseDto(
  metadata: AvIntradayMetadataDto.fromJson(
    json['metadata'] as Map<String, dynamic>,
  ),
  timeSeries: (json['timeSeries'] as List<dynamic>)
      .map((e) => AvIntradayPointDto.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$AvIntradayResponseDtoToJson(
  AvIntradayResponseDto instance,
) => <String, dynamic>{
  'metadata': instance.metadata,
  'timeSeries': instance.timeSeries,
};

AvIntradayMetadataDto _$AvIntradayMetadataDtoFromJson(
  Map<String, dynamic> json,
) => AvIntradayMetadataDto(
  symbol: json['2. Symbol'] as String,
  lastRefreshed: json['3. Last Refreshed'] as String,
  interval: json['4. Interval'] as String,
  timeZone: json['6. Time Zone'] as String,
);

Map<String, dynamic> _$AvIntradayMetadataDtoToJson(
  AvIntradayMetadataDto instance,
) => <String, dynamic>{
  '2. Symbol': instance.symbol,
  '3. Last Refreshed': instance.lastRefreshed,
  '4. Interval': instance.interval,
  '6. Time Zone': instance.timeZone,
};

AvIntradayPointDto _$AvIntradayPointDtoFromJson(Map<String, dynamic> json) =>
    AvIntradayPointDto(
      timestamp: json['timestamp'] as String,
      open: AvIntradayPointDto._stringToDouble(json['1. open']),
      high: AvIntradayPointDto._stringToDouble(json['2. high']),
      low: AvIntradayPointDto._stringToDouble(json['3. low']),
      close: AvIntradayPointDto._stringToDouble(json['4. close']),
      volume: AvIntradayPointDto._stringToLong(json['5. volume']),
    );

Map<String, dynamic> _$AvIntradayPointDtoToJson(AvIntradayPointDto instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp,
      '1. open': instance.open,
      '2. high': instance.high,
      '3. low': instance.low,
      '4. close': instance.close,
      '5. volume': instance.volume,
    };
