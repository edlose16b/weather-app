import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/presentation/home/logic/cities_cubit.dart';
import 'package:weather_app/presentation/home/logic/header_mode_cubit.dart';
import 'package:weather_app/presentation/home/logic/search_cubit.dart';
import 'package:weather_app/presentation/home/view/home.dart';
import 'package:weather_app/presentation/home/wigets/home_header_widget.dart';

import '../../../helpers/helpers.dart';

class MockHeaderModeCubit extends MockCubit<HeaderMode>
    implements HeaderModeCubit {}

class MockCitiesCubit extends MockCubit<CitiesCubitState>
    implements CitiesCubit {}

class MockSearchCubit extends MockCubit<SearchCubitState>
    implements SearchCubit {}

void main() {
  late HeaderModeCubit headerModeCubit;
  late CitiesCubit citiesCubit;
  late SearchCubit searchCubit;

  setUp(() {
    headerModeCubit = MockHeaderModeCubit();
    citiesCubit = MockCitiesCubit();
    searchCubit = MockSearchCubit();
  });

  group('HomeContent', () {
    Widget setUpPump(Widget widget) {
      return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => headerModeCubit,
          ),
          BlocProvider(
            create: (context) => citiesCubit,
          ),
          BlocProvider(
            create: (context) => searchCubit,
          ),
        ],
        child: Scaffold(
          body: widget,
        ),
      );
    }

    testWidgets('should render empty screen', (tester) async {
      // arrange

      when(() => headerModeCubit.state).thenReturn(HeaderMode.dropdown);
      when(() => citiesCubit.state)
          .thenReturn(const CitiesCubitState(cities: []));

      when(() => searchCubit.state).thenReturn(const SearchCubitState());

      // act

      await tester.pumpApp(setUpPump(const HomeContent()));

      // assert
      expect(find.byKey(const Key('search_city')), findsOneWidget);
    });

    testWidgets('should render error screen', (tester) async {
      // arrange

      when(() => headerModeCubit.state).thenReturn(HeaderMode.dropdown);
      when(() => citiesCubit.state)
          .thenReturn(const CitiesCubitState(cities: []));

      when(() => searchCubit.state).thenReturn(
        const SearchCubitState(error: 'error', status: SearchCubitStatus.error),
      );

      // act

      await tester.pumpApp(setUpPump(const HomeContent()));

      // assert
      expect(find.byKey(const Key('error_message')), findsOneWidget);
    });

    testWidgets('should render weather detail', (tester) async {
      // arrange

      when(() => headerModeCubit.state).thenReturn(HeaderMode.dropdown);
      when(() => citiesCubit.state)
          .thenReturn(const CitiesCubitState(cities: []));

      when(() => searchCubit.state).thenReturn(
        const SearchCubitState(
          status: SearchCubitStatus.success,
        ),
      );

      // act

      await tester.pumpApp(setUpPump(const HomeContent()));

      // assert
      expect(find.byKey(const Key('weather_detail')), findsOneWidget);
    });
  });
}
