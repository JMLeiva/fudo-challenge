// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'av_search_item_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AvSearchItemDto _$AvSearchItemDtoFromJson(Map<String, dynamic> json) =>
    AvSearchItemDto(
      stockSymbol: json['1. symbol'] as String,
      companyName: json['2. name'] as String,
      region: json['4. region'] as String,
    );

Map<String, dynamic> _$AvSearchItemDtoToJson(AvSearchItemDto instance) =>
    <String, dynamic>{
      '1. symbol': instance.stockSymbol,
      '2. name': instance.companyName,
      '4. region': instance.region,
    };
