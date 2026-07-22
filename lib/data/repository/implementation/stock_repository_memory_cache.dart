import 'package:dart_either/dart_either.dart';
import 'package:fudo_challenge/data/repository/stock_repository.dart';
import 'package:fudo_challenge/domain/model/stock_intraday_point.dart';
import 'package:fudo_challenge/domain/model/stock_overview.dart';
import 'package:fudo_challenge/domain/model/stock_quote.dart';
import 'package:fudo_challenge/domain/model/stock_search_item.dart';
import 'package:fudo_challenge/di/injections_keys.dart';
import 'package:injectable/injectable.dart';
import 'package:memory_cache/memory_cache.dart';

@Injectable(as: StockRepository)
class StockRepositoryMemoryCache extends StockRepository {
  final StockRepository _fallback;

  StockRepositoryMemoryCache(@Named(InjectionKeys.remoteRepository) this._fallback);

  @override
  Future<Either<String, List<StockIntradayPoint>>> getIntradayData(String symbol) async {
    final String key = 'intraday_$symbol';
    final cached = MemoryCache.instance.read<List<StockIntradayPoint>>(key);
    if (cached != null) {
      return cached.right();
    }

    return (await _fallback.getIntradayData(symbol)).tap( (value) =>
        MemoryCache.instance.create(key, value, expiry: const Duration(minutes: 2)),
    );
  }

  @override
  Future<Either<String, StockOverview>> getStockOverview(String symbol) async {
    final String key = 'overview_$symbol';
    final cached = MemoryCache.instance.read<StockOverview>(key);
    if (cached != null) {
      return cached.right();
    }

    return (await _fallback.getStockOverview(symbol)).tap( (value) =>
        MemoryCache.instance.create(key, value),
    );
  }

  @override
  Future<Either<String, StockQuote>> getStockQuote(String symbol) async {
    final String key = 'quote_$symbol';
    final cached = MemoryCache.instance.read<StockQuote>(key);
    if (cached != null) {
      return cached.right();
    }

    return (await _fallback.getStockQuote(symbol)).tap( (value) =>
        MemoryCache.instance.create(key, value, expiry: const Duration(minutes: 2))
    );
  }

  @override
  Future<Either<String, List<StockSearchItem>>> search(String query) async {
    final String key = 'search_$query';
    final cached = MemoryCache.instance.read<List<StockSearchItem>>(key);
    if (cached != null) {
      return cached.right();
    }

    return (await _fallback.search(query)).tap( (value) =>
        MemoryCache.instance.create(key, value)
    );
  }
}
