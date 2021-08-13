import '../services/location.dart';
import '../services/networking.dart';

const apiKey = '2ac386a95a028e80a306c26f75efd0af';
const openWatherMapURL = 'http://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getCityWather(String cityName) async {
    String url = '$openWatherMapURL?q=$cityName&appid=$apiKey&units=metric';
    var weatherData = await NetworkingHelper(url: url).getData();
    print(weatherData);
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    String apiUrl =
        '$openWatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric';
    NetworkingHelper networkingHelper = NetworkingHelper(url: apiUrl);
    var weatherData = await networkingHelper.getData();
    print(weatherData);
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(double temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }

  String getBackground(String weatherCondition) {
    if (weatherCondition == 'Clear') {
      return 'sun.jpg';
    } else if (weatherCondition == 'Clouds') {
      return 'cloudy.jpg';
    } else if (weatherCondition == 'Rain') {
      return 'rainy.jpg';
    } else if (weatherCondition == 'Snow') {
      return 'snowy.jpg';
    } else if (weatherCondition == 'Haze') {
      return 'hazy-min.jpg';
    } else {
      return 'rainy.jpg';
    }
  }
}
