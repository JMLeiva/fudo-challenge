import 'package:json_annotation/json_annotation.dart';
import 'av_search_item_dto.dart';

part 'av_search_response_dto.g.dart';

@JsonSerializable()
class AvSearchResponseDto {
  @JsonKey(name: 'bestMatches')
  final List<AvSearchItemDto>? bestMatches;

  AvSearchResponseDto({this.bestMatches});

  factory AvSearchResponseDto.fromJson(Map<String, dynamic> json) => _$AvSearchResponseDtoFromJson(json);
  Map<String, dynamic> toJson() => _$AvSearchResponseDtoToJson(this);
}
