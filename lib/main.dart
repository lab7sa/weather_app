import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'GetLocation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(WeatherApp());

class WeatherApp extends StatefulWidget {
  @override
  _WeatherAppState createState() => _WeatherAppState();
}

class _WeatherAppState extends State<WeatherApp> {
  //Create an account at https://openweathermap.org/
  //then remove XXXXXXXXX and add you api key here
  
  String apiKey = 'XXXXXXXXX';
  var description;
  var temp;
  String city;

  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: <Widget>[
            Container(
              child: displayImage(),//Image.asset('images/dayTime.jpg'),
            ),
            //SizedBox(height: 50.0,),
            Container(
              margin: EdgeInsets.only(top: 50.0),
              child: Text('You are in:', style:
                TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[500],
                ),),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                children: <Widget>[
                  Container(
                    child: Text(city.toString(), style:
                      TextStyle(
                        fontSize: 35.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[500],
                      ),),
                  ),
                  SizedBox(width: 10.0,),
                  Container(
                    child: Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 35.0,
                    ),
                  ),
                ],
              ),
            ),
            Card(

              color: Colors.white,
              margin: EdgeInsets.symmetric(vertical: 17.0, horizontal: 25.0),

              child: ListTile(

                leading: Icon(
                  Icons.wb_sunny,
                  color: Colors.amber,
                ),

                title: Text(
                  'Temperature: ${temp.toString()} C',
                ),
                subtitle: Text('Status: ${description.toString()}'),
              ),
            ),
            Container(
              child: Center(
                child: FlatButton(
                  child: Text('Get weather info'),
                  color: Colors.blue[500],
                  textColor: Colors.white,
                  onPressed: (){
                    setState(() {
                      getLocation();
                    });
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  //display images baed on current time
  displayImage(){
    var now = DateTime.now();
    final currentTime = DateFormat.jm().format(now);
    if(currentTime.contains('AM')){

      return Image.asset('images/dayTime.jpg');
    }else if(currentTime.contains('PM')){
      return Image.asset('images/nightTime.jpg');
    }
  }


  //getLocation
  void getLocation() async{
    Getlocation getlocation = Getlocation();
    await getlocation.getCurrentLocation();

    print(getlocation.latitude);
    print(getlocation.longitude);
    print(getlocation.city);
    city = getlocation.city;
    getTemp(getlocation.latitude, getlocation.longitude);
  }


  //Get current temp
  Future<void> getTemp(double lat, double lon) async{
    http.Response response = await http.get('https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric');
    print(response.body);

    var dataDecoded = jsonDecode(response.body);
    description = dataDecoded['weather'][0]['description'];
    temp = dataDecoded['main']['temp'];
    print(temp);


  }











}

