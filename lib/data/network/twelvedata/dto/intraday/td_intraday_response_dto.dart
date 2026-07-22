import 'package:json_annotation/json_annotation.dart';
import 'td_intraday_point_dto.dart';

part 'td_intraday_response_dto.g.dart';

@JsonSerializable()
class TdIntradayResponseDto {
  final List<TdIntradayPointDto> values;
  final String status;

  TdIntradayResponseDto({
    required this.values,
    required this.status,
  });

  factory TdIntradayResponseDto.fromJson(Map<String, dynamic> json) => _$TdIntradayResponseDtoFromJson(json);
  Map<String, dynamic> toJson() => _$TdIntradayResponseDtoToJson(this);
}
