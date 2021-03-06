import 'package:flutter/material.dart';
import 'package:strato_mate/models/task.dart';
import 'package:strato_mate/screens/loading_screen.dart';
import 'package:strato_mate/screens/task_screen.dart';
import 'package:strato_mate/utilities/constants.dart';
import '../services/weather.dart';
import 'city_screen.dart';
import 'dart:ui';
import 'package:flutter_weather_bg/bg/weather_bg.dart';
import 'package:flutter_weather_bg/flutter_weather_bg.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.weatherData});
  final weatherData;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  double tem;
  String weatherIcon;
  String city;
  String message;
  String bgImage;

  dynamic weatherCondition;
  dynamic weatherDesc;
  dynamic feelsLike;
  dynamic country;
  dynamic tempMax;
  dynamic tempMin;
  dynamic pressure;
  dynamic windSpeed;
  dynamic humidity;
  // WeatherType weatherType = WeatherType.heavyRainy;
  WeatherType weatherType = WeatherType.heavySnow;
  WeatherModel weatherModel = WeatherModel();
  @override
  void initState() {
    super.initState();
    updateUI(widget.weatherData);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        tem = 0;
        weatherIcon = '⚠️';
        message = 'Unable to get weather data';
        city = 'your city';
        bgImage = 'snowy.jpg';
        return;
      }
      //* modal bottom sheet data

      windSpeed = weatherData['wind']['speed'];
      weatherDesc = weatherData['weather'][0]['description'];
      feelsLike = weatherData['main']['feels_like'];
      tempMax = weatherData['main']['temp_max'];
      tempMin = weatherData['main']['temp_min'];
      pressure = weatherData['main']['pressure'];
      humidity = weatherData['main']['humidity'];
      country = weatherData['sys']['country'];
      windSpeed = weatherData['wind']['speed'];

      tem = weatherData['main']['temp'];
      int condition = weatherData['weather'][0]['id'];
      city = weatherData['name'];
      weatherCondition = weatherData['weather'][0]['main'];

      weatherIcon = weatherModel.getWeatherIcon(condition);
      message = weatherModel.getMessage(tem);
      bgImage = weatherModel.getBackground(weatherCondition);

      switch (weatherCondition) {
        case "Snow":
          if (condition == 600) {
            weatherType = WeatherType.lightSnow;
          } else if (condition == 601) {
            weatherType = WeatherType.middleSnow;
          } else if (condition == 602) {
            weatherType = WeatherType.heavySnow;
          } else {
            weatherType = WeatherType.heavySnow;
          }
          break;
        case "Thunderstorm":
          weatherType = WeatherType.thunder;
          break;
        case "Haze":
          weatherType = WeatherType.hazy;
          break;
        case "Fog":
          weatherType = WeatherType.foggy;
          break;
        case "Dust":
          weatherType = WeatherType.dusty;
          break;
        case "Clear":
          weatherType = WeatherType.sunny;
          break;
        case "Clouds":
          weatherType = WeatherType.cloudy;
          break;
        case "Mist":
          weatherType = WeatherType.overcast;
          break;
        case "Rain":
          if (condition == 500) {
            weatherType = WeatherType.lightRainy;
          } else if (condition == 501) {
            weatherType = WeatherType.middleRainy;
          } else if (condition == 502 || condition == 503 || condition == 504) {
            weatherType = WeatherType.heavyRainy;
          } else {
            weatherType = WeatherType.heavyRainy;
          }
          break;

        default:
          weatherType = WeatherType.heavySnow;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage('images/$bgImage'),
        //     fit: BoxFit.cover,
        //     colorFilter: ColorFilter.mode(
        //         Colors.white.withOpacity(0.8), BlendMode.dstATop),
        //   ),
        // ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Stack(children: <Widget>[
            WeatherBg(
              weatherType: weatherType,
              width: width,
              height: height,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton(
                      onPressed: () async {
                        var weather = await weatherModel.getLocationWeather();
                        updateUI(weather);
                      },
                      child: Icon(
                        Icons.near_me,
                        size: 50.0,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return TaskScreen();
                            },
                          ),
                        );
                      },
                      child: Icon(
                        Icons.format_list_bulleted_rounded,
                        size: 50.0,
                        color: Colors.white,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/loading');
                      },
                      child: Icon(
                        Icons.access_time,
                        size: 50.0,
                      ),
                    ),
                    FlatButton(
                      onPressed: () async {
                        var typeName = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return CityScreen();
                            },
                          ),
                        );
                        if (typeName != null) {
                          var weatherData =
                              await weatherModel.getCityWather(typeName);

                          updateUI(weatherData);
                        }
                      },
                      child: Icon(
                        Icons.location_city,
                        size: 50.0,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Row(
                    children: <Widget>[
                      TextButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (context) => Container(
                                // color: Color(0xFF757575),
                                color: Colors.transparent,
                                child: Container(
                                  padding: EdgeInsets.only(
                                      top: 40.0, left: 20.0, right: 20.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20.0),
                                      topRight: Radius.circular(20.0),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        'Country:  $country  -  $city',
                                        style: kTextStyle,
                                      ),
                                      SizedBox(
                                        height: 15.0,
                                      ),
                                      Text(
                                        'Weather:   $weatherDesc   $weatherIcon',
                                        style: kTextStyle,
                                      ),
                                      SizedBox(
                                        height: 15.0,
                                      ),
                                      Text(
                                        'Feels Like:   ${feelsLike.toString()} °C',
                                        style: kTextStyle,
                                      ),
                                      SizedBox(
                                        height: 15.0,
                                      ),
                                      Text(
                                        'Temparature Max:   ${tempMax.toString()} °C',
                                        style: kTextStyle,
                                      ),
                                      SizedBox(
                                        height: 15.0,
                                      ),
                                      Text(
                                        'Temparature Min:   ${tempMin.toString()} °C',
                                        style: kTextStyle,
                                      ),
                                      SizedBox(
                                        height: 15.0,
                                      ),
                                      Text(
                                        'Pressure:   ${pressure.toString()} hPa',
                                        style: kTextStyle,
                                      ),
                                      SizedBox(
                                        height: 15.0,
                                      ),
                                      Text(
                                        'Humidity:   ${humidity.toString()} %',
                                        style: kTextStyle,
                                      ),
                                      SizedBox(
                                        height: 15.0,
                                      ),
                                      Text(
                                        'Wind Speed:   ${windSpeed.toString()} mph',
                                        style: kTextStyle,
                                      ),
                                      SizedBox(
                                        height: 15.0,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          child: Text(
                            tem.round().toStringAsFixed(0) + '°',
                            style: kTempTextStyle,
                          )),
                      Text(
                        '$weatherIcon',
                        style: kConditionTextStyle,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 15.0),
                  child: Text(
                    "$message in $city",
                    textAlign: TextAlign.right,
                    style: kMessageTextStyle,
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
