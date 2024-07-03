import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/domain/entities/weather.dart';
import 'package:weather_app/domain/usecases/get_current_weather.dart';

import '../../helper/test_helper.mocks.dart';

void main() {
late  GetCurrentWeatherUseCase getCurrentWeatherUseCase;
late  MockWeatherRepository mockWeatherRepository;
  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    getCurrentWeatherUseCase = GetCurrentWeatherUseCase(mockWeatherRepository);
  });

  const tWeather = WeatherEntity(
   cityName: 'London',
    main: 'Clouds',
    description: 'scattered clouds',
    iconCode: '03d',
    temperature: 280.32,
    pressure: 1012,
    humidity: 81,
  );

  const tCityName = 'London';

  test('should get weather detail from the repository', () async {
    // arrange
    when(mockWeatherRepository.getCurrentWeather(tCityName))
        .thenAnswer((_) async => const Right(tWeather));

    // act
    final result = await getCurrentWeatherUseCase.execute(tCityName);
    // assert
    expect(result, const Right(tWeather));
    verify(mockWeatherRepository.getCurrentWeather(tCityName));
  });
}
