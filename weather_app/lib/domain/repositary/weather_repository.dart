import 'package:dartz/dartz.dart';
import 'package:weather_app/core/error/failure.dart';
import 'package:weather_app/domain/entities/weather.dart';

abstract class WeatherRepository {
  Future<Either<Failure,WeatherEntity>> getCurrentWeather(String cityName);
}

//domain layer must be completely independent of the other layers
// In domain layer, we create an abstract repository class
// to define the contract for what repository must do.
// in data layer, we create a concrete implementation of this repository