import 'package:flutter_test/flutter_test.dart';
import 'package:nourhan_portfolio/core/utils/api_result.dart';
import 'package:nourhan_portfolio/features/portfolio/data/datasources/portfolio_local_datasource.dart';
import 'package:nourhan_portfolio/features/portfolio/data/models/portfolio_repository_impl.dart';
import 'package:nourhan_portfolio/features/portfolio/domain/entities/portfolio_entities.dart';

void main() {
  late PortfolioRepositoryImpl repository;
  late PortfolioLocalDataSource dataSource;

  setUp(() {
    dataSource = PortfolioLocalDataSource();
    repository = PortfolioRepositoryImpl(dataSource);
  });

  group('PortfolioRepositoryImpl', () {
    test('getPortfolioData returns Success with correct name', () {
      final result = repository.getPortfolioData();

      expect(result, isA<Success<PortfolioData>>());
      expect((result as Success).data.name, 'Nourhan Ayman');
    });

    test('portfolio data has non-empty skills', () {
      final result = repository.getPortfolioData();
      final data = (result as Success<PortfolioData>).data;

      expect(data.skills, isNotEmpty);
    });

    test('portfolio data has non-empty projects', () {
      final result = repository.getPortfolioData();
      final data = (result as Success<PortfolioData>).data;

      expect(data.projects, isNotEmpty);
    });

    test('portfolio data has non-empty experiences', () {
      final result = repository.getPortfolioData();
      final data = (result as Success<PortfolioData>).data;

      expect(data.experiences, isNotEmpty);
    });

    test('first experience is marked isPrimary', () {
      final result = repository.getPortfolioData();
      final data = (result as Success<PortfolioData>).data;

      expect(data.experiences.first.isPrimary, isTrue);
    });
  });
}
