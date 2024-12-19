import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/consts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

 final WeatherFactory _wf=WeatherFactory(OPENWEATHER_API_KEY);
 Weather? _weather ;
 
 @override
  void initState() {
    super.initState();
    _wf.currentWeatherByCityName("Kathmandu").then((w){
      setState(() {
        _weather=w;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    if(_weather == null){
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _locationHeader(),
          SizedBox(
            height: MediaQuery.sizeOf(context).height*0.08,
          ),
          _dateTimeInfo(),
           SizedBox(
            height: MediaQuery.sizeOf(context).height*0.05,
          ),
          _weatherIcon(),
            SizedBox(
            height: MediaQuery.sizeOf(context).height*0.02,
          ),
          _currentTemp(),
            SizedBox(
            height: MediaQuery.sizeOf(context).height*0.02,
          ),
          _extraInfo(),
      ],
      ),
    );
  }

  Widget _locationHeader(){
      return Text(_weather?.areaName?? "" ,style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),);
  }

  Widget _dateTimeInfo(){
    DateTime now=_weather!.date!;     //accessing the actual date time object for the weather observation
    return Column(
      children: [
        Text(DateFormat("h:mm a").format(now),style: TextStyle(fontSize: 35),),  //obj given by intl showing the time in which the observation was collected
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(DateFormat("EEEE").format(now),style: TextStyle(fontWeight: FontWeight.w700),
            ),
            
            Text(
              "  ${DateFormat("d.m.y").format(now)}",
              style: TextStyle(fontWeight: FontWeight.w400),
            ) 
          ],
        )
      ],
    );

  }


  Widget _weatherIcon(){
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: MediaQuery.sizeOf(context).height*0.2,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage("http://openweathermap.org/img/wn/${_weather?.weatherIcon}@4x.png"))
        ),

        ),
        Text(_weather?.weatherDescription?? "",
        style: TextStyle(
          color: Colors.black,
          fontSize: 20
        ),),
      ],
    );
  }

  Widget _currentTemp(){
    return Text("${_weather?.temperature?.celsius?.toStringAsFixed(0)}° C",
    style: const TextStyle(
      color: Colors.black,
      fontSize: 90,
      fontWeight: FontWeight.w500,
    ),);
  }

  Widget _extraInfo(){
    return Container(
      width: MediaQuery.sizeOf(context).width*0.80,
      height: MediaQuery.sizeOf(context).height*0.15,
      decoration: BoxDecoration(
        color: Colors.deepPurple,
        borderRadius: BorderRadius.circular(20)
      ),
      padding: EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
                  Text("Max: ${_weather?.tempMax?.celsius?.toStringAsFixed(0)}° C",style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),),
                   Text("Min: ${_weather?.tempMin?.celsius?.toStringAsFixed(0)}° C",style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),)
            ],
          ),
           Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
                  Text("Wind: ${_weather?.windSpeed?.toStringAsFixed(0)}m/s",style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),),
                   Text("Humidity: ${_weather?.humidity?.toStringAsFixed(0)}%",style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),)
            ],
          )
        ],
      ),
    );
  }
}