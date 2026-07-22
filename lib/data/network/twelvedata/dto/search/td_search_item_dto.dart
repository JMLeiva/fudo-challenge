import 'package:json_annotation/json_annotation.dart';

part 'td_search_item_dto.g.dart';

@JsonSerializable()
class TdSearchItemDto {
  final String symbol;
  @JsonKey(name: 'instrument_name')
  final String instrumentName;
  final String exchange;
  final String country;

  TdSearchItemDto({
    required this.symbol,
    required this.instrumentName,
    required this.exchange,
    required this.country,
  });

  factory TdSearchItemDto.fromJson(Map<String, dynamic> json) => _$TdSearchItemDtoFromJson(json);
  Map<String, dynamic> toJson() => _$TdSearchItemDtoToJson(this);
}
