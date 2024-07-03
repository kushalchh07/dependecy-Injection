import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/constants/constants.dart';
import 'package:weather_app/presentation/bloc/weather_bloc.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
                decoration: const InputDecoration(
                  hintText: 'Enter a city name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  labelText: 'City',
                ),
                onChanged: (value) {
                  context.read<WeatherBloc>().add(
                        OnCityChangedEvent(value),
                      );
                }),
            const SizedBox(height: 16),
            BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
              if (state is WeatherLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is WeatherLoadedState) {
                return Column(
                  key: const Key('weather_data'),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          state.weather.cityName,
                          style: const TextStyle(
                            fontSize: 22.0,
                          ),
                        ),
                        Image(
                          image: NetworkImage(
                            Url.weatherIcon(
                              state.weather.iconCode,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      '${state.weather.main} | ${state.weather.description}',
                      style: const TextStyle(
                        fontSize: 16.0,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 24.0),
                    Table(
                      defaultColumnWidth: const FixedColumnWidth(150.0),
                      border: TableBorder.all(
                        color: Colors.grey,
                        style: BorderStyle.solid,
                        width: 1,
                      ),
                      children: [
                        TableRow(children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Temperature',
                              style: TextStyle(
                                fontSize: 16.0,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              state.weather.temperature.toString(),
                              style: const TextStyle(
                                fontSize: 16.0,
                                letterSpacing: 1.2,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ), // Will be change later
                        ]),
                        TableRow(children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Pressure',
                              style: TextStyle(
                                fontSize: 16.0,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              state.weather.pressure.toString(),
                              style: const TextStyle(
                                  fontSize: 16.0,
                                  letterSpacing: 1.2,
                                  fontWeight: FontWeight.bold),
                            ),
                          ), // Will be change later
                        ]),
                        TableRow(children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Humidity',
                              style: TextStyle(
                                fontSize: 16.0,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              state.weather.humidity.toString(),
                              style: const TextStyle(
                                fontSize: 16.0,
                                letterSpacing: 1.2,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ), // Will be change later
                        ]),
                      ],
                    ),
                  ],
                );
              } else if (state is WeatherLoadFailureState) {
                return Text(
                  state.message,
                  style: const TextStyle(
                    fontSize: 16.0,
                    letterSpacing: 1.2,
                  ),
                );
              }
              return const SizedBox();
            })
          ],
        ),
      ),
    );
  }
}
