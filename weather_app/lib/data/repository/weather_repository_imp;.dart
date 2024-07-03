import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:weather_app/core/error/exception.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/data/data_source/remote_data_source.dart';
import 'package:weather_app/domain/entities/weather.dart';
import 'package:weather_app/domain/repositary/weather_repository.dart';

class WeatherRepositoryImpl extends WeatherRepository {
  final WeatherRemoteDataSource remoteDataSource;

  WeatherRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, WeatherEntity>> getCurrentWeather(
      String cityName) async {
    try {
      final result = await remoteDataSource.getCurrentWeather(cityName);
      return Right(result.toEntity());
    } on ServerException {
      return const Left(
          ServerFailure('An error occurred while getting weather data'));
    } on SocketException {
      return const Left(ConnectionFailure('No internet connection'));
    }
  }
}
