// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter/material.dart';
import 'package:weather_app/app/dependency_injections.dart';
import 'package:weather_app/app/ui/colors.dart';
import 'package:weather_app/l10n/l10n.dart';
import 'package:weather_app/presentation/home/view/home.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return DependejencyInjections(
      child: MaterialApp(
        theme: ThemeData(
          appBarTheme: const AppBarTheme(color: AppColors.primaryColor),
          iconTheme: const IconThemeData(color: AppColors.primaryColor),
          colorScheme:
              ColorScheme.fromSwatch(accentColor: AppColors.primaryColor),
        ),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const HomeView(),
      ),
    );
  }
}
