// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'td_intraday_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TdIntradayResponseDto _$TdIntradayResponseDtoFromJson(
  Map<String, dynamic> json,
) => TdIntradayResponseDto(
  values: (json['values'] as List<dynamic>)
      .map((e) => TdIntradayPointDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  status: json['status'] as String,
);

Map<String, dynamic> _$TdIntradayResponseDtoToJson(
  TdIntradayResponseDto instance,
) => <String, dynamic>{'values': instance.values, 'status': instance.status};
