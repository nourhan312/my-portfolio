import 'package:get_it/get_it.dart';

import '../../features/portfolio/data/datasources/portfolio_local_datasource.dart';
import '../../features/portfolio/data/models/portfolio_repository_impl.dart';
import '../../features/portfolio/domain/repositories/portfolio_repository.dart';
import '../../features/portfolio/domain/usecases/get_portfolio_data_usecase.dart';
import '../../features/portfolio/presentation/cubit/portfolio_cubit.dart';

final sl = GetIt.instance;

/// Register all dependencies here — single source of truth.
/// Order: data sources → repositories → use cases → cubits.
void setupDependencies() {
  // Data
  sl.registerLazySingleton<PortfolioLocalDataSource>(
    PortfolioLocalDataSource.new,
  );

  // Repository (interface bound to impl)
  sl.registerLazySingleton<PortfolioRepository>(
    () => PortfolioRepositoryImpl(sl()),
  );

  // Use cases
  sl.registerLazySingleton<GetPortfolioDataUseCase>(
    () => GetPortfolioDataUseCase(sl()),
  );

  // Cubits — registered as factory so each call gets a fresh instance
  sl.registerFactory<PortfolioCubit>(
    () => PortfolioCubit(sl()),
  );
}
