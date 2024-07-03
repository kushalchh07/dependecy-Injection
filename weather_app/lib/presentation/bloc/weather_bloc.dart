import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/domain/entities/weather.dart';
import 'package:weather_app/domain/usecases/get_current_weather.dart';
import 'package:rxdart/rxdart.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {

  final GetCurrentWeatherUseCase getCurrentWeatherUseCase;

  WeatherBloc(this.getCurrentWeatherUseCase) : super(WeatherInitial()) {
    on<OnCityChangedEvent>(onCityChangedEvent,
        transformer: debounce(const Duration(milliseconds: 500)));
  }

  FutureOr<void> onCityChangedEvent(
      OnCityChangedEvent event, Emitter<WeatherState> emit) async {
    emit(WeatherLoadingState());
    final result = await getCurrentWeatherUseCase.execute(event.city);

    result.fold(
      (failure) => emit(WeatherLoadFailureState(failure.message)),
      (weather) => emit(WeatherLoadedState(weather)),
    );
  }
}

// to not trigger the event on every key stroke, we can use debounceTime() operator from RxDart library.
EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).asyncExpand(mapper);
}
