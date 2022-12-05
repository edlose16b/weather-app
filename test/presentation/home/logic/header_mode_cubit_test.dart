import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/presentation/home/logic/header_mode_cubit.dart';

void main() {
  blocTest<HeaderModeCubit, HeaderMode>(
    'initial state HeaderMode.dropdown',
    build: HeaderModeCubit.new,
    verify: (bloc) {
      expect(
        bloc.state,
        equals(HeaderMode.dropdown),
      );
    },
  );

  test('initial state HeaderMode.dropdown', () {
    expect(HeaderModeCubit().state, equals(HeaderMode.dropdown));
  });

  blocTest<HeaderModeCubit, HeaderMode>(
    'hould emits [HeaderMode.input] when changeMode is called',
    build: HeaderModeCubit.new,
    act: (cubit) => cubit.changeMode(HeaderMode.input),
    expect: () => [equals(HeaderMode.input)],
  );

  blocTest<HeaderModeCubit, HeaderMode>(
    'hould emits [HeaderMode.dropdown] when changeMode is called',
    build: HeaderModeCubit.new,
    act: (cubit) => cubit.changeMode(HeaderMode.dropdown),
    expect: () => [equals(HeaderMode.dropdown)],
  );
}
