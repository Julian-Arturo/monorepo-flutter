// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../data/data_source/planet_data_source.dart' as _i848;
import '../data/repositories/planet_repository_impl.dart' as _i427;
import '../domain/repositories/planet_repository.dart' as _i997;
import '../domain/use_case/fetch_planets_use_case.dart' as _i432;
import '../utils/network/api_config.dart' as _i68;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i68.HttpService>(() => _i68.HttpService());
    gh.factory<_i848.PlanetDataSource>(
        () => _i848.MessageModalDataSourceImpl(gh<_i68.HttpService>()));
    gh.factory<_i997.PlanetRepository>(
        () => _i427.PlanetRepositoryImpl(gh<_i848.PlanetDataSource>()));
    gh.factory<_i432.PlanetUseCase>(
        () => _i432.PlanetUseCase(gh<_i997.PlanetRepository>()));
    return this;
  }
}
