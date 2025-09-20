import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData get light => ThemeData(
    useMaterial3: true,
    colorSchemeSeed: AppColors.seed,
    scaffoldBackgroundColor: AppColors.scaffold,
    appBarTheme: const AppBarTheme(centerTitle: true),
  );
}
