import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart ' as http;
import 'package:mockito/mockito.dart';
import 'package:weather_app/core/constants/constants.dart';
import 'package:weather_app/core/error/exception.dart';
import 'package:weather_app/data/data_source/remote_data_source.dart';
import 'package:weather_app/data/models/weather_model.dart';

import '../../helper/json_reader.dart';
import '../../helper/test_helper.mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late WeatherRemoteDataSourceImpl weatherRemoteDataSourceImpl;

  setUp(() {
    mockHttpClient = MockHttpClient();
    weatherRemoteDataSourceImpl =
        WeatherRemoteDataSourceImpl(client: mockHttpClient);
  });

  const tCityName = 'New York';
// group several tests together
  group('get current weather', () {
    test('should return weather model when the response code is 200 (success)',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse(Url.currentWeatherByCityName(tCityName))))
          .thenAnswer((_) async => http.Response(
                //with thenAnswer we should return response object
                // with status code 200
                readJson('helper\\dummy_data\\dummy_weather_response.json'),
                200,
              ));
      // act
      final result =
          await weatherRemoteDataSourceImpl.getCurrentWeather(tCityName);
      // assert

      expect(result, isA<WeatherModel>());
    });

    test('should throw server exception when the response code is 404 (error)',
        () async {
      // arrange
      when(mockHttpClient
              .get(Uri.parse(Url.currentWeatherByCityName(tCityName))))
          .thenAnswer((_) async => http.Response(
                'Not Found',
                404,
              ));
      // act
      final result = weatherRemoteDataSourceImpl.getCurrentWeather(tCityName);
      // assert

      expect(result, throwsA(isA<ServerException>()));
    });
  });
}
//STUB - a fake implementation of a class that returns a canned response  
//thenAnswer function is used for method that return Future or stream
//thenReturn function is used for normal synchronous method 