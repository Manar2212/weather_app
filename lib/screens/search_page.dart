import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/cubits/weather_cubit/weather_cubit.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/sevices/weather_service.dart';

class SearchPage extends StatelessWidget {
  SearchPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    String? city;

    return Scaffold(
      appBar: AppBar(
        title: Text('Search a City'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: TextField(
            onChanged: (var value){
              city = value;
            },
            onSubmitted: (var value) async{
              city = value;
             BlocProvider.of<WeatherCubit>(context).getWeather(cityName: city!);
             BlocProvider.of<WeatherCubit>(context).cityName = city;
              Navigator.pop(context);
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 35,horizontal: 20),
              border: OutlineInputBorder(),
              suffixIcon: GestureDetector(
                  onTap: ()async{
                    BlocProvider.of<WeatherCubit>(context).getWeather(cityName: city!);
                    BlocProvider.of<WeatherCubit>(context).cityName = city;
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.search)),
              hintText: 'Enter City Name',
              labelText: 'search',
            ),
          ),
        ),
      ),
    );
  }
}


