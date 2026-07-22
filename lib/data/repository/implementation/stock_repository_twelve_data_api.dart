import 'package:dart_either/dart_either.dart';
import 'package:fudo_challenge/domain/model/stock_intraday_point.dart';
import 'package:fudo_challenge/domain/model/stock_overview.dart';
import 'package:fudo_challenge/domain/model/stock_quote.dart';
import 'package:fudo_challenge/domain/model/stock_search_item.dart';
import 'package:fudo_challenge/data/network/twelvedata/twelve_data_api.dart';
import 'package:fudo_challenge/data/repository/stock_repository.dart';
import 'package:injectable/injectable.dart';

import '../../network/twelvedata/dto/intraday/td_intraday_response_dto.dart';
import '../../network/twelvedata/dto/profile/td_profile_dto.dart';
import '../../network/twelvedata/dto/quote/td_quote_dto.dart';
import '../../network/twelvedata/dto/search/td_search_response_dto.dart';

@injectable
class StockRepositoryTwelveDataApi extends StockRepository {
  final TwelveDataApi _api;

  StockRepositoryTwelveDataApi(this._api);

  @override
  Future<Either<String, List<StockSearchItem>>> search(String query) async {
    if (query.isEmpty) {
      return Either.right([]);
    }

    try {
      TdSearchResponseDto response = await _api.search(query);

      return response.data
          .map((e) => StockSearchItem(e.symbol, e.instrumentName, e.country))
          .toList()
          .right();
    } catch (e) {
      return e.toString().left();
    }
  }

  @override
  Future<Either<String, StockQuote>> getStockQuote(String symbol) async {
    try {
      final dto = await _api.getQuote(symbol);
      return _mapQuote(dto).right();
    } catch (e) {
      return e.toString().left();
    }
  }

  @override
  Future<Either<String, StockOverview>> getStockOverview(String symbol) async {
    try {
      final quoteDto = await _api.getQuote(symbol);
      final profileDto = await _api.getProfile(symbol);
      return _mapOverview(profileDto, quoteDto).right();
    } catch (e) {
      return e.toString().left();
    }
  }

  @override
  Future<Either<String, List<StockIntradayPoint>>> getIntradayData(
      String symbol) async {
    try {
      final dto = await _api.getIntradayData(symbol, '5min');
      return _mapIntraday(dto).right();
    } catch (e) {
      return e.toString().left();
    }
  }

  StockQuote _mapQuote(TdQuoteDto dto) {
    return StockQuote(
      symbol: dto.symbol,
      open: double.tryParse(dto.open) ?? 0.0,
      high: double.tryParse(dto.high) ?? 0.0,
      low: double.tryParse(dto.low) ?? 0.0,
      price: double.tryParse(dto.close) ?? 0.0,
      volume: int.tryParse(dto.volume) ?? 0,
      latestTradingDay: dto.datetime,
      previousClose: double.tryParse(dto.previousClose) ?? 0.0,
      change: double.tryParse(dto.change) ?? 0.0,
      changePercent: double.tryParse(dto.percentChange) ?? 0.0,
    );
  }

  StockOverview _mapOverview(TdProfileDto profile, TdQuoteDto quote) {
    return StockOverview(
      symbol: profile.symbol,
      name: profile.name,
      description: profile.description,
      exchange: profile.exchange,
      currency: quote.currency,
      country: profile.country,
      sector: profile.sector,
      industry: profile.industry,
      marketCapitalization: 0,
      peRatio: 0.0,
      dividendYield: 0.0,
      eps: 0.0,
      fiftyTwoWeekHigh: double.tryParse(quote.fiftyTwoWeek.high) ?? 0.0,
      fiftyTwoWeekLow: double.tryParse(quote.fiftyTwoWeek.low) ?? 0.0,
    );
  }

  List<StockIntradayPoint> _mapIntraday(TdIntradayResponseDto dto) {
    return dto.values
        .map((e) => StockIntradayPoint(
              dateTime: DateTime.parse(e.datetime),
              open: double.tryParse(e.open) ?? 0.0,
              high: double.tryParse(e.high) ?? 0.0,
              low: double.tryParse(e.low) ?? 0.0,
              close: double.tryParse(e.close) ?? 0.0,
              volume: int.tryParse(e.volume) ?? 0,
            ))
        .toList();
  }
}
