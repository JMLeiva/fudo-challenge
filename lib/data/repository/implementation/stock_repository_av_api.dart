import 'package:fudo_challenge/data/model/stock_search_item.dart';
import 'package:fudo_challenge/data/network/alphavantage/alpha_vantage_api.dart';
import 'package:fudo_challenge/data/repository/stock_repository.dart';

import '../../model/result.dart';
import '../../network/alphavantage/dto/search/av_search_response_dto.dart';

class StockRepositoryAvApi implements StockRepository {
  AlphaVantageApi _api;

  StockRepositoryAvApi(this._api);

  @override
  Future<Result<List<StockSearchItem>, String>> search(String query) async {
    if(query.isEmpty) {
      return Result.success([]);
    }

    try {
      AvSearchResponseDto response = await _api.search(query);

      return Result.success(response.bestMatches.map((e) =>
          StockSearchItem(
              e.stockSymbol,
              e.companyName,
              e.region)).toList()
      );

    } catch (e) {
      return Result.failure(e.toString());
    }
  }

}