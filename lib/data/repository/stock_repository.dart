import 'package:fudo_challenge/data/model/stock_search_item.dart';

import '../model/result.dart';

abstract interface class StockRepository {
  Future<Result<List<StockSearchItem>, String>> search(String query);
}