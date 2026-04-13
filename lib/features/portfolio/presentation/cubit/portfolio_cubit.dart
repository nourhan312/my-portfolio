import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/api_result.dart';
import '../../domain/usecases/get_portfolio_data_usecase.dart';
import 'portfolio_state.dart';

/// Cubit for the portfolio feature.
/// Depends ONLY on [GetPortfolioDataUseCase] — never on repositories directly.
class PortfolioCubit extends Cubit<PortfolioState> {
  final GetPortfolioDataUseCase _getPortfolioData;

  PortfolioCubit(this._getPortfolioData) : super(const PortfolioInitial());

  void load() {
    emit(const PortfolioLoading());

    final result = _getPortfolioData();

    switch (result) {
      case Success(:final data):
        emit(PortfolioLoaded(data: data, isDark: false));
      case Err(:final failure):
        emit(PortfolioError(failure.message));
    }
  }

  void toggleTheme() {
    final current = state;
    if (current is PortfolioLoaded) {
      emit(current.copyWith(isDark: !current.isDark));
    }
  }
}
