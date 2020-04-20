
import 'package:geolocator/geolocator.dart';

class Getlocation{
  double latitude;
  double longitude;
  String city;
  //Get current location
  Future<void> getCurrentLocation() async{
    try{
      Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      latitude = position.latitude;
      longitude = position.longitude;

      city = await getCityName(position.latitude, position.longitude);

    }catch(e){
      print(e);
    }
  }

  //Get city name
  Future<String> getCityName(double lat, double lon) async{
    List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(lat, lon);
    print('city name is: ${placemark[0].locality}');
    return placemark[0].locality;
  }
}