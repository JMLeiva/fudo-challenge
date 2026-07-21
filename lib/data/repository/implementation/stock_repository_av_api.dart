import 'package:fudo_challenge/domain/model/stock.dart';
import 'package:fudo_challenge/domain/model/stock_intraday_point.dart';
import 'package:fudo_challenge/domain/model/stock_overview.dart';
import 'package:fudo_challenge/domain/model/stock_quote.dart';
import 'package:fudo_challenge/domain/model/stock_search_item.dart';
import 'package:fudo_challenge/data/network/alphavantage/alpha_vantage_api.dart';
import 'package:fudo_challenge/data/repository/stock_repository.dart';
import 'package:injectable/injectable.dart';

import '../../model/result.dart';
import '../../network/alphavantage/dto/intraday/av_intraday_response_dto.dart';
import '../../network/alphavantage/dto/overview/av_overview_dto.dart';
import '../../network/alphavantage/dto/quote/av_stock_quote_dto.dart';
import '../../network/alphavantage/dto/search/av_search_response_dto.dart';

@Injectable(as: StockRepository)
class StockRepositoryAvApi implements StockRepository {
  final AlphaVantageApi _api;

  StockRepositoryAvApi(this._api);

  @override
  Future<Result<List<StockSearchItem>, String>> search(String query) async {
    if (query.isEmpty) {
      return Result.success([]);
    }

    try {
      AvSearchResponseDto response = await _api.search(query);

      return Result.success(response.bestMatches
          .map((e) => StockSearchItem(e.stockSymbol, e.companyName, e.region))
          .toList());
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  @override
  Future<Result<Stock, String>> getStockDetails(String symbol) async {
    try {
      final results = await Future.wait([
        _api.getStockQuote(symbol),
        _api.getOverview(symbol),
        _api.getIntradayData(symbol, '5min'),
      ]);

      return Result.success(Stock(
        quote: _mapQuote(results[0] as AvStockQuoteDto),
        overview: _mapOverview(results[1] as AvOverviewDto),
        intraday: _mapIntraday(results[2] as AvIntradayResponseDto),
      ));
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  @override
  Future<Result<StockQuote, String>> getStockQuote(String symbol) async {
    try {
      final dto = await _api.getStockQuote(symbol);
      return Result.success(_mapQuote(dto));
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  @override
  Future<Result<StockOverview, String>> getStockOverview(String symbol) async {
    try {
      final dto = await _api.getOverview(symbol);
      return Result.success(_mapOverview(dto));
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  @override
  Future<Result<List<StockIntradayPoint>, String>> getIntradayData(String symbol) async {
    try {
      final dto = await _api.getIntradayData(symbol, '5min');
      return Result.success(_mapIntraday(dto));
    } catch (e) {
      return Result.failure(e.toString());
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
