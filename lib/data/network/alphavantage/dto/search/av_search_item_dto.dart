import 'package:json_annotation/json_annotation.dart';

part 'av_search_item_dto.g.dart';

@JsonSerializable()
class AvSearchItemDto {
  @JsonKey(name: '1. symbol')
  final String stockSymbol;
  @JsonKey(name: '2. name')
  final String companyName;
  @JsonKey(name: '4. region')
  final String region;

  AvSearchItemDto({
    required this.stockSymbol,
    required this.companyName,
    required this.region});

  factory AvSearchItemDto.fromJson(Map<String, dynamic> json) => _$AvSearchItemDtoFromJson(json);
  Map<String, dynamic> toJson() => _$AvSearchItemDtoToJson(this);
}