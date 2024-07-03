import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/data/data_source/remote_data_source.dart';
import 'package:weather_app/data/repository/weather_repository_imp;.dart';
import 'package:weather_app/domain/repositary/weather_repository.dart';
import 'package:weather_app/domain/usecases/get_current_weather.dart';
import 'package:weather_app/presentation/bloc/weather_bloc.dart';

// It provide centralize location to register all the dependencies
final locator= GetIt.instance;

void setupLocator(){
  //bloc
  locator.registerFactory(() => WeatherBloc(locator()));

  //usecase
  //nonelazy singleton register immediately after app start
  locator.registerLazySingleton(() => GetCurrentWeatherUseCase(locator()));

  //repository
  locator.registerLazySingleton<WeatherRepository>(() => WeatherRepositoryImpl(locator()));


// data sources

locator.registerLazySingleton<WeatherRemoteDataSource>(() => WeatherRemoteDataSourceImpl(client:locator()));

// external
locator.registerLazySingleton(() => http.Client());

}