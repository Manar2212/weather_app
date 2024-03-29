
import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:weather_app/models/weather_model.dart';
class WeatherService{
  String baseUrl = 'http://api.weatherapi.com/v1';
  String apiKey = 'a1f27edd543d4c0dbe3184605230807';
  Future<WeatherModel> getWeather({required String cityName}) async{
    Uri url = Uri.parse('$baseUrl/forecast.json?key=$apiKey&q=$cityName&days=7');
    http.Response response = await http.get(url);
     Map<String,dynamic> data= jsonDecode(response.body);
     var jsonData = data['forecast']['forecastday'][0]['day'];
     
     WeatherModel weather = WeatherModel.fromJson(data);
     return weather;
  }
}