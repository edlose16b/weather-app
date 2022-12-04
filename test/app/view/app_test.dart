// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/app/app.dart';
import 'package:weather_app/counter/counter.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late SharedPreferences sharedPreferences;

  setUpAll(() async {
    sharedPreferences = MockSharedPreferences();
  });

  group('App', () {
    testWidgets('renders CounterPage', (tester) async {
      await tester.pumpWidget(
        App(
          sharedPreferences: sharedPreferences,
        ),
      );
      expect(find.byType(CounterPage), findsOneWidget);
    });
  });
}
