import 'package:flutter/material.dart';
import 'package:strato_mate/services/world_time.dart';

class ChooseLocation extends StatefulWidget {
  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  List<WorldTime> locations = [
    WorldTime(url: 'Europe/London', location: 'London', flag: 'uk.png'),
    WorldTime(url: 'Europe/Budapest', location: 'Budapest', flag: 'sample.png'),
    WorldTime(url: 'Europe/Berlin', location: 'Athens', flag: 'greece.png'),
    WorldTime(url: 'America/Chicago', location: 'Chicago', flag: 'usa.png'),
    WorldTime(url: 'America/New_York', location: 'New York', flag: 'usa.png'),
    WorldTime(url: 'America/Havana', location: 'Havana', flag: 'usa.png'),
    WorldTime(url: 'America/Phoenix', location: 'Phoenix', flag: 'usa.png'),
    WorldTime(url: 'America/Chicago', location: 'Chicago', flag: 'usa.png'),
    WorldTime(url: 'America/Detroit', location: 'Detroit', flag: 'usa.png'),
    WorldTime(url: 'America/Denver', location: 'Denver', flag: 'usa.png'),
    WorldTime(
        url: 'America/Los_Angeles', location: 'Los Angeles', flag: 'usa.png'),
    WorldTime(
        url: 'America/Puerto_Rico', location: 'Puerto Rico', flag: 'usa.png'),
    WorldTime(
        url: 'Europe/Amsterdam', location: 'Amsterdam', flag: 'sample.png'),
    WorldTime(url: 'Europe/Moscow', location: 'Moscow', flag: 'sample.png'),
    WorldTime(url: 'Europe/Paris', location: 'Paris', flag: 'sample.png'),
    WorldTime(url: 'Africa/Cairo', location: 'Cairo', flag: 'egypt.png'),
    WorldTime(url: 'Asia/Seoul', location: 'Seoul', flag: 'south_korea.png'),
    WorldTime(url: 'Asia/Jakarta', location: 'Jakarta', flag: 'indonesia.png'),
    WorldTime(url: 'Asia/Dhaka', location: 'Dhaka', flag: 'sample.png'),
    WorldTime(url: 'Asia/Kathmandu', location: 'Kathmandu', flag: 'sample.png'),
    WorldTime(url: 'Asia/Kolkata', location: 'Kolkata', flag: 'sample.png'),
    WorldTime(url: 'Asia/Tokyo', location: 'Tokyo', flag: 'sample.png'),
    WorldTime(url: 'Australia/Sydney', location: 'Sydney', flag: 'sample.png'),
    WorldTime(url: 'Europe/Warsaw', location: 'Warsaw', flag: 'sample.png'),
    WorldTime(url: 'Europe/Zurich', location: 'Zurich', flag: 'sample.png'),
    WorldTime(url: 'Antarctica/Vostok', location: 'Vostok', flag: 'sample.png'),
    WorldTime(
        url: 'Pacific/Auckland', location: 'Auckland', flag: 'sample.png'),
  ];

  void updateTime(index) async {
    WorldTime instance = locations[index];
    await instance.getTime();

    //* navigate to home screen
    Navigator.pop(context, {
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'isDayTime': instance.isDayTime,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        title: Text('Choose a Location'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        margin: EdgeInsets.only(top: 10.0),
        child: ListView.builder(
          itemCount: locations.length,
          itemBuilder: (context, index) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 1.0, horizontal: 1.0),
              child: Card(
                child: ListTile(
                  tileColor: Colors.white,
                  onTap: () {
                    updateTime(index);
                  },
                  title: Text(
                    locations[index].location,
                    style: TextStyle(
                      color: Colors.blueGrey[900],
                    ),
                  ),
                  leading: CircleAvatar(
                    backgroundImage:
                        AssetImage('assets/${locations[index].flag}'),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
