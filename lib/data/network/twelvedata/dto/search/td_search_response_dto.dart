import 'package:json_annotation/json_annotation.dart';
import 'td_search_item_dto.dart';

part 'td_search_response_dto.g.dart';

@JsonSerializable()
class TdSearchResponseDto {
  final List<TdSearchItemDto> data;
  final String status;

  TdSearchResponseDto({
    required this.data,
    required this.status,
  });

  factory TdSearchResponseDto.fromJson(Map<String, dynamic> json) => _$TdSearchResponseDtoFromJson(json);
  Map<String, dynamic> toJson() => _$TdSearchResponseDtoToJson(this);
}
