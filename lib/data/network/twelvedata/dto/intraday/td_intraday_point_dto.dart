import 'package:json_annotation/json_annotation.dart';

part 'td_intraday_point_dto.g.dart';

@JsonSerializable()
class TdIntradayPointDto {
  final String datetime;
  final String open;
  final String high;
  final String low;
  final String close;
  final String volume;

  TdIntradayPointDto({
    required this.datetime,
    required this.open,
    required this.high,
    required this.low,
    required this.close,
    required this.volume,
  });

  factory TdIntradayPointDto.fromJson(Map<String, dynamic> json) => _$TdIntradayPointDtoFromJson(json);
  Map<String, dynamic> toJson() => _$TdIntradayPointDtoToJson(this);
}
