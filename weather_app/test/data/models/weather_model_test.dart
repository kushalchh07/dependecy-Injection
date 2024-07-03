import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/data/models/weather_model.dart';
import 'package:weather_app/domain/entities/weather.dart';

import '../../helper/json_reader.dart';

void main() {
  setUp(() {});

  const tWeatherModel = WeatherModel(
    cityName: 'New York',
    main: 'Clear',
    description: 'clear sky',
    iconCode: '01d',
    temperature: 271.71,
    pressure: 1033,
    humidity: 56,
  );

  test('should be a subclass of WeatherEntity entity', () async {
// arrange
// act
// assert
    expect(tWeatherModel, isA<WeatherEntity>());
  });

  test('should return valid model from json', () async {
// arrange
    final Map<String, dynamic> jsonMap = json.decode(
      readJson('helper\\dummy_data\\dummy_weather_response.json'),
    );
// act
    final result = WeatherModel.fromJson(jsonMap);
// assert
    expect(result, tWeatherModel);
  });

  test('should return a json map containing the data', () async {
    // arrange

    // act
    final result = tWeatherModel.toJson();
    // assert

    final expectedJsonMap = {
      "name": "New York",
      "weather": [
        {"main": "Clear", "description": "clear sky", "icon": "01d"}
      ],
      "main": {
        "temp": 271.71,
        "pressure": 1033,
        "humidity": 56,
      }
    };
    expect(result, expectedJsonMap);
  });
}
