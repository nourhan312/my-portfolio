import '../../domain/entities/portfolio_entities.dart';

/// Sealed state union — exhaustive pattern matching in the UI.
/// No Freezed, no build_runner — pure Dart 3+.
sealed class PortfolioState {
  const PortfolioState();
}

final class PortfolioInitial extends PortfolioState {
  const PortfolioInitial();
}

final class PortfolioLoading extends PortfolioState {
  const PortfolioLoading();
}

final class PortfolioLoaded extends PortfolioState {
  final PortfolioData data;
  final bool isDark;

  const PortfolioLoaded({required this.data, required this.isDark});

  PortfolioLoaded copyWith({PortfolioData? data, bool? isDark}) =>
      PortfolioLoaded(
        data: data ?? this.data,
        isDark: isDark ?? this.isDark,
      );
}

final class PortfolioError extends PortfolioState {
  final String message;
  const PortfolioError(this.message);
}
