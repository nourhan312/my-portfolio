import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/di/injection.dart';
import 'core/theme/app_theme.dart';
import 'features/portfolio/presentation/cubit/portfolio_cubit.dart';
import 'features/portfolio/presentation/cubit/portfolio_state.dart';
import 'features/portfolio/presentation/pages/portfolio_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PortfolioCubit>(
      create: (_) => sl<PortfolioCubit>(),
      child: BlocSelector<PortfolioCubit, PortfolioState, bool>(
        selector: (state) => state is PortfolioLoaded && state.isDark,
        builder: (context, isDark) {
          return MaterialApp(
            title: 'Nourhan Ayman | Flutter Developer Portfolio',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light(),
            darkTheme: AppTheme.dark(),
            themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
            home: const PortfolioPage(),
          );
        },
      ),
    );
  }
}
