import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/weather_cubit/weather_state.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/sevices/weather_service.dart';

class WeatherCubit extends Cubit<WeatherState>{
  WeatherCubit(this.weatherservice):super(WeatherInitial());

  WeatherModel? weathermodel;
  WeatherService? weatherservice;
  String? cityName;

  void getWeather({required String cityName})async{
    emit(WeatherLoading());
    try{
       weathermodel = await weatherservice!.getWeather(cityName: cityName);
      emit(WeatherSuccess());
    }on Exception catch(e){
      emit(WeatherFailure());
    }
  }
}