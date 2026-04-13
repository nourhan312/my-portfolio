import '../../../../core/utils/api_result.dart';
import '../entities/portfolio_entities.dart';
import '../repositories/portfolio_repository.dart';

/// Use case: load portfolio data.
/// Cubits call this — never repositories directly.
class GetPortfolioDataUseCase {
  final PortfolioRepository _repository;

  const GetPortfolioDataUseCase(this._repository);

  ApiResult<PortfolioData> call() => _repository.getPortfolioData();
}
