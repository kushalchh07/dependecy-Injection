import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/error/exception.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/data/models/weather_model.dart';
import 'package:weather_app/data/repository/weather_repository_imp;.dart';
import 'package:weather_app/domain/entities/weather.dart';

import '../../helper/test_helper.mocks.dart';

void main() {
  late MockWeatherRemoteDataSource mockWeatherRemoteDataSource;
  late WeatherRepositoryImpl weatherRepositoryImpl;

  setUp(() {
    mockWeatherRemoteDataSource = MockWeatherRemoteDataSource();
    weatherRepositoryImpl = WeatherRepositoryImpl(mockWeatherRemoteDataSource);
  });

  const tWeatherModel = WeatherModel(
    cityName: 'New York',
    main: 'Clouds',
    description: 'few clouds',
    iconCode: '02d',
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );

  const tWeatherEntity = WeatherEntity(
    cityName: 'New York',
    main: 'Clouds',
    description: 'few clouds',
    iconCode: '02d',
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );

  const tCityName = 'New York';
  group('get current weather', () {
    test(
        'should return weather when the call to remote data source is successful',
        () async {
// arrange
      when(mockWeatherRemoteDataSource.getCurrentWeather(tCityName))
          .thenAnswer((_) async => tWeatherModel);

// act
      final result = await weatherRepositoryImpl.getCurrentWeather(tCityName);
// assert

      expect(result, equals(const Right(tWeatherEntity)));
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
// arrange
      when(mockWeatherRemoteDataSource.getCurrentWeather(tCityName))
          .thenThrow(ServerException());

// act
      final result = await weatherRepositoryImpl.getCurrentWeather(tCityName);

// assert
      expect(
          result,
          equals(const Left(
              ServerFailure('An error occurred while getting weather data'))));
    });

    test(
        'should return connection failure when device has no internet',
        () async {
// arrange
      when(mockWeatherRemoteDataSource.getCurrentWeather(tCityName))
          .thenThrow(SocketException());

// act
      final result = await weatherRepositoryImpl.getCurrentWeather(tCityName);
// assert

      expect(
          result,
          equals(const Left(
              ConnectionFailure('No internet connection'))));
    });
  });
}
