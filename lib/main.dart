import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/cubits/weather_cubit/weather_cubit.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/screens/home_page.dart';
import 'package:weather_app/sevices/weather_service.dart';

void main(){
  runApp(BlocProvider(
      create: (context) => WeatherCubit(WeatherService()),
      child: Myapp()));
}


class Myapp extends StatelessWidget {
  const Myapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home:  HomePage(),
      theme: ThemeData(
        fontFamily: 'Marck Script',
        //primarySwatch: BlocProvider.of<WeatherCubit>(context).weathermodel == null ? Colors.blue :  BlocProvider.of<WeatherCubit>(context).weathermodel!.getThemeColor(),
      ),
    );
  }
}


