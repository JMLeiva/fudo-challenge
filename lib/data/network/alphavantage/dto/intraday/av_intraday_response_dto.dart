import 'package:json_annotation/json_annotation.dart';

part 'av_intraday_response_dto.g.dart';

@JsonSerializable()
class AvIntradayResponseDto {
  final AvIntradayMetadataDto metadata;
  final List<AvIntradayPointDto> timeSeries;

  AvIntradayResponseDto({
    required this.metadata,
    required this.timeSeries,
  });

  factory AvIntradayResponseDto.fromJson(Map<String, dynamic> json) {
    final metadataJson = json['Meta Data'] as Map<String, dynamic>?;
    final metadata = metadataJson != null
        ? AvIntradayMetadataDto.fromJson(metadataJson)
        : AvIntradayMetadataDto(symbol: '', lastRefreshed: '', interval: '', timeZone: '');

    final timeSeriesKey = json.keys.firstWhere((k) => k.startsWith('Time Series'), orElse: () => '');
    final timeSeriesList = <AvIntradayPointDto>[];

    if (timeSeriesKey.isNotEmpty) {
      final timeSeriesJson = json[timeSeriesKey] as Map<String, dynamic>;
      timeSeriesJson.forEach((timestamp, value) {
        timeSeriesList.add(AvIntradayPointDto.fromEntry(timestamp, value as Map<String, dynamic>));
      });
    }

    // Sort by timestamp ascending as per Kotlin reference
    timeSeriesList.sort((a, b) => a.timestamp.compareTo(b.timestamp));

    return AvIntradayResponseDto(
      metadata: metadata,
      timeSeries: timeSeriesList,
    );
  }
}

@JsonSerializable()
class AvIntradayMetadataDto {
  @JsonKey(name: '2. Symbol')
  final String symbol;
  @JsonKey(name: '3. Last Refreshed')
  final String lastRefreshed;
  @JsonKey(name: '4. Interval')
  final String interval;
  @JsonKey(name: '6. Time Zone')
  final String timeZone;

  AvIntradayMetadataDto({
    required this.symbol,
    required this.lastRefreshed,
    required this.interval,
    required this.timeZone,
  });

  factory AvIntradayMetadataDto.fromJson(Map<String, dynamic> json) => _$AvIntradayMetadataDtoFromJson(json);
}

@JsonSerializable()
class AvIntradayPointDto {
  final String timestamp;
  @JsonKey(name: '1. open', fromJson: _stringToDouble)
  final double open;
  @JsonKey(name: '2. high', fromJson: _stringToDouble)
  final double high;
  @JsonKey(name: '3. low', fromJson: _stringToDouble)
  final double low;
  @JsonKey(name: '4. close', fromJson: _stringToDouble)
  final double close;
  @JsonKey(name: '5. volume', fromJson: _stringToLong)
  final int volume;

  AvIntradayPointDto({
    required this.timestamp,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    required this.volume,
  });

  factory AvIntradayPointDto.fromJson(Map<String, dynamic> json) => _$AvIntradayPointDtoFromJson(json);

  factory AvIntradayPointDto.fromEntry(String timestamp, Map<String, dynamic> json) {
    final mapWithTimestamp = Map<String, dynamic>.from(json);
    mapWithTimestamp['timestamp'] = timestamp;
    return AvIntradayPointDto.fromJson(mapWithTimestamp);
  }

  static int _stringToLong(dynamic value) => int.tryParse(value.toString()) ?? 0;
  static double _stringToDouble(dynamic value) => double.tryParse(value.toString()) ?? 0.0;
}
