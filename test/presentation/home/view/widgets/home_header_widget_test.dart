import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/presentation/home/logic/cities_cubit.dart';
import 'package:weather_app/presentation/home/logic/header_mode_cubit.dart';
import 'package:weather_app/presentation/home/logic/search_cubit.dart';
import 'package:weather_app/presentation/home/wigets/home_header_widget.dart';

import '../../../../helpers/helpers.dart';

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

  group('HomeHeaderContent', () {
    testWidgets('should render dropdown', (tester) async {
      // arrange

      when(() => headerModeCubit.state).thenReturn(HeaderMode.dropdown);
      when(() => citiesCubit.state)
          .thenReturn(const CitiesCubitState(cities: ['Lima', 'Arequipa']));

      // act

      await tester
          .pumpApp(setUpPump(HomeHeaderContent(state: headerModeCubit.state)));

      // assert
      expect(find.byKey(const Key('dropdown_cities')), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);
    });

    testWidgets('should render input', (tester) async {
      // arrange

      when(() => headerModeCubit.state).thenReturn(HeaderMode.input);
      when(() => citiesCubit.state)
          .thenReturn(const CitiesCubitState(cities: ['Lima', 'Arequipa']));

      // act

      await tester
          .pumpApp(setUpPump(HomeHeaderContent(state: headerModeCubit.state)));

      // assert
      expect(find.byKey(const Key('search_text_field')), findsOneWidget);
      expect(find.byIcon(Icons.cancel), findsOneWidget);
    });

    testWidgets('should search when press submit button', (tester) async {
      // arrange

      when(() => headerModeCubit.state).thenReturn(HeaderMode.input);
      when(() => searchCubit.search(any())).thenAnswer((_) => Future.value());

      when(() => citiesCubit.state)
          .thenReturn(const CitiesCubitState(cities: []));

      // act

      await tester
          .pumpApp(setUpPump(HomeHeaderContent(state: headerModeCubit.state)));

      final input = find.byKey(const Key('search_text_field'));
      await tester.enterText(input, 'Santiago');
      await tester.testTextInput.receiveAction(TextInputAction.search);
      await tester.pump();

      // assert
      expect(input, findsOneWidget);
      expect(find.byIcon(Icons.cancel), findsOneWidget);

      verify(() => searchCubit.search('Santiago')).called(1);
    });

    testWidgets('should change to search mode when press icon', (tester) async {
      // arrange

      when(() => headerModeCubit.state).thenReturn(HeaderMode.dropdown);
      when(() => citiesCubit.state)
          .thenReturn(const CitiesCubitState(cities: ['Lima', 'Arequipa']));

      // act

      await tester
          .pumpApp(setUpPump(HomeHeaderContent(state: headerModeCubit.state)));

      final icon = find.byIcon(Icons.search);
      await tester.tap(icon);
      await tester.pump();

      // assert
      expect(icon, findsOneWidget);
      verify(() => headerModeCubit.changeMode(HeaderMode.input)).called(1);
    });

    testWidgets('should change to dropdown mode when press icon',
        (tester) async {
      // arrange

      when(() => headerModeCubit.state).thenReturn(HeaderMode.input);
      when(() => citiesCubit.state)
          .thenReturn(const CitiesCubitState(cities: ['Lima', 'Arequipa']));

      // act

      await tester
          .pumpApp(setUpPump(HomeHeaderContent(state: headerModeCubit.state)));

      final icon = find.byIcon(Icons.cancel);
      await tester.tap(icon);
      await tester.pump();

      // assert
      expect(icon, findsOneWidget);
      verify(() => headerModeCubit.changeMode(HeaderMode.dropdown)).called(1);
    });
  });
}
