
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/cubits/weather_cubit/weather_cubit.dart';
import 'package:weather_app/cubits/weather_cubit/weather_state.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/providers/weather_provider.dart';
import 'package:weather_app/screens/search_page.dart';



class HomePage extends StatelessWidget {
  WeatherModel? weatherData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text('Weather App'),
          actions: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: IconButton(
                icon: Icon(Icons.search),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>
                  SearchPage(),
                  ));
                },
              ),
            ),
          ],
    ),
        body: BlocBuilder<WeatherCubit,WeatherState>(
          builder: (context,state){
            if(state is WeatherLoading){
              return Center(child: CircularProgressIndicator());
            }else if(state is WeatherSuccess){
              weatherData = BlocProvider.of<WeatherCubit>(context).weathermodel;
              return SuccessBody(weatherData: weatherData);
            }else if(state is WeatherFailure){
              return Center(child: Text('Something Wrong is happen, please try again'),);
            }else{
              return DefaultBody();
            }
          }
        )
    );
  }
}

class DefaultBody extends StatelessWidget {
  const DefaultBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/mountain-view.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
        child: Center(
          child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
              Text(
              'there is no weather 😔 start',
              style: TextStyle(
              fontSize: 25,
              ),
              ),
              Text(
              'searching now 🔍',
              style: TextStyle(
              fontSize: 25,
              ),
              ),]
              ),
        ));
  }
}

class SuccessBody extends StatelessWidget {
  const SuccessBody({
    super.key,
    required this.weatherData,
  });

  final WeatherModel? weatherData;

  @override
  Widget build(BuildContext context) {
    return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    weatherData!.getThemeColor(),
                    weatherData!.getThemeColor()[400]!,
                    weatherData!.getThemeColor()[300]!,
                    weatherData!.getThemeColor()[100]!,
                    weatherData!.getThemeColor()[50]!,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Center(
                child: Card(
                  margin: EdgeInsets.all(15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      image: DecorationImage(
                        image: AssetImage('assets/images/clouds-1282314_640.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(BlocProvider.of<WeatherCubit>(context).cityName! ,style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold),),
                        Text('updated at : ${weatherData!.date.hour}:${weatherData!.date.minute}'
                            ,style: TextStyle(fontSize: 22),),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.network('https:${weatherData!.icon}'),
                            Text(weatherData?.temp.toInt().toString() ?? '',style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold),),
                            Column(
                              children: [
                                Text('minTemp : ${weatherData?.maxTemp.toInt().toString() ?? ''}  ',style: TextStyle(fontSize: 18)),
                                Text('maxTemp : ${weatherData?.minTemp.toInt().toString() ?? ''}',style: TextStyle(fontSize: 18))
                              ],
                            ),
                          ],
                        ),
                        Text(weatherData?.weatherState ?? '',style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold),),
                      ],
                    ),
                  ),
                ),
              ),
            );
  }
}
