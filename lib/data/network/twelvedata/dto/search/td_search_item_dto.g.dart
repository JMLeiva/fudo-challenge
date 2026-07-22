// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'td_search_item_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TdSearchItemDto _$TdSearchItemDtoFromJson(Map<String, dynamic> json) =>
    TdSearchItemDto(
      symbol: json['symbol'] as String,
      instrumentName: json['instrument_name'] as String,
      exchange: json['exchange'] as String,
      country: json['country'] as String,
    );

Map<String, dynamic> _$TdSearchItemDtoToJson(TdSearchItemDto instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'instrument_name': instance.instrumentName,
      'exchange': instance.exchange,
      'country': instance.country,
    };
