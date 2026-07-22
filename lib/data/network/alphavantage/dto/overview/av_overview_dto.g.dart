// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'av_overview_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AvOverviewDto _$AvOverviewDtoFromJson(Map<String, dynamic> json) =>
    AvOverviewDto(
      symbol: json['Symbol'] as String,
      name: json['Name'] as String,
      description: json['Description'] as String,
      exchange: json['Exchange'] as String,
      currency: json['Currency'] as String,
      country: json['Country'] as String,
      sector: json['Sector'] as String,
      industry: json['Industry'] as String,
      marketCapitalization: AvOverviewDto._stringToLong(
        json['MarketCapitalization'],
      ),
      peRatio: AvOverviewDto._stringToDouble(json['PERatio']),
      dividendYield: AvOverviewDto._stringToDouble(json['DividendYield']),
      eps: AvOverviewDto._stringToDouble(json['EPS']),
      fiftyTwoWeekHigh: AvOverviewDto._stringToDouble(json['52WeekHigh']),
      fiftyTwoWeekLow: AvOverviewDto._stringToDouble(json['52WeekLow']),
    );

Map<String, dynamic> _$AvOverviewDtoToJson(AvOverviewDto instance) =>
    <String, dynamic>{
      'Symbol': instance.symbol,
      'Name': instance.name,
      'Description': instance.description,
      'Exchange': instance.exchange,
      'Currency': instance.currency,
      'Country': instance.country,
      'Sector': instance.sector,
      'Industry': instance.industry,
      'MarketCapitalization': instance.marketCapitalization,
      'PERatio': instance.peRatio,
      'DividendYield': instance.dividendYield,
      'EPS': instance.eps,
      '52WeekHigh': instance.fiftyTwoWeekHigh,
      '52WeekLow': instance.fiftyTwoWeekLow,
    };
