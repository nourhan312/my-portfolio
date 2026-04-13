import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

extension ContextX on BuildContext {
  AppColors get colors => Theme.of(this).extension<AppColors>()!;
  TextTheme get text => Theme.of(this).textTheme;
  bool get isMobile => MediaQuery.sizeOf(this).width < 768;
  bool get isTablet =>
      MediaQuery.sizeOf(this).width >= 768 &&
      MediaQuery.sizeOf(this).width < 1100;
  bool get isDesktop => MediaQuery.sizeOf(this).width >= 1100;
  double get screenWidth => MediaQuery.sizeOf(this).width;
}
