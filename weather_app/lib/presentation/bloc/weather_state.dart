part of 'weather_bloc.dart';

sealed class WeatherState extends Equatable {
  const WeatherState();
  
  @override
  List<Object> get props => [];
}

final class WeatherInitial extends WeatherState {}

final class WeatherLoadingState extends WeatherState {}

final class WeatherLoadedState extends WeatherState {
  final WeatherEntity weather;

  const WeatherLoadedState(this.weather);

  @override
  List<Object> get props => [weather];
}

final class WeatherLoadFailureState extends WeatherState {
  final String message;

  const WeatherLoadFailureState(this.message);

  @override
  List<Object> get props => [message];
}

