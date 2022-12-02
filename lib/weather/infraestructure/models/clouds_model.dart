import 'package:weather_app/weather/domain/entities/clouds.dart';

class CloudsModel extends Clouds {
  CloudsModel({
    required super.all,
  });

  factory CloudsModel.fromJson(Map<String, dynamic> json) => CloudsModel(
        all: json['all'] as int,
      );

  Map<String, dynamic> toJson() => {
        'all': all,
      };
}
