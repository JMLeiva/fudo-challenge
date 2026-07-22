import 'package:json_annotation/json_annotation.dart';

part 'td_profile_dto.g.dart';

@JsonSerializable()
class TdProfileDto {
  final String symbol;
  final String name;
  final String exchange;
  final String sector;
  final String industry;
  final String description;
  final String country;

  TdProfileDto({
    required this.symbol,
    required this.name,
    required this.exchange,
    required this.sector,
    required this.industry,
    required this.description,
    required this.country,
  });

  factory TdProfileDto.fromJson(Map<String, dynamic> json) => _$TdProfileDtoFromJson(json);
  Map<String, dynamic> toJson() => _$TdProfileDtoToJson(this);
}
