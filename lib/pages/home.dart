import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

// class ScreenArguments {
//   final String location;
//   final String flag;
//   final String time;
//   final bool isDayTime;

//   ScreenArguments(this.location, this.flag, this.time, this.isDayTime);
// }

class _HomeState extends State<Home> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty
        ? data
        : ModalRoute.of(context).settings.arguments as Map;
    // final loc = data.location;
    // print("==> $loc");

    //* set background
    String bgImage = data['isDayTime'] ? 'day.jpg' : 'night.jpg';
    Color bgColor =
        data['isDayTime'] ? Colors.indigo[300] : Colors.blueGrey[900];

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/$bgImage'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 30.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton.icon(
                      onPressed: () async {
                        dynamic result =
                            await Navigator.pushNamed(context, '/location');
                        setState(() {
                          data['location'] = result['location'];
                          data['time'] = result['time'];
                          data['flag'] = result['flag'];
                          data['isDayTime'] = result['isDayTime'];
                        });
                      },
                      icon: Icon(
                        Icons.edit_location,
                        color: data['isDayTime']
                            ? Colors.grey[900]
                            : Colors.grey[300],
                      ),
                      label: Text(
                        "Edit Location",
                        style: TextStyle(
                          color: data['isDayTime']
                              ? Colors.grey[900]
                              : Colors.grey[300],
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          data['location'],
                          style: TextStyle(
                            fontSize: 28.0,
                            letterSpacing: 2.0,
                            color: data['isDayTime']
                                ? Colors.grey[900]
                                : Colors.white,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Text(data['time'],
                        style: TextStyle(
                          fontSize: 68.0,
                          color: data['isDayTime']
                              ? Colors.grey[900]
                              : Colors.white,
                        ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
