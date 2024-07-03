part of 'weather_bloc.dart';

sealed class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class OnCityChangedEvent extends WeatherEvent {
  final String city;

  const OnCityChangedEvent(this.city);

  @override
  List<Object> get props => [city];
}