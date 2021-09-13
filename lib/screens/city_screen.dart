import 'package:flutter/material.dart';
import 'package:strato_mate/utilities/constants.dart';
import 'package:strato_mate/services/weather.dart';

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  @override
  void initState() {
    super.initState();
  }

  updateUI(String name) {
    setState(() {
      cityName = cityName;
    });
  }

  String cityName = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/city.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 50.0,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(20.0),
                child: TextField(
                  controller: TextEditingController(text: cityName),
                  onChanged: (value) {
                    cityName = value;
                  },
                  onTap: () async {
                    showSearch(context: context, delegate: CitySearch());

                    cityName = await showSearch(
                        context: context, delegate: CitySearch());

                    updateUI(cityName);

                    // print(
                    //     '============================================>Result: $cityName');
                  },
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    hintText: 'Enter Your City Name',
                    hintStyle: TextStyle(
                      color: Colors.black45,
                    ),
                    filled: true,
                    fillColor: Colors.white60,
                    hoverColor: Colors.white,
                    focusColor: Colors.white,
                    icon: Icon(
                      Icons.location_city,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.pop(context, cityName);
                },
                child: Text(
                  'Get Weather',
                  style: kButtonTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//=======================================================

//                  suggestions

// ======================================================
//
//
class CitySearch extends SearchDelegate<String> {
  WeatherModel weatherModel = WeatherModel();

  @override
  List<Widget> buildActions(BuildContext context) => [
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            if (query.isEmpty) {
              close(context, null);
            } else {
              query = '';
              showSuggestions(context);
            }
          },
        )
      ];

  @override
  Widget buildLeading(BuildContext context) => IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => close(context, null),
      );

  @override
  Widget buildResults(BuildContext context) => FutureBuilder<dynamic>(
        future: weatherModel.getCityWather(query),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return Container(
                  color: Colors.black,
                  alignment: Alignment.center,
                  child: Text(
                    'Something went wrong!',
                    style: TextStyle(fontSize: 28, color: Colors.white),
                  ),
                );
              } else {
                // print("==========> ${snapshot.data}");
                return buildResultSuccess(snapshot.data);
                // return Text(query);
              }
          }
        },
      );
  @override
  Widget buildSuggestions(BuildContext context) => Container(
        color: Colors.black,
        child: FutureBuilder<List<String>>(
          future: WeatherModel.searchCities(query: query),
          builder: (context, snapshot) {
            if (query.isEmpty) return buildNoSuggestions();

            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError || snapshot.data.isEmpty) {
                  return buildNoSuggestions();
                } else {
                  return buildSuggestionsSuccess(snapshot.data);
                }
            }
          },
        ),
      );

  Widget buildNoSuggestions() => Center(
        child: Text(
          'No suggestions!',
          style: TextStyle(fontSize: 28, color: Colors.white),
        ),
      );

  Widget buildSuggestionsSuccess(List<String> suggestions) => ListView.builder(
        itemCount: suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = suggestions[index];
          final queryText = suggestion.substring(0, query.length);
          final remainingText = suggestion.substring(query.length);

          return ListTile(
            onTap: () {
              query = suggestion;

              // 1. Show Results
              // showResults(context);

              // 2. Close Search & Return Result
              // close(context, suggestion);

              // Navigator.pop(context, suggestions);
              close(context, suggestion);
              Navigator.pop(context);

              // 3. Navigate to Result Page
              //  Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (BuildContext context) => ResultPage(suggestion),
              //   ),
              // );
            },
            leading: Icon(Icons.location_city),
            // title: Text(suggestion),
            title: RichText(
              text: TextSpan(
                text: queryText,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                children: [
                  TextSpan(
                    text: remainingText,
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );

  Widget buildResultSuccess(dynamic weather) => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF3279e2), Colors.purple],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 65),
          children: [
            Text(
              weather['name'],
              style: TextStyle(
                fontSize: 32,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 72),
            Text(weatherModel.getWeatherIcon(weather['weather'][0]['id']),
                style: TextStyle(color: Colors.white, fontSize: 50),
                textAlign: TextAlign.center),
            const SizedBox(height: 72),
            Text(
              weather['weather'][0]['description'],
              style: TextStyle(
                fontSize: 20,
                color: Colors.white70,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            buildDegrees(weather),
          ],
        ),
      );

  Widget buildDegrees(dynamic weather) {
    final style = TextStyle(
      fontSize: 100,
      fontWeight: FontWeight.bold,
      color: Colors.white,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Opacity(
          opacity: 0,
          child: Text('°', style: style),
        ),
        Text('${weather['main']['temp']}°', style: style),
      ],
    );
  }
}
