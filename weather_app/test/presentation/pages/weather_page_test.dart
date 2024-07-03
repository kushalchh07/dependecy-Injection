import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/domain/entities/weather.dart';
import 'package:weather_app/presentation/bloc/weather_bloc.dart';
import 'package:weather_app/presentation/pages/weather_page.dart';

class MockWeatherBloc extends MockBloc<WeatherEvent, WeatherState>
    implements WeatherBloc {}

void main() {
  late MockWeatherBloc mockWeatherBloc;

  setUp(() {
    mockWeatherBloc = MockWeatherBloc();
    HttpOverrides.global = null;// prevent http request in NetworkImage
  });
// we will check following things
// 1. state of app should change from WeatherInitial to WeatherLoadingState when filling text field is finished
// 2 display CircularProgressIndicator when state is WeatherLoadingState
// 3. display the widget containing weather data when state is WeatherLoadedState

  Widget makeTestableWidget(Widget widget) {
    return BlocProvider<WeatherBloc>(
      create: (context) => mockWeatherBloc,
      child: MaterialApp(
        home: widget,
      ),
    );
  }



 const tWeatherEntity = WeatherEntity(
    cityName: 'New York',
    main: 'Clouds',
    description: 'few clouds',
    iconCode: '02d',
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );


// 1. state of app should change from WeatherInitial to WeatherLoadingState when filling text field is finished
  testWidgets(
      'text field should trigger state to change from initial to loading',
      (widgetTester) async {
// arrange
    whenListen(
      mockWeatherBloc,
      Stream.fromIterable(
        [
          WeatherInitial(),
          // WeatherLoadingState(),
        ],
      ),
      initialState: WeatherInitial(),
    );

// act
//in act we build and render the widget
    await widgetTester.pumpWidget(makeTestableWidget(const WeatherPage()));

    var textField = find.byType(TextField);
    expect(textField, findsOneWidget);
    await widgetTester.enterText(textField, 'kathmandu');
    await widgetTester
        .pump(); // we need to pump the widget again to reflect the changes
    expect(find.text('kathmandu'), findsOneWidget);
  });

// 2 display CircularProgressIndicator when state is WeatherLoadingState
  testWidgets(
      'should display CircularProgressIndicator when state is WeatherLoadingState',
      (widgetTester) async {
// arrange

    whenListen(
      mockWeatherBloc,
      Stream.fromIterable(
        [
          WeatherInitial(),
          WeatherLoadingState(),
        ],
      ),
      initialState: WeatherLoadingState(),
    );
// act
//in act we build and render the widget
    await widgetTester.pumpWidget(makeTestableWidget(const WeatherPage()));
// // assert
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });


// 3. display the widget containing weather data when state is WeatherLoadedState

  testWidgets(
      'should display the widget containing weather data when state is WeatherLoadedState',
      (widgetTester) async {


    whenListen(
      mockWeatherBloc,
      Stream.fromIterable(
        [
          WeatherInitial(),
          WeatherLoadingState(),
         const WeatherLoadedState(tWeatherEntity),
        ],
      ),
      initialState: const WeatherLoadedState(tWeatherEntity),
    );

//assert
    await widgetTester.pumpWidget(makeTestableWidget(const WeatherPage()));
    await widgetTester.pumpAndSettle(const Duration(milliseconds: 500));

//act

    expect(find.byKey(const Key('weather_data')), findsOneWidget);



// expect(mockWeatherBloc.state, equals(const WeatherLoadedState(tWeatherEntity)));

});
}
