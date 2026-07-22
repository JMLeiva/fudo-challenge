// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../data/network/alphavantage/alpha_vantage_api.dart' as _i431;
import '../data/repository/implementation/stock_repository_av_api.dart'
    as _i449;
import '../data/repository/implementation/stock_repository_memory_cache.dart'
    as _i290;
import '../data/repository/stock_repository.dart' as _i626;
import '../presentation/view_model/details_view_model.dart' as _i319;
import '../presentation/view_model/search_view_model.dart' as _i757;
import 'main_module.dart' as _i300;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final mainModule = _$MainModule();
    gh.factory<String>(
      () => mainModule.apiKey,
      instanceName: 'alphaVantageApiKey',
    );
    gh.factory<String>(
      () => mainModule.baseUrl,
      instanceName: 'alphaVantageBaseUrl',
    );
    gh.factory<_i431.AlphaVantageApi>(
      () => _i431.AlphaVantageApi(
        gh<String>(instanceName: 'alphaVantageApiKey'),
        gh<String>(instanceName: 'alphaVantageBaseUrl'),
      ),
    );
    gh.factory<_i449.StockRepositoryAvApi>(
      () => _i449.StockRepositoryAvApi(gh<_i431.AlphaVantageApi>()),
    );
    gh.factory<_i626.StockRepository>(
      () => _i290.StockRepositoryMemoryCache(gh<_i449.StockRepositoryAvApi>()),
    );
    gh.factory<_i319.DetailsViewModel>(
      () => _i319.DetailsViewModel(gh<_i626.StockRepository>()),
    );
    gh.factory<_i757.SearchViewModel>(
      () => _i757.SearchViewModel(gh<_i626.StockRepository>()),
    );
    return this;
  }
}

class _$MainModule extends _i300.MainModule {}
