import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/domain/entities/weather.dart';
import 'package:weather_app/presentation/bloc/weather_bloc.dart';

import '../../helper/test_helper.mocks.dart';

void main() {
  late MockGetCurrentWeatherUseCase mockGetCurrentWeatherUseCase;
  late WeatherBloc weatherBloc;

  setUp(() => {
        mockGetCurrentWeatherUseCase = MockGetCurrentWeatherUseCase(),
        weatherBloc = WeatherBloc(mockGetCurrentWeatherUseCase)
      });

  const tCityName = 'New York';

  const tWeatherEntity = WeatherEntity(
    cityName: 'New York',
    main: 'Clouds',
    description: 'few clouds',
    iconCode: '02d',
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );

  test('initial state shouls be WeatherInitial', () async {
    // arrange
    // act
    // assert
    expect(weatherBloc.state, WeatherInitial());
  });

  // for bloc testing  use bloc_test package
  blocTest(
    'should emit [WeatherLoading ,WeatherLoaded] when data is fetched',
    build: () {
      when(mockGetCurrentWeatherUseCase.execute(tCityName))
          .thenAnswer((_) async => const Right(tWeatherEntity));
      return weatherBloc;
    },
    act: (bloc) => bloc.add(const OnCityChangedEvent(tCityName)),
    // to make the test wait for the bloc to emit the state
    wait: const Duration(milliseconds: 500),
    expect: () => [
      WeatherLoadingState(),
      const WeatherLoadedState(tWeatherEntity),
    ],
  );

  blocTest(
    'should emit [WeatherLoading ,WeatherLoadFailure] when data fetching fails',
    build: () {
      when(mockGetCurrentWeatherUseCase
              .execute(tCityName)) //यो method execute  हुदा
          .thenAnswer((_) async =>
              const Left(ServerFailure('Server Failure'))); // यो return गर्ने
      return weatherBloc;
    },
    act: (bloc) => bloc.add(const OnCityChangedEvent(tCityName)),
    // to make the test wait for the bloc to emit the state
    wait: const Duration(milliseconds: 500),
    expect: () => [
      WeatherLoadingState(),
      const WeatherLoadFailureState('Server Failure')
    ],
  );
}
