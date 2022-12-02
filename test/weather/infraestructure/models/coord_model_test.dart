import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/weather/domain/entities/coord.dart';
import 'package:weather_app/weather/infraestructure/models/coord_model.dart';

void main() {
  test('should be a subclass of Coord entity', () {
    final model = CoordModel(
      lon: 1.2,
      lat: -1.3,
    );

    expect(model, isA<Coord>());
  });

  group('from json', () {
    Map<String, dynamic>? jsonMap;

    setUp(() {
      jsonMap = <String, dynamic>{
        'lon': 1.2,
        'lat': -1.3,
      };
    });

    test('should return a valid model', () {
      // arrange

      // act
      final result = CoordModel.fromJson(jsonMap!);

      // assert
      expect(result, isA<CoordModel>());
    });

    test('should return a model with correct fields', () {
      final model = CoordModel.fromJson(jsonMap!);

      expect(model.lon, 1.2);
      expect(model.lat, -1.3);
    });

    test('should return a valid model when the JSON contains an extra field',
        () {
      // arrange
      jsonMap!['extra'] = 'extra';

      // act
      final result = CoordModel.fromJson(jsonMap!);
      // assert
      expect(result, isA<CoordModel>());
    });

    test(
        'should throw a [FormatException] when the JSON contains a null value '
        ' in double field', () {
      // arrange
      jsonMap!['lon'] = null;

      expect(
        // act

        () => CoordModel.fromJson(jsonMap!),

        // assert
        throwsA(isA<FormatException>()),
      );
    });
  });
}
