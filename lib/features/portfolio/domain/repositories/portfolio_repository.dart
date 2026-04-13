import '../../../../core/utils/api_result.dart';
import '../entities/portfolio_entities.dart';

/// Contract for portfolio data access.
/// The domain layer depends on this abstraction, not the concrete impl.
abstract interface class PortfolioRepository {
  ApiResult<PortfolioData> getPortfolioData();
}
