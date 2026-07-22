// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'td_search_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TdSearchResponseDto _$TdSearchResponseDtoFromJson(Map<String, dynamic> json) =>
    TdSearchResponseDto(
      data: (json['data'] as List<dynamic>)
          .map((e) => TdSearchItemDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String,
    );

Map<String, dynamic> _$TdSearchResponseDtoToJson(
  TdSearchResponseDto instance,
) => <String, dynamic>{'data': instance.data, 'status': instance.status};
