import 'package:dart_either/dart_either.dart';
import 'package:fudo_challenge/domain/model/stock_intraday_point.dart';
import 'package:fudo_challenge/domain/model/stock_overview.dart';
import 'package:fudo_challenge/domain/model/stock_quote.dart';
import 'package:fudo_challenge/domain/model/stock_search_item.dart';
import 'package:fudo_challenge/data/network/alphavantage/alpha_vantage_api.dart';
import 'package:fudo_challenge/data/repository/stock_repository.dart';
import 'package:injectable/injectable.dart';

import '../../network/alphavantage/dto/intraday/av_intraday_response_dto.dart';
import '../../network/alphavantage/dto/overview/av_overview_dto.dart';
import '../../network/alphavantage/dto/quote/av_stock_quote_dto.dart';
import '../../network/alphavantage/dto/search/av_search_response_dto.dart';

@injectable
class StockRepositoryAvApi extends StockRepository {
  final AlphaVantageApi _api;

  StockRepositoryAvApi(this._api);

  @override
  Future<Either<String, List<StockSearchItem>>> search(String query) async {
    if (query.isEmpty) {
      return Either.right([]);
    }

    try {
      AvSearchResponseDto response = await _api.search(query);

      return response.bestMatches.map((e) =>
          StockSearchItem(e.stockSymbol, e.companyName, e.region)
      ).toList().right();
    } catch (e) {
      return e.toString().left();
    }
  }

  @override
  Future<Either<String, StockQuote>> getStockQuote(String symbol) async {
    try {
      final dto = await _api.getStockQuote(symbol);
      return _mapQuote(dto).right();
    } catch (e) {
      return e.toString().left();
    }
  }

  @override
  Future<Either<String, StockOverview>> getStockOverview(String symbol) async {
    try {
      final dto = await _api.getOverview(symbol);
      return _mapOverview(dto).right();
    } catch (e) {
      return e.toString().left();
    }
  }

  @override
  Future<Either<String, List<StockIntradayPoint>>> getIntradayData(String symbol) async {
    try {
      final dto = await _api.getIntradayData(symbol, '5min');
      return _mapIntraday(dto).right();
    } catch (e) {
      return e.toString().left();
    }
  }

  StockQuote _mapQuote(AvStockQuoteDto dto) {
    return StockQuote(
      symbol: dto.symbol,
      open: dto.open,
      high: dto.high,
      low: dto.low,
      price: dto.price,
      volume: dto.volume,
      latestTradingDay: dto.latestTradingDay,
      previousClose: dto.previousClose,
      change: dto.change,
      changePercent: dto.changePercent,
    );
  }

  StockOverview _mapOverview(AvOverviewDto dto) {
    return StockOverview(
      symbol: dto.symbol,
      name: dto.name,
      description: dto.description,
      exchange: dto.exchange,
      currency: dto.currency,
      country: dto.country,
      sector: dto.sector,
      industry: dto.industry,
      marketCapitalization: dto.marketCapitalization,
      peRatio: dto.peRatio,
      dividendYield: dto.dividendYield,
      eps: dto.eps,
      fiftyTwoWeekHigh: dto.fiftyTwoWeekHigh,
      fiftyTwoWeekLow: dto.fiftyTwoWeekLow,
    );
  }

  List<StockIntradayPoint> _mapIntraday(AvIntradayResponseDto dto) {
    return dto.timeSeries
        .map((e) => StockIntradayPoint(
              dateTime: DateTime.parse(e.timestamp),
              open: e.open,
              high: e.high,
              low: e.low,
              close: e.close,
              volume: e.volume,
            ))
        .toList();
  }
}
