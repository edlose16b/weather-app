import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/weather/domain/entities/clouds.dart';
import 'package:weather_app/weather/infraestructure/models/clouds_model.dart';

void main() {
  test('should be a subclass of Clouds entity', () {
    final model = CloudsModel(
      all: 1,
    );

    expect(model, isA<Clouds>());
  });

  group('from json', () {
    Map<String, dynamic>? jsonMap;

    setUp(() {
      jsonMap = <String, dynamic>{
        'all': 1,
      };
    });

    test('should return a valid model', () {
      // arrange

      // act
      final result = CloudsModel.fromJson(jsonMap!);

      // assert
      expect(result, isA<CloudsModel>());
    });

    test('should return a model with correct fields', () {
      final model = CloudsModel.fromJson(jsonMap!);

      expect(model.all, 1);
    });

    test('should return a valid model when the JSON contains an extra field',
        () {
      // arrange
      jsonMap!['extra'] = 'extra';

      // act
      final result = CloudsModel.fromJson(jsonMap!);
      // assert
      expect(result, isA<CloudsModel>());
    });

    test(
        'should throw a [TypeError] when the JSON contains a null value '
        ' in int field', () {
      // arrange
      jsonMap!['all'] = null;

      expect(
        // act
        () => CloudsModel.fromJson(jsonMap!),
        // assert
        throwsA(isA<TypeError>()),
      );
    });
  });
}
