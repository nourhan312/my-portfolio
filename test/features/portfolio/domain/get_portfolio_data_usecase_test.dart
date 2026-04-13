import 'package:flutter_test/flutter_test.dart';
import 'package:nourhan_portfolio/core/error/failures.dart';
import 'package:nourhan_portfolio/core/utils/api_result.dart';
import 'package:nourhan_portfolio/features/portfolio/domain/entities/portfolio_entities.dart';
import 'package:nourhan_portfolio/features/portfolio/domain/repositories/portfolio_repository.dart';
import 'package:nourhan_portfolio/features/portfolio/domain/usecases/get_portfolio_data_usecase.dart';

// Manual test double — no Mockito to avoid code gen
class _FakeSuccessRepo implements PortfolioRepository {
  @override
  ApiResult<PortfolioData> getPortfolioData() => Success(_fakeData());
}

class _FakeFailureRepo implements PortfolioRepository {
  @override
  ApiResult<PortfolioData> getPortfolioData() =>
      const Err(LocalDataFailure('test error'));
}

PortfolioData _fakeData() => const PortfolioData(
      name: 'Test',
      title: 'Dev',
      bio: 'Bio',
      location: 'Egypt',
      email: 'test@test.com',
      phone: '01000000000',
      linkedIn: 'https://linkedin.com',
      github: 'https://github.com',
      cgpa: '3.73',
      classRank: '#1',
      skills: [],
      experiences: [],
      projects: [],
      achievements: [],
    );

void main() {
  group('GetPortfolioDataUseCase', () {
    test('returns Success when repository succeeds', () {
      final useCase = GetPortfolioDataUseCase(_FakeSuccessRepo());
      final result = useCase();

      expect(result, isA<Success<PortfolioData>>());
      expect((result as Success).data.name, 'Test');
    });

    test('returns Err when repository fails', () {
      final useCase = GetPortfolioDataUseCase(_FakeFailureRepo());
      final result = useCase();

      expect(result, isA<Err<PortfolioData>>());
      expect((result as Err).failure.message, 'test error');
    });
  });
}
