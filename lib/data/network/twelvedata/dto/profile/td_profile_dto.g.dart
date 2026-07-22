// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'td_profile_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TdProfileDto _$TdProfileDtoFromJson(Map<String, dynamic> json) => TdProfileDto(
  symbol: json['symbol'] as String,
  name: json['name'] as String,
  exchange: json['exchange'] as String,
  sector: json['sector'] as String,
  industry: json['industry'] as String,
  description: json['description'] as String,
  country: json['country'] as String,
);

Map<String, dynamic> _$TdProfileDtoToJson(TdProfileDto instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'name': instance.name,
      'exchange': instance.exchange,
      'sector': instance.sector,
      'industry': instance.industry,
      'description': instance.description,
      'country': instance.country,
    };
