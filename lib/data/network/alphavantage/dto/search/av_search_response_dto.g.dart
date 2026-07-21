// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'av_search_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AvSearchResponseDto _$AvSearchResponseDtoFromJson(Map<String, dynamic> json) =>
    AvSearchResponseDto(
      (json['bestMatches'] as List<dynamic>)
          .map((e) => AvSearchItemDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AvSearchResponseDtoToJson(
  AvSearchResponseDto instance,
) => <String, dynamic>{'bestMatches': instance.bestMatches};
