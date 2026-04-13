import '../../../../core/error/failures.dart';
import '../../../../core/utils/api_result.dart';
import '../../domain/entities/portfolio_entities.dart';
import '../../domain/repositories/portfolio_repository.dart';
import '../datasources/portfolio_local_datasource.dart';

/// Concrete implementation of [PortfolioRepository].
/// Catches all exceptions here — errors never escape as raw exceptions.
class PortfolioRepositoryImpl implements PortfolioRepository {
  final PortfolioLocalDataSource _dataSource;

  const PortfolioRepositoryImpl(this._dataSource);

  @override
  ApiResult<PortfolioData> getPortfolioData() {
    try {
      final data = _dataSource.getPortfolioData();
      return Success(data);
    } catch (e) {
      return Err(LocalDataFailure('Failed to load portfolio data: $e'));
    }
  }
}
